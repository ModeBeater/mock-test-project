// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_trip_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewTripDto {

 String get id; String get start; String get end; int get amount; String get payment; int get commission;
/// Create a copy of NewTripDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewTripDtoCopyWith<NewTripDto> get copyWith => _$NewTripDtoCopyWithImpl<NewTripDto>(this as NewTripDto, _$identity);

  /// Serializes this NewTripDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NewTripDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewTripDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.end, _this.end) || other.end == _this.end)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.payment, _this.payment) || other.payment == _this.payment)&&(identical(other.commission, _this.commission) || other.commission == _this.commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NewTripDto;
  return Object.hash(runtimeType,_this.id,_this.start,_this.end,_this.amount,_this.payment,_this.commission);
}

@override
String toString() {
  final _this = this as NewTripDto;
  return 'NewTripDto(id: ${_this.id}, start: ${_this.start}, end: ${_this.end}, amount: ${_this.amount}, payment: ${_this.payment}, commission: ${_this.commission})';
}


}

/// @nodoc
abstract mixin class $NewTripDtoCopyWith<$Res>  {
  factory $NewTripDtoCopyWith(NewTripDto value, $Res Function(NewTripDto) _then) = _$NewTripDtoCopyWithImpl;
@useResult
$Res call({
 String id, String start, String end, int amount, String payment, int commission
});




}
/// @nodoc
class _$NewTripDtoCopyWithImpl<$Res>
    implements $NewTripDtoCopyWith<$Res> {
  _$NewTripDtoCopyWithImpl(this._self, this._then);

  final NewTripDto _self;
  final $Res Function(NewTripDto) _then;

/// Create a copy of NewTripDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? start = null,Object? end = null,Object? amount = null,Object? payment = null,Object? commission = null,}) {
  return _then(NewTripDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as String,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NewTripDto].
extension NewTripDtoPatterns on NewTripDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewTripDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewTripDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewTripDto value)  $default,){
final _that = this;
switch (_that) {
case _NewTripDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewTripDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewTripDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String start,  String end,  int amount,  String payment,  int commission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewTripDto() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.amount,_that.payment,_that.commission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String start,  String end,  int amount,  String payment,  int commission)  $default,) {final _that = this;
switch (_that) {
case _NewTripDto():
return $default(_that.id,_that.start,_that.end,_that.amount,_that.payment,_that.commission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String start,  String end,  int amount,  String payment,  int commission)?  $default,) {final _that = this;
switch (_that) {
case _NewTripDto() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.amount,_that.payment,_that.commission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewTripDto implements NewTripDto {
  const _NewTripDto({required this.id, required this.start, required this.end, required this.amount, required this.payment, required this.commission});
  factory _NewTripDto.fromJson(Map<String, dynamic> json) => _$NewTripDtoFromJson(json);

@override final  String id;
@override final  String start;
@override final  String end;
@override final  int amount;
@override final  String payment;
@override final  int commission;

/// Create a copy of NewTripDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewTripDtoCopyWith<_NewTripDto> get copyWith => __$NewTripDtoCopyWithImpl<_NewTripDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewTripDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewTripDto&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.commission, commission) || other.commission == commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,start,end,amount,payment,commission);
}

@override
String toString() {
    return 'NewTripDto(id: $id, start: $start, end: $end, amount: $amount, payment: $payment, commission: $commission)';
}


}

/// @nodoc
abstract mixin class _$NewTripDtoCopyWith<$Res> implements $NewTripDtoCopyWith<$Res> {
  factory _$NewTripDtoCopyWith(_NewTripDto value, $Res Function(_NewTripDto) _then) = __$NewTripDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String start, String end, int amount, String payment, int commission
});




}
/// @nodoc
class __$NewTripDtoCopyWithImpl<$Res>
    implements _$NewTripDtoCopyWith<$Res> {
  __$NewTripDtoCopyWithImpl(this._self, this._then);

  final _NewTripDto _self;
  final $Res Function(_NewTripDto) _then;

/// Create a copy of NewTripDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? start = null,Object? end = null,Object? amount = null,Object? payment = null,Object? commission = null,}) {
  return _then(_NewTripDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as String,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ConflictDto {

 String get code; String get message; TripDto get existing;
/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConflictDtoCopyWith<ConflictDto> get copyWith => _$ConflictDtoCopyWithImpl<ConflictDto>(this as ConflictDto, _$identity);

  /// Serializes this ConflictDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConflictDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConflictDto&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.existing, _this.existing) || other.existing == _this.existing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConflictDto;
  return Object.hash(runtimeType,_this.code,_this.message,_this.existing);
}

@override
String toString() {
  final _this = this as ConflictDto;
  return 'ConflictDto(code: ${_this.code}, message: ${_this.message}, existing: ${_this.existing})';
}


}

/// @nodoc
abstract mixin class $ConflictDtoCopyWith<$Res>  {
  factory $ConflictDtoCopyWith(ConflictDto value, $Res Function(ConflictDto) _then) = _$ConflictDtoCopyWithImpl;
@useResult
$Res call({
 String code, String message, TripDto existing
});


$TripDtoCopyWith<$Res> get existing;

}
/// @nodoc
class _$ConflictDtoCopyWithImpl<$Res>
    implements $ConflictDtoCopyWith<$Res> {
  _$ConflictDtoCopyWithImpl(this._self, this._then);

  final ConflictDto _self;
  final $Res Function(ConflictDto) _then;

/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? existing = null,}) {
  return _then(ConflictDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as TripDto,
  ));
}
/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDtoCopyWith<$Res> get existing {
  
  return $TripDtoCopyWith<$Res>(_self.existing, (value) {
    return _then(_self.copyWith(existing: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConflictDto].
extension ConflictDtoPatterns on ConflictDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConflictDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConflictDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConflictDto value)  $default,){
final _that = this;
switch (_that) {
case _ConflictDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConflictDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConflictDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message,  TripDto existing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConflictDto() when $default != null:
return $default(_that.code,_that.message,_that.existing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message,  TripDto existing)  $default,) {final _that = this;
switch (_that) {
case _ConflictDto():
return $default(_that.code,_that.message,_that.existing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message,  TripDto existing)?  $default,) {final _that = this;
switch (_that) {
case _ConflictDto() when $default != null:
return $default(_that.code,_that.message,_that.existing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConflictDto implements ConflictDto {
  const _ConflictDto({required this.code, required this.message, required this.existing});
  factory _ConflictDto.fromJson(Map<String, dynamic> json) => _$ConflictDtoFromJson(json);

@override final  String code;
@override final  String message;
@override final  TripDto existing;

/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConflictDtoCopyWith<_ConflictDto> get copyWith => __$ConflictDtoCopyWithImpl<_ConflictDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConflictDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConflictDto&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.existing, existing) || other.existing == existing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,message,existing);
}

@override
String toString() {
    return 'ConflictDto(code: $code, message: $message, existing: $existing)';
}


}

/// @nodoc
abstract mixin class _$ConflictDtoCopyWith<$Res> implements $ConflictDtoCopyWith<$Res> {
  factory _$ConflictDtoCopyWith(_ConflictDto value, $Res Function(_ConflictDto) _then) = __$ConflictDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String message, TripDto existing
});


@override $TripDtoCopyWith<$Res> get existing;

}
/// @nodoc
class __$ConflictDtoCopyWithImpl<$Res>
    implements _$ConflictDtoCopyWith<$Res> {
  __$ConflictDtoCopyWithImpl(this._self, this._then);

  final _ConflictDto _self;
  final $Res Function(_ConflictDto) _then;

/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? existing = null,}) {
  return _then(_ConflictDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as TripDto,
  ));
}

/// Create a copy of ConflictDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDtoCopyWith<$Res> get existing {
  
  return $TripDtoCopyWith<$Res>(_self.existing, (value) {
    return _then(_self.copyWith(existing: value));
  });
}
}

// dart format on
