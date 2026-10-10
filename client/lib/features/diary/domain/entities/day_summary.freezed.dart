// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentBreakdown {

 int get count; int get amount; int get commission;
/// Create a copy of PaymentBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentBreakdownCopyWith<PaymentBreakdown> get copyWith => _$PaymentBreakdownCopyWithImpl<PaymentBreakdown>(this as PaymentBreakdown, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaymentBreakdown;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentBreakdown&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.commission, _this.commission) || other.commission == _this.commission));
}


@override
int get hashCode {
  final _this = this as PaymentBreakdown;
  return Object.hash(runtimeType,_this.count,_this.amount,_this.commission);
}

@override
String toString() {
  final _this = this as PaymentBreakdown;
  return 'PaymentBreakdown(count: ${_this.count}, amount: ${_this.amount}, commission: ${_this.commission})';
}


}

/// @nodoc
abstract mixin class $PaymentBreakdownCopyWith<$Res>  {
  factory $PaymentBreakdownCopyWith(PaymentBreakdown value, $Res Function(PaymentBreakdown) _then) = _$PaymentBreakdownCopyWithImpl;
@useResult
$Res call({
 int count, int amount, int commission
});




}
/// @nodoc
class _$PaymentBreakdownCopyWithImpl<$Res>
    implements $PaymentBreakdownCopyWith<$Res> {
  _$PaymentBreakdownCopyWithImpl(this._self, this._then);

  final PaymentBreakdown _self;
  final $Res Function(PaymentBreakdown) _then;

/// Create a copy of PaymentBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? amount = null,Object? commission = null,}) {
  return _then(PaymentBreakdown(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentBreakdown].
extension PaymentBreakdownPatterns on PaymentBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _PaymentBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int amount,  int commission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentBreakdown() when $default != null:
return $default(_that.count,_that.amount,_that.commission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int amount,  int commission)  $default,) {final _that = this;
switch (_that) {
case _PaymentBreakdown():
return $default(_that.count,_that.amount,_that.commission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int amount,  int commission)?  $default,) {final _that = this;
switch (_that) {
case _PaymentBreakdown() when $default != null:
return $default(_that.count,_that.amount,_that.commission);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentBreakdown implements PaymentBreakdown {
  const _PaymentBreakdown({this.count = 0, this.amount = 0, this.commission = 0});
  

@override@JsonKey() final  int count;
@override@JsonKey() final  int amount;
@override@JsonKey() final  int commission;

/// Create a copy of PaymentBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentBreakdownCopyWith<_PaymentBreakdown> get copyWith => __$PaymentBreakdownCopyWithImpl<_PaymentBreakdown>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentBreakdown&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count,amount,commission);
}

@override
String toString() {
    return 'PaymentBreakdown(count: $count, amount: $amount, commission: $commission)';
}


}

/// @nodoc
abstract mixin class _$PaymentBreakdownCopyWith<$Res> implements $PaymentBreakdownCopyWith<$Res> {
  factory _$PaymentBreakdownCopyWith(_PaymentBreakdown value, $Res Function(_PaymentBreakdown) _then) = __$PaymentBreakdownCopyWithImpl;
@override @useResult
$Res call({
 int count, int amount, int commission
});




}
/// @nodoc
class __$PaymentBreakdownCopyWithImpl<$Res>
    implements _$PaymentBreakdownCopyWith<$Res> {
  __$PaymentBreakdownCopyWithImpl(this._self, this._then);

  final _PaymentBreakdown _self;
  final $Res Function(_PaymentBreakdown) _then;

/// Create a copy of PaymentBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? amount = null,Object? commission = null,}) {
  return _then(_PaymentBreakdown(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DaySummary {

 int get tripsCount; int get revenue; int get commission;/// «На руки»: выручка минус комиссия. Считает сервер.
 int get net; Map<PaymentMethod, PaymentBreakdown> get byPayment;
/// Create a copy of DaySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DaySummaryCopyWith<DaySummary> get copyWith => _$DaySummaryCopyWithImpl<DaySummary>(this as DaySummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DaySummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DaySummary&&(identical(other.tripsCount, _this.tripsCount) || other.tripsCount == _this.tripsCount)&&(identical(other.revenue, _this.revenue) || other.revenue == _this.revenue)&&(identical(other.commission, _this.commission) || other.commission == _this.commission)&&(identical(other.net, _this.net) || other.net == _this.net)&&const DeepCollectionEquality().equals(other.byPayment, _this.byPayment));
}


@override
int get hashCode {
  final _this = this as DaySummary;
  return Object.hash(runtimeType,_this.tripsCount,_this.revenue,_this.commission,_this.net,const DeepCollectionEquality().hash(_this.byPayment));
}

@override
String toString() {
  final _this = this as DaySummary;
  return 'DaySummary(tripsCount: ${_this.tripsCount}, revenue: ${_this.revenue}, commission: ${_this.commission}, net: ${_this.net}, byPayment: ${_this.byPayment})';
}


}

/// @nodoc
abstract mixin class $DaySummaryCopyWith<$Res>  {
  factory $DaySummaryCopyWith(DaySummary value, $Res Function(DaySummary) _then) = _$DaySummaryCopyWithImpl;
@useResult
$Res call({
 int tripsCount, int revenue, int commission, int net, Map<PaymentMethod, PaymentBreakdown> byPayment
});




}
/// @nodoc
class _$DaySummaryCopyWithImpl<$Res>
    implements $DaySummaryCopyWith<$Res> {
  _$DaySummaryCopyWithImpl(this._self, this._then);

  final DaySummary _self;
  final $Res Function(DaySummary) _then;

/// Create a copy of DaySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripsCount = null,Object? revenue = null,Object? commission = null,Object? net = null,Object? byPayment = null,}) {
  return _then(DaySummary(
tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,byPayment: null == byPayment ? _self.byPayment : byPayment // ignore: cast_nullable_to_non_nullable
as Map<PaymentMethod, PaymentBreakdown>,
  ));
}

}


/// Adds pattern-matching-related methods to [DaySummary].
extension DaySummaryPatterns on DaySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DaySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DaySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DaySummary value)  $default,){
final _that = this;
switch (_that) {
case _DaySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DaySummary value)?  $default,){
final _that = this;
switch (_that) {
case _DaySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tripsCount,  int revenue,  int commission,  int net,  Map<PaymentMethod, PaymentBreakdown> byPayment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DaySummary() when $default != null:
return $default(_that.tripsCount,_that.revenue,_that.commission,_that.net,_that.byPayment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tripsCount,  int revenue,  int commission,  int net,  Map<PaymentMethod, PaymentBreakdown> byPayment)  $default,) {final _that = this;
switch (_that) {
case _DaySummary():
return $default(_that.tripsCount,_that.revenue,_that.commission,_that.net,_that.byPayment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tripsCount,  int revenue,  int commission,  int net,  Map<PaymentMethod, PaymentBreakdown> byPayment)?  $default,) {final _that = this;
switch (_that) {
case _DaySummary() when $default != null:
return $default(_that.tripsCount,_that.revenue,_that.commission,_that.net,_that.byPayment);case _:
  return null;

}
}

}

/// @nodoc


class _DaySummary extends DaySummary {
  const _DaySummary({required this.tripsCount, required this.revenue, required this.commission, required this.net, required  Map<PaymentMethod, PaymentBreakdown> byPayment}): _byPayment = byPayment,super._();
  

@override final  int tripsCount;
@override final  int revenue;
@override final  int commission;
/// «На руки»: выручка минус комиссия. Считает сервер.
@override final  int net;
 final  Map<PaymentMethod, PaymentBreakdown> _byPayment;
@override Map<PaymentMethod, PaymentBreakdown> get byPayment {
  if (_byPayment is EqualUnmodifiableMapView) return _byPayment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byPayment);
}


/// Create a copy of DaySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaySummaryCopyWith<_DaySummary> get copyWith => __$DaySummaryCopyWithImpl<_DaySummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaySummary&&(identical(other.tripsCount, tripsCount) || other.tripsCount == tripsCount)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.net, net) || other.net == net)&&const DeepCollectionEquality().equals(other.byPayment, _byPayment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tripsCount,revenue,commission,net,const DeepCollectionEquality().hash(_byPayment));
}

@override
String toString() {
    return 'DaySummary(tripsCount: $tripsCount, revenue: $revenue, commission: $commission, net: $net, byPayment: $byPayment)';
}


}

/// @nodoc
abstract mixin class _$DaySummaryCopyWith<$Res> implements $DaySummaryCopyWith<$Res> {
  factory _$DaySummaryCopyWith(_DaySummary value, $Res Function(_DaySummary) _then) = __$DaySummaryCopyWithImpl;
@override @useResult
$Res call({
 int tripsCount, int revenue, int commission, int net, Map<PaymentMethod, PaymentBreakdown> byPayment
});




}
/// @nodoc
class __$DaySummaryCopyWithImpl<$Res>
    implements _$DaySummaryCopyWith<$Res> {
  __$DaySummaryCopyWithImpl(this._self, this._then);

  final _DaySummary _self;
  final $Res Function(_DaySummary) _then;

/// Create a copy of DaySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripsCount = null,Object? revenue = null,Object? commission = null,Object? net = null,Object? byPayment = null,}) {
  return _then(_DaySummary(
tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,byPayment: null == byPayment ? _self._byPayment : byPayment // ignore: cast_nullable_to_non_nullable
as Map<PaymentMethod, PaymentBreakdown>,
  ));
}


}

// dart format on
