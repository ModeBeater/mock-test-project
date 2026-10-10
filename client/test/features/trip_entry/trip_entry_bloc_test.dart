import 'package:bloc_test/bloc_test.dart';
import 'package:driver_diary/core/error/failure.dart';
import 'package:driver_diary/core/error/result.dart';
import 'package:driver_diary/core/time/zoned_date_time.dart';
import 'package:driver_diary/features/trip_entry/domain/entities/trip_draft.dart';
import 'package:driver_diary/features/trip_entry/domain/entities/trip_entry_outcome.dart';
import 'package:driver_diary/features/trip_entry/domain/repositories/trip_entry_repository.dart';
import 'package:driver_diary/features/trip_entry/domain/usecases/submit_trip.dart';
import 'package:driver_diary/features/trip_entry/presentation/bloc/trip_entry_bloc.dart';
import 'package:driver_diary/shared/domain/payment_method.dart';
import 'package:driver_diary/shared/domain/trip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements TripEntryRepository {}

void main() {
  final draft = TripDraft(
    id: 'draft-1',
    day: DateTime.utc(2026, 10, 1),
    startMinute: 10 * 60,
    endMinute: 10 * 60 + 25,
    utcOffset: const Duration(hours: 5),
  );
  final trip = Trip(
    id: 'draft-1',
    start: ZonedDateTime.parse('2026-10-01T10:00:00+05:00'),
    end: ZonedDateTime.parse('2026-10-01T10:25:00+05:00'),
    amount: 2000,
    payment: PaymentMethod.card,
    commission: 300,
  );
  late _MockRepository repository;

  setUpAll(() => registerFallbackValue(draft));
  setUp(() => repository = _MockRepository());

  TripEntryBloc build() => TripEntryBloc(submitTrip: SubmitTrip(repository), draft: draft);

  blocTest<TripEntryBloc, TripEntryState>(
    'комиссия 15% подставляется, пока её не изменили вручную',
    build: build,
    act: (bloc) => bloc
      ..add(const TripEntryEvent.amountChanged(2000))
      ..add(const TripEntryEvent.commissionChanged(250))
      ..add(const TripEntryEvent.amountChanged(3000)),
    expect: () => [
      TripEntryState(draft: draft.copyWith(amount: 2000, commission: 300)),
      TripEntryState(draft: draft.copyWith(amount: 2000, commission: 250), commissionEdited: true),
      TripEntryState(draft: draft.copyWith(amount: 3000, commission: 250), commissionEdited: true),
    ],
  );

  blocTest<TripEntryBloc, TripEntryState>(
    'незаполненная форма не отправляется и показывает ошибки',
    build: build,
    act: (bloc) => bloc.add(const TripEntryEvent.submitted()),
    expect: () => [TripEntryState(draft: draft, showAllErrors: true)],
    verify: (bloc) {
      expect(bloc.state.visibleErrors, {TripDraftError.amountMissing, TripDraftError.commissionMissing});
      verifyNever(() => repository.submit(any()));
    },
  );

  blocTest<TripEntryBloc, TripEntryState>(
    'успешная отправка завершает форму',
    setUp: () => when(() => repository.submit(any())).thenAnswer((_) async => Ok(TripEntryOutcome.created(trip))),
    build: build,
    act: (bloc) => bloc
      ..add(const TripEntryEvent.amountChanged(2000))
      ..add(const TripEntryEvent.submitted()),
    verify: (bloc) {
      expect(bloc.state.status, TripEntryStatus.done);
      expect(bloc.state.outcome, TripEntryOutcome.created(trip));
    },
  );

  blocTest<TripEntryBloc, TripEntryState>(
    'после ошибки сети повторная отправка уходит с тем же id',
    setUp: () {
      var calls = 0;
      when(() => repository.submit(any())).thenAnswer(
        (_) async => ++calls == 1 ? const Err(Failure.noConnection()) : Ok(TripEntryOutcome.alreadySaved(trip)),
      );
    },
    build: build,
    act: (bloc) async {
      bloc
        ..add(const TripEntryEvent.amountChanged(2000))
        ..add(const TripEntryEvent.submitted());
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.failure, const Failure.noConnection());
      expect(bloc.state.status, TripEntryStatus.editing);
      bloc.add(const TripEntryEvent.submitted());
    },
    verify: (bloc) {
      final sent = verify(() => repository.submit(captureAny())).captured.cast<TripDraft>();
      expect(sent.map((d) => d.id), ['draft-1', 'draft-1']);
      expect(bloc.state.outcome, isA<TripAlreadySaved>());
    },
  );

  blocTest<TripEntryBloc, TripEntryState>(
    'конфликт оставляет форму открытой; правка сбрасывает сообщение',
    setUp: () => when(() => repository.submit(any()))
        .thenAnswer((_) async => Ok(TripEntryOutcome.conflict(ConflictKind.overlap, trip))),
    build: build,
    act: (bloc) async {
      bloc
        ..add(const TripEntryEvent.amountChanged(2000))
        ..add(const TripEntryEvent.submitted());
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.conflict, TripEntryOutcome.conflict(ConflictKind.overlap, trip));
      expect(bloc.state.status, TripEntryStatus.editing);
      bloc.add(const TripEntryEvent.startChanged(11 * 60));
    },
    verify: (bloc) => expect(bloc.state.conflict, isNull),
  );
}
