// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEntryEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TripEntryEvent()';
}


}

/// @nodoc
class $TripEntryEventCopyWith<$Res>  {
$TripEntryEventCopyWith(TripEntryEvent _, $Res Function(TripEntryEvent) __);
}


/// Adds pattern-matching-related methods to [TripEntryEvent].
extension TripEntryEventPatterns on TripEntryEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TripEntryAmountChanged value)?  amountChanged,TResult Function( TripEntryCommissionChanged value)?  commissionChanged,TResult Function( TripEntryPaymentChanged value)?  paymentChanged,TResult Function( TripEntryDayChanged value)?  dayChanged,TResult Function( TripEntryStartChanged value)?  startChanged,TResult Function( TripEntryEndChanged value)?  endChanged,TResult Function( TripEntrySubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TripEntryAmountChanged() when amountChanged != null:
return amountChanged(_that);case TripEntryCommissionChanged() when commissionChanged != null:
return commissionChanged(_that);case TripEntryPaymentChanged() when paymentChanged != null:
return paymentChanged(_that);case TripEntryDayChanged() when dayChanged != null:
return dayChanged(_that);case TripEntryStartChanged() when startChanged != null:
return startChanged(_that);case TripEntryEndChanged() when endChanged != null:
return endChanged(_that);case TripEntrySubmitted() when submitted != null:
return submitted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TripEntryAmountChanged value)  amountChanged,required TResult Function( TripEntryCommissionChanged value)  commissionChanged,required TResult Function( TripEntryPaymentChanged value)  paymentChanged,required TResult Function( TripEntryDayChanged value)  dayChanged,required TResult Function( TripEntryStartChanged value)  startChanged,required TResult Function( TripEntryEndChanged value)  endChanged,required TResult Function( TripEntrySubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case TripEntryAmountChanged():
return amountChanged(_that);case TripEntryCommissionChanged():
return commissionChanged(_that);case TripEntryPaymentChanged():
return paymentChanged(_that);case TripEntryDayChanged():
return dayChanged(_that);case TripEntryStartChanged():
return startChanged(_that);case TripEntryEndChanged():
return endChanged(_that);case TripEntrySubmitted():
return submitted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TripEntryAmountChanged value)?  amountChanged,TResult? Function( TripEntryCommissionChanged value)?  commissionChanged,TResult? Function( TripEntryPaymentChanged value)?  paymentChanged,TResult? Function( TripEntryDayChanged value)?  dayChanged,TResult? Function( TripEntryStartChanged value)?  startChanged,TResult? Function( TripEntryEndChanged value)?  endChanged,TResult? Function( TripEntrySubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case TripEntryAmountChanged() when amountChanged != null:
return amountChanged(_that);case TripEntryCommissionChanged() when commissionChanged != null:
return commissionChanged(_that);case TripEntryPaymentChanged() when paymentChanged != null:
return paymentChanged(_that);case TripEntryDayChanged() when dayChanged != null:
return dayChanged(_that);case TripEntryStartChanged() when startChanged != null:
return startChanged(_that);case TripEntryEndChanged() when endChanged != null:
return endChanged(_that);case TripEntrySubmitted() when submitted != null:
return submitted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? amount)?  amountChanged,TResult Function( int? commission)?  commissionChanged,TResult Function( PaymentMethod payment)?  paymentChanged,TResult Function( DateTime day)?  dayChanged,TResult Function( int minute)?  startChanged,TResult Function( int minute)?  endChanged,TResult Function()?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TripEntryAmountChanged() when amountChanged != null:
return amountChanged(_that.amount);case TripEntryCommissionChanged() when commissionChanged != null:
return commissionChanged(_that.commission);case TripEntryPaymentChanged() when paymentChanged != null:
return paymentChanged(_that.payment);case TripEntryDayChanged() when dayChanged != null:
return dayChanged(_that.day);case TripEntryStartChanged() when startChanged != null:
return startChanged(_that.minute);case TripEntryEndChanged() when endChanged != null:
return endChanged(_that.minute);case TripEntrySubmitted() when submitted != null:
return submitted();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? amount)  amountChanged,required TResult Function( int? commission)  commissionChanged,required TResult Function( PaymentMethod payment)  paymentChanged,required TResult Function( DateTime day)  dayChanged,required TResult Function( int minute)  startChanged,required TResult Function( int minute)  endChanged,required TResult Function()  submitted,}) {final _that = this;
switch (_that) {
case TripEntryAmountChanged():
return amountChanged(_that.amount);case TripEntryCommissionChanged():
return commissionChanged(_that.commission);case TripEntryPaymentChanged():
return paymentChanged(_that.payment);case TripEntryDayChanged():
return dayChanged(_that.day);case TripEntryStartChanged():
return startChanged(_that.minute);case TripEntryEndChanged():
return endChanged(_that.minute);case TripEntrySubmitted():
return submitted();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? amount)?  amountChanged,TResult? Function( int? commission)?  commissionChanged,TResult? Function( PaymentMethod payment)?  paymentChanged,TResult? Function( DateTime day)?  dayChanged,TResult? Function( int minute)?  startChanged,TResult? Function( int minute)?  endChanged,TResult? Function()?  submitted,}) {final _that = this;
switch (_that) {
case TripEntryAmountChanged() when amountChanged != null:
return amountChanged(_that.amount);case TripEntryCommissionChanged() when commissionChanged != null:
return commissionChanged(_that.commission);case TripEntryPaymentChanged() when paymentChanged != null:
return paymentChanged(_that.payment);case TripEntryDayChanged() when dayChanged != null:
return dayChanged(_that.day);case TripEntryStartChanged() when startChanged != null:
return startChanged(_that.minute);case TripEntryEndChanged() when endChanged != null:
return endChanged(_that.minute);case TripEntrySubmitted() when submitted != null:
return submitted();case _:
  return null;

}
}

}

/// @nodoc


class TripEntryAmountChanged implements TripEntryEvent {
  const TripEntryAmountChanged(this.amount);
  

 final  int? amount;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryAmountChangedCopyWith<TripEntryAmountChanged> get copyWith => _$TripEntryAmountChangedCopyWithImpl<TripEntryAmountChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryAmountChanged&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,amount);
}

@override
String toString() {
    return 'TripEntryEvent.amountChanged(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $TripEntryAmountChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryAmountChangedCopyWith(TripEntryAmountChanged value, $Res Function(TripEntryAmountChanged) _then) = _$TripEntryAmountChangedCopyWithImpl;
@useResult
$Res call({
 int? amount
});




}
/// @nodoc
class _$TripEntryAmountChangedCopyWithImpl<$Res>
    implements $TripEntryAmountChangedCopyWith<$Res> {
  _$TripEntryAmountChangedCopyWithImpl(this._self, this._then);

  final TripEntryAmountChanged _self;
  final $Res Function(TripEntryAmountChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = freezed,}) {
  return _then(TripEntryAmountChanged(
freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class TripEntryCommissionChanged implements TripEntryEvent {
  const TripEntryCommissionChanged(this.commission);
  

 final  int? commission;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryCommissionChangedCopyWith<TripEntryCommissionChanged> get copyWith => _$TripEntryCommissionChangedCopyWithImpl<TripEntryCommissionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryCommissionChanged&&(identical(other.commission, commission) || other.commission == commission));
}


@override
int get hashCode {
    return Object.hash(runtimeType,commission);
}

@override
String toString() {
    return 'TripEntryEvent.commissionChanged(commission: $commission)';
}


}

/// @nodoc
abstract mixin class $TripEntryCommissionChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryCommissionChangedCopyWith(TripEntryCommissionChanged value, $Res Function(TripEntryCommissionChanged) _then) = _$TripEntryCommissionChangedCopyWithImpl;
@useResult
$Res call({
 int? commission
});




}
/// @nodoc
class _$TripEntryCommissionChangedCopyWithImpl<$Res>
    implements $TripEntryCommissionChangedCopyWith<$Res> {
  _$TripEntryCommissionChangedCopyWithImpl(this._self, this._then);

  final TripEntryCommissionChanged _self;
  final $Res Function(TripEntryCommissionChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? commission = freezed,}) {
  return _then(TripEntryCommissionChanged(
freezed == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class TripEntryPaymentChanged implements TripEntryEvent {
  const TripEntryPaymentChanged(this.payment);
  

 final  PaymentMethod payment;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryPaymentChangedCopyWith<TripEntryPaymentChanged> get copyWith => _$TripEntryPaymentChangedCopyWithImpl<TripEntryPaymentChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryPaymentChanged&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,payment);
}

@override
String toString() {
    return 'TripEntryEvent.paymentChanged(payment: $payment)';
}


}

/// @nodoc
abstract mixin class $TripEntryPaymentChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryPaymentChangedCopyWith(TripEntryPaymentChanged value, $Res Function(TripEntryPaymentChanged) _then) = _$TripEntryPaymentChangedCopyWithImpl;
@useResult
$Res call({
 PaymentMethod payment
});




}
/// @nodoc
class _$TripEntryPaymentChangedCopyWithImpl<$Res>
    implements $TripEntryPaymentChangedCopyWith<$Res> {
  _$TripEntryPaymentChangedCopyWithImpl(this._self, this._then);

  final TripEntryPaymentChanged _self;
  final $Res Function(TripEntryPaymentChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payment = null,}) {
  return _then(TripEntryPaymentChanged(
null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}


}

/// @nodoc


class TripEntryDayChanged implements TripEntryEvent {
  const TripEntryDayChanged(this.day);
  

 final  DateTime day;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryDayChangedCopyWith<TripEntryDayChanged> get copyWith => _$TripEntryDayChangedCopyWithImpl<TripEntryDayChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryDayChanged&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day);
}

@override
String toString() {
    return 'TripEntryEvent.dayChanged(day: $day)';
}


}

/// @nodoc
abstract mixin class $TripEntryDayChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryDayChangedCopyWith(TripEntryDayChanged value, $Res Function(TripEntryDayChanged) _then) = _$TripEntryDayChangedCopyWithImpl;
@useResult
$Res call({
 DateTime day
});




}
/// @nodoc
class _$TripEntryDayChangedCopyWithImpl<$Res>
    implements $TripEntryDayChangedCopyWith<$Res> {
  _$TripEntryDayChangedCopyWithImpl(this._self, this._then);

  final TripEntryDayChanged _self;
  final $Res Function(TripEntryDayChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? day = null,}) {
  return _then(TripEntryDayChanged(
null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class TripEntryStartChanged implements TripEntryEvent {
  const TripEntryStartChanged(this.minute);
  

 final  int minute;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryStartChangedCopyWith<TripEntryStartChanged> get copyWith => _$TripEntryStartChangedCopyWithImpl<TripEntryStartChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryStartChanged&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode {
    return Object.hash(runtimeType,minute);
}

@override
String toString() {
    return 'TripEntryEvent.startChanged(minute: $minute)';
}


}

/// @nodoc
abstract mixin class $TripEntryStartChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryStartChangedCopyWith(TripEntryStartChanged value, $Res Function(TripEntryStartChanged) _then) = _$TripEntryStartChangedCopyWithImpl;
@useResult
$Res call({
 int minute
});




}
/// @nodoc
class _$TripEntryStartChangedCopyWithImpl<$Res>
    implements $TripEntryStartChangedCopyWith<$Res> {
  _$TripEntryStartChangedCopyWithImpl(this._self, this._then);

  final TripEntryStartChanged _self;
  final $Res Function(TripEntryStartChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minute = null,}) {
  return _then(TripEntryStartChanged(
null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TripEntryEndChanged implements TripEntryEvent {
  const TripEntryEndChanged(this.minute);
  

 final  int minute;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryEndChangedCopyWith<TripEntryEndChanged> get copyWith => _$TripEntryEndChangedCopyWithImpl<TripEntryEndChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryEndChanged&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode {
    return Object.hash(runtimeType,minute);
}

@override
String toString() {
    return 'TripEntryEvent.endChanged(minute: $minute)';
}


}

/// @nodoc
abstract mixin class $TripEntryEndChangedCopyWith<$Res> implements $TripEntryEventCopyWith<$Res> {
  factory $TripEntryEndChangedCopyWith(TripEntryEndChanged value, $Res Function(TripEntryEndChanged) _then) = _$TripEntryEndChangedCopyWithImpl;
@useResult
$Res call({
 int minute
});




}
/// @nodoc
class _$TripEntryEndChangedCopyWithImpl<$Res>
    implements $TripEntryEndChangedCopyWith<$Res> {
  _$TripEntryEndChangedCopyWithImpl(this._self, this._then);

  final TripEntryEndChanged _self;
  final $Res Function(TripEntryEndChanged) _then;

/// Create a copy of TripEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minute = null,}) {
  return _then(TripEntryEndChanged(
null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TripEntrySubmitted implements TripEntryEvent {
  const TripEntrySubmitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntrySubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TripEntryEvent.submitted()';
}


}




/// @nodoc
mixin _$TripEntryState {

 TripDraft get draft; TripEntryStatus get status;/// Водитель сам изменил комиссию — больше не подставляем 15%.
 bool get commissionEdited;/// После первой попытки сохранить показываем и ошибки незаполненных полей.
 bool get showAllErrors;/// created или alreadySaved — когда status == done.
 TripEntryOutcome? get outcome; TripConflict? get conflict; Failure? get failure;
/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntryStateCopyWith<TripEntryState> get copyWith => _$TripEntryStateCopyWithImpl<TripEntryState>(this as TripEntryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TripEntryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryState&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.commissionEdited, _this.commissionEdited) || other.commissionEdited == _this.commissionEdited)&&(identical(other.showAllErrors, _this.showAllErrors) || other.showAllErrors == _this.showAllErrors)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&const DeepCollectionEquality().equals(other.conflict, _this.conflict)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as TripEntryState;
  return Object.hash(runtimeType,_this.draft,_this.status,_this.commissionEdited,_this.showAllErrors,_this.outcome,const DeepCollectionEquality().hash(_this.conflict),_this.failure);
}

@override
String toString() {
  final _this = this as TripEntryState;
  return 'TripEntryState(draft: ${_this.draft}, status: ${_this.status}, commissionEdited: ${_this.commissionEdited}, showAllErrors: ${_this.showAllErrors}, outcome: ${_this.outcome}, conflict: ${_this.conflict}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $TripEntryStateCopyWith<$Res>  {
  factory $TripEntryStateCopyWith(TripEntryState value, $Res Function(TripEntryState) _then) = _$TripEntryStateCopyWithImpl;
@useResult
$Res call({
 TripDraft draft, TripEntryStatus status, bool commissionEdited, bool showAllErrors, TripEntryOutcome? outcome, TripConflict? conflict, Failure? failure
});


$TripDraftCopyWith<$Res> get draft;$TripEntryOutcomeCopyWith<$Res>? get outcome;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$TripEntryStateCopyWithImpl<$Res>
    implements $TripEntryStateCopyWith<$Res> {
  _$TripEntryStateCopyWithImpl(this._self, this._then);

  final TripEntryState _self;
  final $Res Function(TripEntryState) _then;

/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? status = null,Object? commissionEdited = null,Object? showAllErrors = null,Object? outcome = freezed,Object? conflict = freezed,Object? failure = freezed,}) {
  return _then(TripEntryState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TripDraft,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripEntryStatus,commissionEdited: null == commissionEdited ? _self.commissionEdited : commissionEdited // ignore: cast_nullable_to_non_nullable
as bool,showAllErrors: null == showAllErrors ? _self.showAllErrors : showAllErrors // ignore: cast_nullable_to_non_nullable
as bool,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as TripEntryOutcome?,conflict: freezed == conflict ? _self.conflict : conflict // ignore: cast_nullable_to_non_nullable
as TripConflict?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDraftCopyWith<$Res> get draft {
  
  return $TripDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEntryOutcomeCopyWith<$Res>? get outcome {
    if (_self.outcome == null) {
    return null;
  }

  return $TripEntryOutcomeCopyWith<$Res>(_self.outcome!, (value) {
    return _then(_self.copyWith(outcome: value));
  });
}/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripEntryState].
extension TripEntryStatePatterns on TripEntryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEntryState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEntryState value)  $default,){
final _that = this;
switch (_that) {
case _TripEntryState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _TripEntryState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripDraft draft,  TripEntryStatus status,  bool commissionEdited,  bool showAllErrors,  TripEntryOutcome? outcome,  TripConflict? conflict,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEntryState() when $default != null:
return $default(_that.draft,_that.status,_that.commissionEdited,_that.showAllErrors,_that.outcome,_that.conflict,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripDraft draft,  TripEntryStatus status,  bool commissionEdited,  bool showAllErrors,  TripEntryOutcome? outcome,  TripConflict? conflict,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _TripEntryState():
return $default(_that.draft,_that.status,_that.commissionEdited,_that.showAllErrors,_that.outcome,_that.conflict,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripDraft draft,  TripEntryStatus status,  bool commissionEdited,  bool showAllErrors,  TripEntryOutcome? outcome,  TripConflict? conflict,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _TripEntryState() when $default != null:
return $default(_that.draft,_that.status,_that.commissionEdited,_that.showAllErrors,_that.outcome,_that.conflict,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TripEntryState extends TripEntryState {
  const _TripEntryState({required this.draft, this.status = TripEntryStatus.editing, this.commissionEdited = false, this.showAllErrors = false, this.outcome, this.conflict, this.failure}): super._();
  

@override final  TripDraft draft;
@override@JsonKey() final  TripEntryStatus status;
/// Водитель сам изменил комиссию — больше не подставляем 15%.
@override@JsonKey() final  bool commissionEdited;
/// После первой попытки сохранить показываем и ошибки незаполненных полей.
@override@JsonKey() final  bool showAllErrors;
/// created или alreadySaved — когда status == done.
@override final  TripEntryOutcome? outcome;
@override final  TripConflict? conflict;
@override final  Failure? failure;

/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEntryStateCopyWith<_TripEntryState> get copyWith => __$TripEntryStateCopyWithImpl<_TripEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEntryState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.status, status) || other.status == status)&&(identical(other.commissionEdited, commissionEdited) || other.commissionEdited == commissionEdited)&&(identical(other.showAllErrors, showAllErrors) || other.showAllErrors == showAllErrors)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&const DeepCollectionEquality().equals(other.conflict, conflict)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft,status,commissionEdited,showAllErrors,outcome,const DeepCollectionEquality().hash(conflict),failure);
}

@override
String toString() {
    return 'TripEntryState(draft: $draft, status: $status, commissionEdited: $commissionEdited, showAllErrors: $showAllErrors, outcome: $outcome, conflict: $conflict, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TripEntryStateCopyWith<$Res> implements $TripEntryStateCopyWith<$Res> {
  factory _$TripEntryStateCopyWith(_TripEntryState value, $Res Function(_TripEntryState) _then) = __$TripEntryStateCopyWithImpl;
@override @useResult
$Res call({
 TripDraft draft, TripEntryStatus status, bool commissionEdited, bool showAllErrors, TripEntryOutcome? outcome, TripConflict? conflict, Failure? failure
});


@override $TripDraftCopyWith<$Res> get draft;@override $TripEntryOutcomeCopyWith<$Res>? get outcome;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$TripEntryStateCopyWithImpl<$Res>
    implements _$TripEntryStateCopyWith<$Res> {
  __$TripEntryStateCopyWithImpl(this._self, this._then);

  final _TripEntryState _self;
  final $Res Function(_TripEntryState) _then;

/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? status = null,Object? commissionEdited = null,Object? showAllErrors = null,Object? outcome = freezed,Object? conflict = freezed,Object? failure = freezed,}) {
  return _then(_TripEntryState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TripDraft,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripEntryStatus,commissionEdited: null == commissionEdited ? _self.commissionEdited : commissionEdited // ignore: cast_nullable_to_non_nullable
as bool,showAllErrors: null == showAllErrors ? _self.showAllErrors : showAllErrors // ignore: cast_nullable_to_non_nullable
as bool,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as TripEntryOutcome?,conflict: freezed == conflict ? _self.conflict : conflict // ignore: cast_nullable_to_non_nullable
as TripConflict?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDraftCopyWith<$Res> get draft {
  
  return $TripDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEntryOutcomeCopyWith<$Res>? get outcome {
    if (_self.outcome == null) {
    return null;
  }

  return $TripEntryOutcomeCopyWith<$Res>(_self.outcome!, (value) {
    return _then(_self.copyWith(outcome: value));
  });
}/// Create a copy of TripEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
