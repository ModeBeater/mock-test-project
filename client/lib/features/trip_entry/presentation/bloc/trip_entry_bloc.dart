import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../shared/domain/payment_method.dart';
import '../../domain/entities/trip_draft.dart';
import '../../domain/entities/trip_entry_outcome.dart';
import '../../domain/usecases/submit_trip.dart';

part 'trip_entry_bloc.freezed.dart';
part 'trip_entry_event.dart';
part 'trip_entry_state.dart';

class TripEntryBloc extends Bloc<TripEntryEvent, TripEntryState> {
  TripEntryBloc({required SubmitTrip submitTrip, required TripDraft draft})
      : _submitTrip = submitTrip,
        super(TripEntryState(draft: draft)) {
    on<TripEntryAmountChanged>((e, emit) => _edit(emit, (d) {
          // Пока водитель не трогал комиссию, она следует за суммой.
          if (state.commissionEdited) return d.copyWith(amount: e.amount);
          final commission = e.amount == null ? null : TripDraft.suggestedCommission(e.amount!);
          return d.copyWith(amount: e.amount, commission: commission);
        }));
    on<TripEntryCommissionChanged>(
      (e, emit) => _edit(emit, (d) => d.copyWith(commission: e.commission), commissionEdited: true),
    );
    on<TripEntryPaymentChanged>((e, emit) => _edit(emit, (d) => d.copyWith(payment: e.payment)));
    on<TripEntryDayChanged>((e, emit) => _edit(emit, (d) => d.copyWith(day: e.day)));
    on<TripEntryStartChanged>((e, emit) => _edit(emit, (d) => d.copyWith(startMinute: e.minute)));
    on<TripEntryEndChanged>((e, emit) => _edit(emit, (d) => d.copyWith(endMinute: e.minute)));
    // droppable: пока запрос в пути, повторные нажатия «Сохранить» игнорируются.
    on<TripEntrySubmitted>(_onSubmitted, transformer: droppable());
  }

  final SubmitTrip _submitTrip;

  void _edit(Emitter<TripEntryState> emit, TripDraft Function(TripDraft) change, {bool? commissionEdited}) {
    emit(state.copyWith(
      draft: change(state.draft),
      commissionEdited: commissionEdited ?? state.commissionEdited,
      conflict: null,
      failure: null,
    ));
  }

  Future<void> _onSubmitted(TripEntrySubmitted event, Emitter<TripEntryState> emit) async {
    emit(state.copyWith(showAllErrors: true));
    if (state.draft.validate().isNotEmpty) return;

    emit(state.copyWith(status: TripEntryStatus.submitting, conflict: null, failure: null));
    // id черновика не меняется: если ответ потерялся, повторная отправка не создаст дубль.
    final result = await _submitTrip(state.draft);
    emit(switch (result) {
      Ok(value: final TripConflict conflict) => state.copyWith(status: TripEntryStatus.editing, conflict: conflict),
      Ok(:final value) => state.copyWith(status: TripEntryStatus.done, outcome: value),
      Err(:final failure) => state.copyWith(status: TripEntryStatus.editing, failure: failure),
    });
  }
}
