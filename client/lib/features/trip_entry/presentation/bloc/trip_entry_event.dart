part of 'trip_entry_bloc.dart';

@freezed
sealed class TripEntryEvent with _$TripEntryEvent {
  const factory TripEntryEvent.amountChanged(int? amount) = TripEntryAmountChanged;
  const factory TripEntryEvent.commissionChanged(int? commission) = TripEntryCommissionChanged;
  const factory TripEntryEvent.paymentChanged(PaymentMethod payment) = TripEntryPaymentChanged;
  const factory TripEntryEvent.dayChanged(DateTime day) = TripEntryDayChanged;
  const factory TripEntryEvent.startChanged(int minute) = TripEntryStartChanged;
  const factory TripEntryEvent.endChanged(int minute) = TripEntryEndChanged;
  const factory TripEntryEvent.submitted() = TripEntrySubmitted;
}
