// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentBreakdownDto {

 int get count; int get amount; int get commission;
/// Create a copy of PaymentBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentBreakdownDtoCopyWith<PaymentBreakdownDto> get copyWith => _$PaymentBreakdownDtoCopyWithImpl<PaymentBreakdownDto>(this as PaymentBreakdownDto, _$identity);

  /// Serializes this PaymentBreakdownDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaymentBreakdownDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentBreakdownDto&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.commission, _this.commission) || other.commission == _this.commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaymentBreakdownDto;
  return Object.hash(runtimeType,_this.count,_this.amount,_this.commission);
}

@override
String toString() {
  final _this = this as PaymentBreakdownDto;
  return 'PaymentBreakdownDto(count: ${_this.count}, amount: ${_this.amount}, commission: ${_this.commission})';
}


}

/// @nodoc
abstract mixin class $PaymentBreakdownDtoCopyWith<$Res>  {
  factory $PaymentBreakdownDtoCopyWith(PaymentBreakdownDto value, $Res Function(PaymentBreakdownDto) _then) = _$PaymentBreakdownDtoCopyWithImpl;
@useResult
$Res call({
 int count, int amount, int commission
});




}
/// @nodoc
class _$PaymentBreakdownDtoCopyWithImpl<$Res>
    implements $PaymentBreakdownDtoCopyWith<$Res> {
  _$PaymentBreakdownDtoCopyWithImpl(this._self, this._then);

  final PaymentBreakdownDto _self;
  final $Res Function(PaymentBreakdownDto) _then;

/// Create a copy of PaymentBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? amount = null,Object? commission = null,}) {
  return _then(PaymentBreakdownDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentBreakdownDto].
extension PaymentBreakdownDtoPatterns on PaymentBreakdownDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentBreakdownDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentBreakdownDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentBreakdownDto value)  $default,){
final _that = this;
switch (_that) {
case _PaymentBreakdownDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentBreakdownDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentBreakdownDto() when $default != null:
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
case _PaymentBreakdownDto() when $default != null:
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
case _PaymentBreakdownDto():
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
case _PaymentBreakdownDto() when $default != null:
return $default(_that.count,_that.amount,_that.commission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentBreakdownDto implements PaymentBreakdownDto {
  const _PaymentBreakdownDto({required this.count, required this.amount, required this.commission});
  factory _PaymentBreakdownDto.fromJson(Map<String, dynamic> json) => _$PaymentBreakdownDtoFromJson(json);

@override final  int count;
@override final  int amount;
@override final  int commission;

/// Create a copy of PaymentBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentBreakdownDtoCopyWith<_PaymentBreakdownDto> get copyWith => __$PaymentBreakdownDtoCopyWithImpl<_PaymentBreakdownDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentBreakdownDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentBreakdownDto&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,amount,commission);
}

@override
String toString() {
    return 'PaymentBreakdownDto(count: $count, amount: $amount, commission: $commission)';
}


}

/// @nodoc
abstract mixin class _$PaymentBreakdownDtoCopyWith<$Res> implements $PaymentBreakdownDtoCopyWith<$Res> {
  factory _$PaymentBreakdownDtoCopyWith(_PaymentBreakdownDto value, $Res Function(_PaymentBreakdownDto) _then) = __$PaymentBreakdownDtoCopyWithImpl;
@override @useResult
$Res call({
 int count, int amount, int commission
});




}
/// @nodoc
class __$PaymentBreakdownDtoCopyWithImpl<$Res>
    implements _$PaymentBreakdownDtoCopyWith<$Res> {
  __$PaymentBreakdownDtoCopyWithImpl(this._self, this._then);

  final _PaymentBreakdownDto _self;
  final $Res Function(_PaymentBreakdownDto) _then;

/// Create a copy of PaymentBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? amount = null,Object? commission = null,}) {
  return _then(_PaymentBreakdownDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DaySummaryDto {

 int get tripsCount; int get revenue; int get commission; int get net; Map<String, PaymentBreakdownDto> get byPayment;
/// Create a copy of DaySummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DaySummaryDtoCopyWith<DaySummaryDto> get copyWith => _$DaySummaryDtoCopyWithImpl<DaySummaryDto>(this as DaySummaryDto, _$identity);

  /// Serializes this DaySummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DaySummaryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DaySummaryDto&&(identical(other.tripsCount, _this.tripsCount) || other.tripsCount == _this.tripsCount)&&(identical(other.revenue, _this.revenue) || other.revenue == _this.revenue)&&(identical(other.commission, _this.commission) || other.commission == _this.commission)&&(identical(other.net, _this.net) || other.net == _this.net)&&const DeepCollectionEquality().equals(other.byPayment, _this.byPayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DaySummaryDto;
  return Object.hash(runtimeType,_this.tripsCount,_this.revenue,_this.commission,_this.net,const DeepCollectionEquality().hash(_this.byPayment));
}

@override
String toString() {
  final _this = this as DaySummaryDto;
  return 'DaySummaryDto(tripsCount: ${_this.tripsCount}, revenue: ${_this.revenue}, commission: ${_this.commission}, net: ${_this.net}, byPayment: ${_this.byPayment})';
}


}

/// @nodoc
abstract mixin class $DaySummaryDtoCopyWith<$Res>  {
  factory $DaySummaryDtoCopyWith(DaySummaryDto value, $Res Function(DaySummaryDto) _then) = _$DaySummaryDtoCopyWithImpl;
@useResult
$Res call({
 int tripsCount, int revenue, int commission, int net, Map<String, PaymentBreakdownDto> byPayment
});




}
/// @nodoc
class _$DaySummaryDtoCopyWithImpl<$Res>
    implements $DaySummaryDtoCopyWith<$Res> {
  _$DaySummaryDtoCopyWithImpl(this._self, this._then);

  final DaySummaryDto _self;
  final $Res Function(DaySummaryDto) _then;

/// Create a copy of DaySummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripsCount = null,Object? revenue = null,Object? commission = null,Object? net = null,Object? byPayment = null,}) {
  return _then(DaySummaryDto(
tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,byPayment: null == byPayment ? _self.byPayment : byPayment // ignore: cast_nullable_to_non_nullable
as Map<String, PaymentBreakdownDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [DaySummaryDto].
extension DaySummaryDtoPatterns on DaySummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DaySummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DaySummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DaySummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _DaySummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DaySummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _DaySummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tripsCount,  int revenue,  int commission,  int net,  Map<String, PaymentBreakdownDto> byPayment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DaySummaryDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tripsCount,  int revenue,  int commission,  int net,  Map<String, PaymentBreakdownDto> byPayment)  $default,) {final _that = this;
switch (_that) {
case _DaySummaryDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tripsCount,  int revenue,  int commission,  int net,  Map<String, PaymentBreakdownDto> byPayment)?  $default,) {final _that = this;
switch (_that) {
case _DaySummaryDto() when $default != null:
return $default(_that.tripsCount,_that.revenue,_that.commission,_that.net,_that.byPayment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DaySummaryDto implements DaySummaryDto {
  const _DaySummaryDto({required this.tripsCount, required this.revenue, required this.commission, required this.net, required  Map<String, PaymentBreakdownDto> byPayment}): _byPayment = byPayment;
  factory _DaySummaryDto.fromJson(Map<String, dynamic> json) => _$DaySummaryDtoFromJson(json);

@override final  int tripsCount;
@override final  int revenue;
@override final  int commission;
@override final  int net;
 final  Map<String, PaymentBreakdownDto> _byPayment;
@override Map<String, PaymentBreakdownDto> get byPayment {
  if (_byPayment is EqualUnmodifiableMapView) return _byPayment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byPayment);
}


/// Create a copy of DaySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaySummaryDtoCopyWith<_DaySummaryDto> get copyWith => __$DaySummaryDtoCopyWithImpl<_DaySummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DaySummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaySummaryDto&&(identical(other.tripsCount, tripsCount) || other.tripsCount == tripsCount)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.net, net) || other.net == net)&&const DeepCollectionEquality().equals(other.byPayment, _byPayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripsCount,revenue,commission,net,const DeepCollectionEquality().hash(_byPayment));
}

@override
String toString() {
    return 'DaySummaryDto(tripsCount: $tripsCount, revenue: $revenue, commission: $commission, net: $net, byPayment: $byPayment)';
}


}

/// @nodoc
abstract mixin class _$DaySummaryDtoCopyWith<$Res> implements $DaySummaryDtoCopyWith<$Res> {
  factory _$DaySummaryDtoCopyWith(_DaySummaryDto value, $Res Function(_DaySummaryDto) _then) = __$DaySummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int tripsCount, int revenue, int commission, int net, Map<String, PaymentBreakdownDto> byPayment
});




}
/// @nodoc
class __$DaySummaryDtoCopyWithImpl<$Res>
    implements _$DaySummaryDtoCopyWith<$Res> {
  __$DaySummaryDtoCopyWithImpl(this._self, this._then);

  final _DaySummaryDto _self;
  final $Res Function(_DaySummaryDto) _then;

/// Create a copy of DaySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripsCount = null,Object? revenue = null,Object? commission = null,Object? net = null,Object? byPayment = null,}) {
  return _then(_DaySummaryDto(
tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as int,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,byPayment: null == byPayment ? _self._byPayment : byPayment // ignore: cast_nullable_to_non_nullable
as Map<String, PaymentBreakdownDto>,
  ));
}


}


/// @nodoc
mixin _$DayReportDto {

 String get date; String get utcOffset; DaySummaryDto get summary; List<TripDto> get trips;
/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayReportDtoCopyWith<DayReportDto> get copyWith => _$DayReportDtoCopyWithImpl<DayReportDto>(this as DayReportDto, _$identity);

  /// Serializes this DayReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DayReportDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayReportDto&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.utcOffset, _this.utcOffset) || other.utcOffset == _this.utcOffset)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.trips, _this.trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DayReportDto;
  return Object.hash(runtimeType,_this.date,_this.utcOffset,_this.summary,const DeepCollectionEquality().hash(_this.trips));
}

@override
String toString() {
  final _this = this as DayReportDto;
  return 'DayReportDto(date: ${_this.date}, utcOffset: ${_this.utcOffset}, summary: ${_this.summary}, trips: ${_this.trips})';
}


}

/// @nodoc
abstract mixin class $DayReportDtoCopyWith<$Res>  {
  factory $DayReportDtoCopyWith(DayReportDto value, $Res Function(DayReportDto) _then) = _$DayReportDtoCopyWithImpl;
@useResult
$Res call({
 String date, String utcOffset, DaySummaryDto summary, List<TripDto> trips
});


$DaySummaryDtoCopyWith<$Res> get summary;

}
/// @nodoc
class _$DayReportDtoCopyWithImpl<$Res>
    implements $DayReportDtoCopyWith<$Res> {
  _$DayReportDtoCopyWithImpl(this._self, this._then);

  final DayReportDto _self;
  final $Res Function(DayReportDto) _then;

/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? utcOffset = null,Object? summary = null,Object? trips = null,}) {
  return _then(DayReportDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DaySummaryDto,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripDto>,
  ));
}
/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DaySummaryDtoCopyWith<$Res> get summary {
  
  return $DaySummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DayReportDto].
extension DayReportDtoPatterns on DayReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayReportDto value)  $default,){
final _that = this;
switch (_that) {
case _DayReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _DayReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String utcOffset,  DaySummaryDto summary,  List<TripDto> trips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayReportDto() when $default != null:
return $default(_that.date,_that.utcOffset,_that.summary,_that.trips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String utcOffset,  DaySummaryDto summary,  List<TripDto> trips)  $default,) {final _that = this;
switch (_that) {
case _DayReportDto():
return $default(_that.date,_that.utcOffset,_that.summary,_that.trips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String utcOffset,  DaySummaryDto summary,  List<TripDto> trips)?  $default,) {final _that = this;
switch (_that) {
case _DayReportDto() when $default != null:
return $default(_that.date,_that.utcOffset,_that.summary,_that.trips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayReportDto implements DayReportDto {
  const _DayReportDto({required this.date, required this.utcOffset, required this.summary, required  List<TripDto> trips}): _trips = trips;
  factory _DayReportDto.fromJson(Map<String, dynamic> json) => _$DayReportDtoFromJson(json);

@override final  String date;
@override final  String utcOffset;
@override final  DaySummaryDto summary;
 final  List<TripDto> _trips;
@override List<TripDto> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}


/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayReportDtoCopyWith<_DayReportDto> get copyWith => __$DayReportDtoCopyWithImpl<_DayReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayReportDto&&(identical(other.date, date) || other.date == date)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.trips, _trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,utcOffset,summary,const DeepCollectionEquality().hash(_trips));
}

@override
String toString() {
    return 'DayReportDto(date: $date, utcOffset: $utcOffset, summary: $summary, trips: $trips)';
}


}

/// @nodoc
abstract mixin class _$DayReportDtoCopyWith<$Res> implements $DayReportDtoCopyWith<$Res> {
  factory _$DayReportDtoCopyWith(_DayReportDto value, $Res Function(_DayReportDto) _then) = __$DayReportDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String utcOffset, DaySummaryDto summary, List<TripDto> trips
});


@override $DaySummaryDtoCopyWith<$Res> get summary;

}
/// @nodoc
class __$DayReportDtoCopyWithImpl<$Res>
    implements _$DayReportDtoCopyWith<$Res> {
  __$DayReportDtoCopyWithImpl(this._self, this._then);

  final _DayReportDto _self;
  final $Res Function(_DayReportDto) _then;

/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? utcOffset = null,Object? summary = null,Object? trips = null,}) {
  return _then(_DayReportDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DaySummaryDto,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripDto>,
  ));
}

/// Create a copy of DayReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DaySummaryDtoCopyWith<$Res> get summary {
  
  return $DaySummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$WorkDayDto {

 String get date; int get tripsCount; int get net;
/// Create a copy of WorkDayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkDayDtoCopyWith<WorkDayDto> get copyWith => _$WorkDayDtoCopyWithImpl<WorkDayDto>(this as WorkDayDto, _$identity);

  /// Serializes this WorkDayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkDayDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkDayDto&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.tripsCount, _this.tripsCount) || other.tripsCount == _this.tripsCount)&&(identical(other.net, _this.net) || other.net == _this.net));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkDayDto;
  return Object.hash(runtimeType,_this.date,_this.tripsCount,_this.net);
}

@override
String toString() {
  final _this = this as WorkDayDto;
  return 'WorkDayDto(date: ${_this.date}, tripsCount: ${_this.tripsCount}, net: ${_this.net})';
}


}

/// @nodoc
abstract mixin class $WorkDayDtoCopyWith<$Res>  {
  factory $WorkDayDtoCopyWith(WorkDayDto value, $Res Function(WorkDayDto) _then) = _$WorkDayDtoCopyWithImpl;
@useResult
$Res call({
 String date, int tripsCount, int net
});




}
/// @nodoc
class _$WorkDayDtoCopyWithImpl<$Res>
    implements $WorkDayDtoCopyWith<$Res> {
  _$WorkDayDtoCopyWithImpl(this._self, this._then);

  final WorkDayDto _self;
  final $Res Function(WorkDayDto) _then;

/// Create a copy of WorkDayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? tripsCount = null,Object? net = null,}) {
  return _then(WorkDayDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkDayDto].
extension WorkDayDtoPatterns on WorkDayDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkDayDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkDayDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkDayDto value)  $default,){
final _that = this;
switch (_that) {
case _WorkDayDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkDayDto value)?  $default,){
final _that = this;
switch (_that) {
case _WorkDayDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int tripsCount,  int net)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkDayDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int tripsCount,  int net)  $default,) {final _that = this;
switch (_that) {
case _WorkDayDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int tripsCount,  int net)?  $default,) {final _that = this;
switch (_that) {
case _WorkDayDto() when $default != null:
return $default(_that.date,_that.tripsCount,_that.net);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkDayDto implements WorkDayDto {
  const _WorkDayDto({required this.date, required this.tripsCount, required this.net});
  factory _WorkDayDto.fromJson(Map<String, dynamic> json) => _$WorkDayDtoFromJson(json);

@override final  String date;
@override final  int tripsCount;
@override final  int net;

/// Create a copy of WorkDayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkDayDtoCopyWith<_WorkDayDto> get copyWith => __$WorkDayDtoCopyWithImpl<_WorkDayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkDayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkDayDto&&(identical(other.date, date) || other.date == date)&&(identical(other.tripsCount, tripsCount) || other.tripsCount == tripsCount)&&(identical(other.net, net) || other.net == net));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,tripsCount,net);
}

@override
String toString() {
    return 'WorkDayDto(date: $date, tripsCount: $tripsCount, net: $net)';
}


}

/// @nodoc
abstract mixin class _$WorkDayDtoCopyWith<$Res> implements $WorkDayDtoCopyWith<$Res> {
  factory _$WorkDayDtoCopyWith(_WorkDayDto value, $Res Function(_WorkDayDto) _then) = __$WorkDayDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, int tripsCount, int net
});




}
/// @nodoc
class __$WorkDayDtoCopyWithImpl<$Res>
    implements _$WorkDayDtoCopyWith<$Res> {
  __$WorkDayDtoCopyWithImpl(this._self, this._then);

  final _WorkDayDto _self;
  final $Res Function(_WorkDayDto) _then;

/// Create a copy of WorkDayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? tripsCount = null,Object? net = null,}) {
  return _then(_WorkDayDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,tripsCount: null == tripsCount ? _self.tripsCount : tripsCount // ignore: cast_nullable_to_non_nullable
as int,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
