// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_entry_outcome.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEntryOutcome {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntryOutcome);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TripEntryOutcome()';
}


}

/// @nodoc
class $TripEntryOutcomeCopyWith<$Res>  {
$TripEntryOutcomeCopyWith(TripEntryOutcome _, $Res Function(TripEntryOutcome) __);
}


/// Adds pattern-matching-related methods to [TripEntryOutcome].
extension TripEntryOutcomePatterns on TripEntryOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TripCreated value)?  created,TResult Function( TripAlreadySaved value)?  alreadySaved,TResult Function( TripConflict value)?  conflict,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TripCreated() when created != null:
return created(_that);case TripAlreadySaved() when alreadySaved != null:
return alreadySaved(_that);case TripConflict() when conflict != null:
return conflict(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TripCreated value)  created,required TResult Function( TripAlreadySaved value)  alreadySaved,required TResult Function( TripConflict value)  conflict,}){
final _that = this;
switch (_that) {
case TripCreated():
return created(_that);case TripAlreadySaved():
return alreadySaved(_that);case TripConflict():
return conflict(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TripCreated value)?  created,TResult? Function( TripAlreadySaved value)?  alreadySaved,TResult? Function( TripConflict value)?  conflict,}){
final _that = this;
switch (_that) {
case TripCreated() when created != null:
return created(_that);case TripAlreadySaved() when alreadySaved != null:
return alreadySaved(_that);case TripConflict() when conflict != null:
return conflict(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Trip trip)?  created,TResult Function( Trip trip)?  alreadySaved,TResult Function( ConflictKind kind,  Trip existing)?  conflict,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TripCreated() when created != null:
return created(_that.trip);case TripAlreadySaved() when alreadySaved != null:
return alreadySaved(_that.trip);case TripConflict() when conflict != null:
return conflict(_that.kind,_that.existing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Trip trip)  created,required TResult Function( Trip trip)  alreadySaved,required TResult Function( ConflictKind kind,  Trip existing)  conflict,}) {final _that = this;
switch (_that) {
case TripCreated():
return created(_that.trip);case TripAlreadySaved():
return alreadySaved(_that.trip);case TripConflict():
return conflict(_that.kind,_that.existing);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Trip trip)?  created,TResult? Function( Trip trip)?  alreadySaved,TResult? Function( ConflictKind kind,  Trip existing)?  conflict,}) {final _that = this;
switch (_that) {
case TripCreated() when created != null:
return created(_that.trip);case TripAlreadySaved() when alreadySaved != null:
return alreadySaved(_that.trip);case TripConflict() when conflict != null:
return conflict(_that.kind,_that.existing);case _:
  return null;

}
}

}

/// @nodoc


class TripCreated implements TripEntryOutcome {
  const TripCreated(this.trip);
  

 final  Trip trip;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCreatedCopyWith<TripCreated> get copyWith => _$TripCreatedCopyWithImpl<TripCreated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripCreated&&(identical(other.trip, trip) || other.trip == trip));
}


@override
int get hashCode {
    return Object.hash(runtimeType,trip);
}

@override
String toString() {
    return 'TripEntryOutcome.created(trip: $trip)';
}


}

/// @nodoc
abstract mixin class $TripCreatedCopyWith<$Res> implements $TripEntryOutcomeCopyWith<$Res> {
  factory $TripCreatedCopyWith(TripCreated value, $Res Function(TripCreated) _then) = _$TripCreatedCopyWithImpl;
@useResult
$Res call({
 Trip trip
});


$TripCopyWith<$Res> get trip;

}
/// @nodoc
class _$TripCreatedCopyWithImpl<$Res>
    implements $TripCreatedCopyWith<$Res> {
  _$TripCreatedCopyWithImpl(this._self, this._then);

  final TripCreated _self;
  final $Res Function(TripCreated) _then;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? trip = null,}) {
  return _then(TripCreated(
null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as Trip,
  ));
}

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCopyWith<$Res> get trip {
  
  return $TripCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}
}

/// @nodoc


class TripAlreadySaved implements TripEntryOutcome {
  const TripAlreadySaved(this.trip);
  

 final  Trip trip;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripAlreadySavedCopyWith<TripAlreadySaved> get copyWith => _$TripAlreadySavedCopyWithImpl<TripAlreadySaved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripAlreadySaved&&(identical(other.trip, trip) || other.trip == trip));
}


@override
int get hashCode {
    return Object.hash(runtimeType,trip);
}

@override
String toString() {
    return 'TripEntryOutcome.alreadySaved(trip: $trip)';
}


}

/// @nodoc
abstract mixin class $TripAlreadySavedCopyWith<$Res> implements $TripEntryOutcomeCopyWith<$Res> {
  factory $TripAlreadySavedCopyWith(TripAlreadySaved value, $Res Function(TripAlreadySaved) _then) = _$TripAlreadySavedCopyWithImpl;
@useResult
$Res call({
 Trip trip
});


$TripCopyWith<$Res> get trip;

}
/// @nodoc
class _$TripAlreadySavedCopyWithImpl<$Res>
    implements $TripAlreadySavedCopyWith<$Res> {
  _$TripAlreadySavedCopyWithImpl(this._self, this._then);

  final TripAlreadySaved _self;
  final $Res Function(TripAlreadySaved) _then;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? trip = null,}) {
  return _then(TripAlreadySaved(
null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as Trip,
  ));
}

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCopyWith<$Res> get trip {
  
  return $TripCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}
}

/// @nodoc


class TripConflict implements TripEntryOutcome {
  const TripConflict(this.kind, this.existing);
  

 final  ConflictKind kind;
 final  Trip existing;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripConflictCopyWith<TripConflict> get copyWith => _$TripConflictCopyWithImpl<TripConflict>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TripConflict&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.existing, existing) || other.existing == existing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,existing);
}

@override
String toString() {
    return 'TripEntryOutcome.conflict(kind: $kind, existing: $existing)';
}


}

/// @nodoc
abstract mixin class $TripConflictCopyWith<$Res> implements $TripEntryOutcomeCopyWith<$Res> {
  factory $TripConflictCopyWith(TripConflict value, $Res Function(TripConflict) _then) = _$TripConflictCopyWithImpl;
@useResult
$Res call({
 ConflictKind kind, Trip existing
});


$TripCopyWith<$Res> get existing;

}
/// @nodoc
class _$TripConflictCopyWithImpl<$Res>
    implements $TripConflictCopyWith<$Res> {
  _$TripConflictCopyWithImpl(this._self, this._then);

  final TripConflict _self;
  final $Res Function(TripConflict) _then;

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? existing = null,}) {
  return _then(TripConflict(
null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ConflictKind,null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as Trip,
  ));
}

/// Create a copy of TripEntryOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCopyWith<$Res> get existing {
  
  return $TripCopyWith<$Res>(_self.existing, (value) {
    return _then(_self.copyWith(existing: value));
  });
}
}

// dart format on
