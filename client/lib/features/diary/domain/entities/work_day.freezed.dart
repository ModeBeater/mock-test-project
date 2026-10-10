// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkDay {

 DateTime get date; int get tripsCount; int get net;
/// Create a copy of WorkDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkDayCopyWith<WorkDay> get copyWith => _$WorkDayCopyWithImpl<WorkDay>(this as WorkDay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WorkDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkDay&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.tripsCount, _this.tripsCount) || other.tripsCount == _this.tripsCount)&&(identical(other.net, _this.net) || other.net == _this.net));
}


@override
int get hashCode {
  final _this = this as WorkDay;
  return Object.hash(runtimeType,_this.date,_this.tripsCount,_this.net);
}

@override
String toString() {
  final _this = this as WorkDay;
  return 'WorkDay(date: ${_this.date}, tripsCount: ${_this.tripsCount}, net: ${_this.net})';
}


}

/// @nodoc
abstract mixin class $WorkDayCopyWith<$Res>  {
  factory $WorkDayCopyWith(WorkDay value, $Res Function(WorkDay) _then) = _$WorkDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, int tripsCount, int net
});




}
/// @nodoc
class _$WorkDayCopyWithImpl<$Res>
    implements $WorkDayCopyWith<$Res> {
  _$WorkDayCopyWithImpl(this._self, this._then);

  final WorkDay _self;
  final $Res Function(WorkDay) _then;

/// Create a copy of WorkDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? tripsCount = null,Object? net = null,}) {
  return _then(WorkDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkDay].
extension WorkDayPatterns on WorkDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkDay value)  $default,){
final _that = this;
switch (_that) {
case _WorkDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkDay value)?  $default,){
final _that = this;
switch (_that) {
case _WorkDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int tripsCount,  int net)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkDay() when $default != null:
return $default(_that.date,_that.tripsCount,_that.net);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int tripsCount,  int net)  $default,) {final _that = this;
switch (_that) {
case _WorkDay():
return $default(_that.date,_that.tripsCount,_that.net);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int tripsCount,  int net)?  $default,) {final _that = this;
switch (_that) {
case _WorkDay() when $default != null:
return $default(_that.date,_that.tripsCount,_that.net);case _:
  return null;

}
}

}

/// @nodoc


class _WorkDay implements WorkDay {
  const _WorkDay({required this.date, required this.tripsCount, required this.net});
  

@override final  DateTime date;
@override final  int tripsCount;
@override final  int net;

/// Create a copy of WorkDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkDayCopyWith<_WorkDay> get copyWith => __$WorkDayCopyWithImpl<_WorkDay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkDay&&(identical(other.date, date) || other.date == date)&&(identical(other.tripsCount, tripsCount) || other.tripsCount == tripsCount)&&(identical(other.net, net) || other.net == net));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,tripsCount,net);
}

@override
String toString() {
    return 'WorkDay(date: $date, tripsCount: $tripsCount, net: $net)';
}


}

/// @nodoc
abstract mixin class _$WorkDayCopyWith<$Res> implements $WorkDayCopyWith<$Res> {
  factory _$WorkDayCopyWith(_WorkDay value, $Res Function(_WorkDay) _then) = __$WorkDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int tripsCount, int net
});




}
/// @nodoc
class __$WorkDayCopyWithImpl<$Res>
    implements _$WorkDayCopyWith<$Res> {
  __$WorkDayCopyWithImpl(this._self, this._then);

  final _WorkDay _self;
  final $Res Function(_WorkDay) _then;

/// Create a copy of WorkDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? tripsCount = null,Object? net = null,}) {
  return _then(_WorkDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
