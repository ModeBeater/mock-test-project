// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripDraft {

/// Ключ идемпотентности: создаётся вместе с черновиком и не меняется при повторной отправке.
 String get id; DateTime get day; int get startMinute; int get endMinute; Duration get utcOffset; int? get amount; int? get commission; PaymentMethod get payment;
/// Create a copy of TripDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDraftCopyWith<TripDraft> get copyWith => _$TripDraftCopyWithImpl<TripDraft>(this as TripDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TripDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDraft&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.startMinute, _this.startMinute) || other.startMinute == _this.startMinute)&&(identical(other.endMinute, _this.endMinute) || other.endMinute == _this.endMinute)&&(identical(other.utcOffset, _this.utcOffset) || other.utcOffset == _this.utcOffset)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.commission, _this.commission) || other.commission == _this.commission)&&(identical(other.payment, _this.payment) || other.payment == _this.payment));
}


@override
int get hashCode {
  final _this = this as TripDraft;
  return Object.hash(runtimeType,_this.id,_this.day,_this.startMinute,_this.endMinute,_this.utcOffset,_this.amount,_this.commission,_this.payment);
}

@override
String toString() {
  final _this = this as TripDraft;
  return 'TripDraft(id: ${_this.id}, day: ${_this.day}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute}, utcOffset: ${_this.utcOffset}, amount: ${_this.amount}, commission: ${_this.commission}, payment: ${_this.payment})';
}


}

/// @nodoc
abstract mixin class $TripDraftCopyWith<$Res>  {
  factory $TripDraftCopyWith(TripDraft value, $Res Function(TripDraft) _then) = _$TripDraftCopyWithImpl;
@useResult
$Res call({
 String id, DateTime day, int startMinute, int endMinute, Duration utcOffset, int? amount, int? commission, PaymentMethod payment
});




}
/// @nodoc
class _$TripDraftCopyWithImpl<$Res>
    implements $TripDraftCopyWith<$Res> {
  _$TripDraftCopyWithImpl(this._self, this._then);

  final TripDraft _self;
  final $Res Function(TripDraft) _then;

/// Create a copy of TripDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? day = null,Object? startMinute = null,Object? endMinute = null,Object? utcOffset = null,Object? amount = freezed,Object? commission = freezed,Object? payment = null,}) {
  return _then(TripDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,commission: freezed == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int?,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDraft].
extension TripDraftPatterns on TripDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDraft value)  $default,){
final _that = this;
switch (_that) {
case _TripDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDraft value)?  $default,){
final _that = this;
switch (_that) {
case _TripDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime day,  int startMinute,  int endMinute,  Duration utcOffset,  int? amount,  int? commission,  PaymentMethod payment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDraft() when $default != null:
return $default(_that.id,_that.day,_that.startMinute,_that.endMinute,_that.utcOffset,_that.amount,_that.commission,_that.payment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime day,  int startMinute,  int endMinute,  Duration utcOffset,  int? amount,  int? commission,  PaymentMethod payment)  $default,) {final _that = this;
switch (_that) {
case _TripDraft():
return $default(_that.id,_that.day,_that.startMinute,_that.endMinute,_that.utcOffset,_that.amount,_that.commission,_that.payment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime day,  int startMinute,  int endMinute,  Duration utcOffset,  int? amount,  int? commission,  PaymentMethod payment)?  $default,) {final _that = this;
switch (_that) {
case _TripDraft() when $default != null:
return $default(_that.id,_that.day,_that.startMinute,_that.endMinute,_that.utcOffset,_that.amount,_that.commission,_that.payment);case _:
  return null;

}
}

}

/// @nodoc


class _TripDraft extends TripDraft {
  const _TripDraft({required this.id, required this.day, required this.startMinute, required this.endMinute, required this.utcOffset, this.amount, this.commission, this.payment = PaymentMethod.card}): super._();
  

/// Ключ идемпотентности: создаётся вместе с черновиком и не меняется при повторной отправке.
@override final  String id;
@override final  DateTime day;
@override final  int startMinute;
@override final  int endMinute;
@override final  Duration utcOffset;
@override final  int? amount;
@override final  int? commission;
@override@JsonKey() final  PaymentMethod payment;

/// Create a copy of TripDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDraftCopyWith<_TripDraft> get copyWith => __$TripDraftCopyWithImpl<_TripDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.day, day) || other.day == day)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,day,startMinute,endMinute,utcOffset,amount,commission,payment);
}

@override
String toString() {
    return 'TripDraft(id: $id, day: $day, startMinute: $startMinute, endMinute: $endMinute, utcOffset: $utcOffset, amount: $amount, commission: $commission, payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$TripDraftCopyWith<$Res> implements $TripDraftCopyWith<$Res> {
  factory _$TripDraftCopyWith(_TripDraft value, $Res Function(_TripDraft) _then) = __$TripDraftCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime day, int startMinute, int endMinute, Duration utcOffset, int? amount, int? commission, PaymentMethod payment
});




}
/// @nodoc
class __$TripDraftCopyWithImpl<$Res>
    implements _$TripDraftCopyWith<$Res> {
  __$TripDraftCopyWithImpl(this._self, this._then);

  final _TripDraft _self;
  final $Res Function(_TripDraft) _then;

/// Create a copy of TripDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? day = null,Object? startMinute = null,Object? endMinute = null,Object? utcOffset = null,Object? amount = freezed,Object? commission = freezed,Object? payment = null,}) {
  return _then(_TripDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,commission: freezed == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int?,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}


}

// dart format on
