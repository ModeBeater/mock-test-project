// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NoConnectionFailure value)?  noConnection,TResult Function( TimeoutFailure value)?  timeout,TResult Function( ServerFailure value)?  server,TResult Function( RejectedFailure value)?  rejected,TResult Function( MalformedResponseFailure value)?  malformedResponse,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NoConnectionFailure() when noConnection != null:
return noConnection(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case ServerFailure() when server != null:
return server(_that);case RejectedFailure() when rejected != null:
return rejected(_that);case MalformedResponseFailure() when malformedResponse != null:
return malformedResponse(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NoConnectionFailure value)  noConnection,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( ServerFailure value)  server,required TResult Function( RejectedFailure value)  rejected,required TResult Function( MalformedResponseFailure value)  malformedResponse,}){
final _that = this;
switch (_that) {
case NoConnectionFailure():
return noConnection(_that);case TimeoutFailure():
return timeout(_that);case ServerFailure():
return server(_that);case RejectedFailure():
return rejected(_that);case MalformedResponseFailure():
return malformedResponse(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NoConnectionFailure value)?  noConnection,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( ServerFailure value)?  server,TResult? Function( RejectedFailure value)?  rejected,TResult? Function( MalformedResponseFailure value)?  malformedResponse,}){
final _that = this;
switch (_that) {
case NoConnectionFailure() when noConnection != null:
return noConnection(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case ServerFailure() when server != null:
return server(_that);case RejectedFailure() when rejected != null:
return rejected(_that);case MalformedResponseFailure() when malformedResponse != null:
return malformedResponse(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  noConnection,TResult Function()?  timeout,TResult Function( int statusCode)?  server,TResult Function( String message)?  rejected,TResult Function()?  malformedResponse,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NoConnectionFailure() when noConnection != null:
return noConnection();case TimeoutFailure() when timeout != null:
return timeout();case ServerFailure() when server != null:
return server(_that.statusCode);case RejectedFailure() when rejected != null:
return rejected(_that.message);case MalformedResponseFailure() when malformedResponse != null:
return malformedResponse();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  noConnection,required TResult Function()  timeout,required TResult Function( int statusCode)  server,required TResult Function( String message)  rejected,required TResult Function()  malformedResponse,}) {final _that = this;
switch (_that) {
case NoConnectionFailure():
return noConnection();case TimeoutFailure():
return timeout();case ServerFailure():
return server(_that.statusCode);case RejectedFailure():
return rejected(_that.message);case MalformedResponseFailure():
return malformedResponse();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  noConnection,TResult? Function()?  timeout,TResult? Function( int statusCode)?  server,TResult? Function( String message)?  rejected,TResult? Function()?  malformedResponse,}) {final _that = this;
switch (_that) {
case NoConnectionFailure() when noConnection != null:
return noConnection();case TimeoutFailure() when timeout != null:
return timeout();case ServerFailure() when server != null:
return server(_that.statusCode);case RejectedFailure() when rejected != null:
return rejected(_that.message);case MalformedResponseFailure() when malformedResponse != null:
return malformedResponse();case _:
  return null;

}
}

}

/// @nodoc


class NoConnectionFailure implements Failure {
  const NoConnectionFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NoConnectionFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.noConnection()';
}


}




/// @nodoc


class TimeoutFailure implements Failure {
  const TimeoutFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.timeout()';
}


}




/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure(this.statusCode);
  

 final  int statusCode;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,statusCode);
}

@override
String toString() {
    return 'Failure.server(statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 int statusCode
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,}) {
  return _then(ServerFailure(
null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RejectedFailure implements Failure {
  const RejectedFailure(this.message);
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RejectedFailureCopyWith<RejectedFailure> get copyWith => _$RejectedFailureCopyWithImpl<RejectedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RejectedFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'Failure.rejected(message: $message)';
}


}

/// @nodoc
abstract mixin class $RejectedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $RejectedFailureCopyWith(RejectedFailure value, $Res Function(RejectedFailure) _then) = _$RejectedFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RejectedFailureCopyWithImpl<$Res>
    implements $RejectedFailureCopyWith<$Res> {
  _$RejectedFailureCopyWithImpl(this._self, this._then);

  final RejectedFailure _self;
  final $Res Function(RejectedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RejectedFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MalformedResponseFailure implements Failure {
  const MalformedResponseFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MalformedResponseFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.malformedResponse()';
}


}




// dart format on
