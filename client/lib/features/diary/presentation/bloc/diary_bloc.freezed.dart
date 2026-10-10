// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaryEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiaryEvent()';
}


}

/// @nodoc
class $DiaryEventCopyWith<$Res>  {
$DiaryEventCopyWith(DiaryEvent _, $Res Function(DiaryEvent) __);
}


/// Adds pattern-matching-related methods to [DiaryEvent].
extension DiaryEventPatterns on DiaryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiaryStarted value)?  started,TResult Function( DiaryRefreshed value)?  refreshed,TResult Function( DiaryDaySelected value)?  daySelected,TResult Function( DiaryDayShifted value)?  dayShifted,TResult Function( DiaryTripSaved value)?  tripSaved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiaryStarted() when started != null:
return started(_that);case DiaryRefreshed() when refreshed != null:
return refreshed(_that);case DiaryDaySelected() when daySelected != null:
return daySelected(_that);case DiaryDayShifted() when dayShifted != null:
return dayShifted(_that);case DiaryTripSaved() when tripSaved != null:
return tripSaved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiaryStarted value)  started,required TResult Function( DiaryRefreshed value)  refreshed,required TResult Function( DiaryDaySelected value)  daySelected,required TResult Function( DiaryDayShifted value)  dayShifted,required TResult Function( DiaryTripSaved value)  tripSaved,}){
final _that = this;
switch (_that) {
case DiaryStarted():
return started(_that);case DiaryRefreshed():
return refreshed(_that);case DiaryDaySelected():
return daySelected(_that);case DiaryDayShifted():
return dayShifted(_that);case DiaryTripSaved():
return tripSaved(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiaryStarted value)?  started,TResult? Function( DiaryRefreshed value)?  refreshed,TResult? Function( DiaryDaySelected value)?  daySelected,TResult? Function( DiaryDayShifted value)?  dayShifted,TResult? Function( DiaryTripSaved value)?  tripSaved,}){
final _that = this;
switch (_that) {
case DiaryStarted() when started != null:
return started(_that);case DiaryRefreshed() when refreshed != null:
return refreshed(_that);case DiaryDaySelected() when daySelected != null:
return daySelected(_that);case DiaryDayShifted() when dayShifted != null:
return dayShifted(_that);case DiaryTripSaved() when tripSaved != null:
return tripSaved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( DateTime day)?  daySelected,TResult Function( int days)?  dayShifted,TResult Function( Trip trip)?  tripSaved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiaryStarted() when started != null:
return started();case DiaryRefreshed() when refreshed != null:
return refreshed();case DiaryDaySelected() when daySelected != null:
return daySelected(_that.day);case DiaryDayShifted() when dayShifted != null:
return dayShifted(_that.days);case DiaryTripSaved() when tripSaved != null:
return tripSaved(_that.trip);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( DateTime day)  daySelected,required TResult Function( int days)  dayShifted,required TResult Function( Trip trip)  tripSaved,}) {final _that = this;
switch (_that) {
case DiaryStarted():
return started();case DiaryRefreshed():
return refreshed();case DiaryDaySelected():
return daySelected(_that.day);case DiaryDayShifted():
return dayShifted(_that.days);case DiaryTripSaved():
return tripSaved(_that.trip);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( DateTime day)?  daySelected,TResult? Function( int days)?  dayShifted,TResult? Function( Trip trip)?  tripSaved,}) {final _that = this;
switch (_that) {
case DiaryStarted() when started != null:
return started();case DiaryRefreshed() when refreshed != null:
return refreshed();case DiaryDaySelected() when daySelected != null:
return daySelected(_that.day);case DiaryDayShifted() when dayShifted != null:
return dayShifted(_that.days);case DiaryTripSaved() when tripSaved != null:
return tripSaved(_that.trip);case _:
  return null;

}
}

}

/// @nodoc


class DiaryStarted implements DiaryEvent {
  const DiaryStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiaryEvent.started()';
}


}




/// @nodoc


class DiaryRefreshed implements DiaryEvent {
  const DiaryRefreshed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiaryEvent.refreshed()';
}


}




/// @nodoc


class DiaryDaySelected implements DiaryEvent {
  const DiaryDaySelected(this.day);
  

 final  DateTime day;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryDaySelectedCopyWith<DiaryDaySelected> get copyWith => _$DiaryDaySelectedCopyWithImpl<DiaryDaySelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryDaySelected&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day);
}

@override
String toString() {
    return 'DiaryEvent.daySelected(day: $day)';
}


}

/// @nodoc
abstract mixin class $DiaryDaySelectedCopyWith<$Res> implements $DiaryEventCopyWith<$Res> {
  factory $DiaryDaySelectedCopyWith(DiaryDaySelected value, $Res Function(DiaryDaySelected) _then) = _$DiaryDaySelectedCopyWithImpl;
@useResult
$Res call({
 DateTime day
});




}
/// @nodoc
class _$DiaryDaySelectedCopyWithImpl<$Res>
    implements $DiaryDaySelectedCopyWith<$Res> {
  _$DiaryDaySelectedCopyWithImpl(this._self, this._then);

  final DiaryDaySelected _self;
  final $Res Function(DiaryDaySelected) _then;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? day = null,}) {
  return _then(DiaryDaySelected(
null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class DiaryDayShifted implements DiaryEvent {
  const DiaryDayShifted(this.days);
  

 final  int days;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryDayShiftedCopyWith<DiaryDayShifted> get copyWith => _$DiaryDayShiftedCopyWithImpl<DiaryDayShifted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryDayShifted&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode {
    return Object.hash(runtimeType,days);
}

@override
String toString() {
    return 'DiaryEvent.dayShifted(days: $days)';
}


}

/// @nodoc
abstract mixin class $DiaryDayShiftedCopyWith<$Res> implements $DiaryEventCopyWith<$Res> {
  factory $DiaryDayShiftedCopyWith(DiaryDayShifted value, $Res Function(DiaryDayShifted) _then) = _$DiaryDayShiftedCopyWithImpl;
@useResult
$Res call({
 int days
});




}
/// @nodoc
class _$DiaryDayShiftedCopyWithImpl<$Res>
    implements $DiaryDayShiftedCopyWith<$Res> {
  _$DiaryDayShiftedCopyWithImpl(this._self, this._then);

  final DiaryDayShifted _self;
  final $Res Function(DiaryDayShifted) _then;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? days = null,}) {
  return _then(DiaryDayShifted(
null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DiaryTripSaved implements DiaryEvent {
  const DiaryTripSaved(this.trip);
  

 final  Trip trip;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryTripSavedCopyWith<DiaryTripSaved> get copyWith => _$DiaryTripSavedCopyWithImpl<DiaryTripSaved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryTripSaved&&(identical(other.trip, trip) || other.trip == trip));
}


@override
int get hashCode {
    return Object.hash(runtimeType,trip);
}

@override
String toString() {
    return 'DiaryEvent.tripSaved(trip: $trip)';
}


}

/// @nodoc
abstract mixin class $DiaryTripSavedCopyWith<$Res> implements $DiaryEventCopyWith<$Res> {
  factory $DiaryTripSavedCopyWith(DiaryTripSaved value, $Res Function(DiaryTripSaved) _then) = _$DiaryTripSavedCopyWithImpl;
@useResult
$Res call({
 Trip trip
});


$TripCopyWith<$Res> get trip;

}
/// @nodoc
class _$DiaryTripSavedCopyWithImpl<$Res>
    implements $DiaryTripSavedCopyWith<$Res> {
  _$DiaryTripSavedCopyWithImpl(this._self, this._then);

  final DiaryTripSaved _self;
  final $Res Function(DiaryTripSaved) _then;

/// Create a copy of DiaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? trip = null,}) {
  return _then(DiaryTripSaved(
null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as Trip,
  ));
}

/// Create a copy of DiaryEvent
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
mixin _$DiaryState {

 DateTime get today; DateTime get selectedDay; DiaryStatus get status;/// Отчёт за [selectedDay]; null, пока день грузится впервые.
 DayReport? get report; Failure? get failure; List<WorkDay> get workDays;/// Часовой пояс водителя, известен после первого ответа сервера.
 Duration? get utcOffset;
/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryStateCopyWith<DiaryState> get copyWith => _$DiaryStateCopyWithImpl<DiaryState>(this as DiaryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiaryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryState&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.selectedDay, _this.selectedDay) || other.selectedDay == _this.selectedDay)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.report, _this.report) || other.report == _this.report)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&const DeepCollectionEquality().equals(other.workDays, _this.workDays)&&(identical(other.utcOffset, _this.utcOffset) || other.utcOffset == _this.utcOffset));
}


@override
int get hashCode {
  final _this = this as DiaryState;
  return Object.hash(runtimeType,_this.today,_this.selectedDay,_this.status,_this.report,_this.failure,const DeepCollectionEquality().hash(_this.workDays),_this.utcOffset);
}

@override
String toString() {
  final _this = this as DiaryState;
  return 'DiaryState(today: ${_this.today}, selectedDay: ${_this.selectedDay}, status: ${_this.status}, report: ${_this.report}, failure: ${_this.failure}, workDays: ${_this.workDays}, utcOffset: ${_this.utcOffset})';
}


}

/// @nodoc
abstract mixin class $DiaryStateCopyWith<$Res>  {
  factory $DiaryStateCopyWith(DiaryState value, $Res Function(DiaryState) _then) = _$DiaryStateCopyWithImpl;
@useResult
$Res call({
 DateTime today, DateTime selectedDay, DiaryStatus status, DayReport? report, Failure? failure, List<WorkDay> workDays, Duration? utcOffset
});


$DayReportCopyWith<$Res>? get report;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DiaryStateCopyWithImpl<$Res>
    implements $DiaryStateCopyWith<$Res> {
  _$DiaryStateCopyWithImpl(this._self, this._then);

  final DiaryState _self;
  final $Res Function(DiaryState) _then;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? selectedDay = null,Object? status = null,Object? report = freezed,Object? failure = freezed,Object? workDays = null,Object? utcOffset = freezed,}) {
  return _then(DiaryState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiaryStatus,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as DayReport?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,workDays: null == workDays ? _self.workDays : workDays // ignore: cast_nullable_to_non_nullable
as List<WorkDay>,utcOffset: freezed == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}
/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DayReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $DayReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}/// Create a copy of DiaryState
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


/// Adds pattern-matching-related methods to [DiaryState].
extension DiaryStatePatterns on DiaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryState value)  $default,){
final _that = this;
switch (_that) {
case _DiaryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryState value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime today,  DateTime selectedDay,  DiaryStatus status,  DayReport? report,  Failure? failure,  List<WorkDay> workDays,  Duration? utcOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryState() when $default != null:
return $default(_that.today,_that.selectedDay,_that.status,_that.report,_that.failure,_that.workDays,_that.utcOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime today,  DateTime selectedDay,  DiaryStatus status,  DayReport? report,  Failure? failure,  List<WorkDay> workDays,  Duration? utcOffset)  $default,) {final _that = this;
switch (_that) {
case _DiaryState():
return $default(_that.today,_that.selectedDay,_that.status,_that.report,_that.failure,_that.workDays,_that.utcOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime today,  DateTime selectedDay,  DiaryStatus status,  DayReport? report,  Failure? failure,  List<WorkDay> workDays,  Duration? utcOffset)?  $default,) {final _that = this;
switch (_that) {
case _DiaryState() when $default != null:
return $default(_that.today,_that.selectedDay,_that.status,_that.report,_that.failure,_that.workDays,_that.utcOffset);case _:
  return null;

}
}

}

/// @nodoc


class _DiaryState extends DiaryState {
  const _DiaryState({required this.today, required this.selectedDay, this.status = DiaryStatus.loading, this.report, this.failure,  List<WorkDay> workDays = const <WorkDay>[], this.utcOffset}): _workDays = workDays,super._();
  

@override final  DateTime today;
@override final  DateTime selectedDay;
@override@JsonKey() final  DiaryStatus status;
/// Отчёт за [selectedDay]; null, пока день грузится впервые.
@override final  DayReport? report;
@override final  Failure? failure;
 final  List<WorkDay> _workDays;
@override@JsonKey() List<WorkDay> get workDays {
  if (_workDays is EqualUnmodifiableListView) return _workDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workDays);
}

/// Часовой пояс водителя, известен после первого ответа сервера.
@override final  Duration? utcOffset;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryStateCopyWith<_DiaryState> get copyWith => __$DiaryStateCopyWithImpl<_DiaryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryState&&(identical(other.today, today) || other.today == today)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay)&&(identical(other.status, status) || other.status == status)&&(identical(other.report, report) || other.report == report)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.workDays, _workDays)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,selectedDay,status,report,failure,const DeepCollectionEquality().hash(_workDays),utcOffset);
}

@override
String toString() {
    return 'DiaryState(today: $today, selectedDay: $selectedDay, status: $status, report: $report, failure: $failure, workDays: $workDays, utcOffset: $utcOffset)';
}


}

/// @nodoc
abstract mixin class _$DiaryStateCopyWith<$Res> implements $DiaryStateCopyWith<$Res> {
  factory _$DiaryStateCopyWith(_DiaryState value, $Res Function(_DiaryState) _then) = __$DiaryStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime today, DateTime selectedDay, DiaryStatus status, DayReport? report, Failure? failure, List<WorkDay> workDays, Duration? utcOffset
});


@override $DayReportCopyWith<$Res>? get report;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DiaryStateCopyWithImpl<$Res>
    implements _$DiaryStateCopyWith<$Res> {
  __$DiaryStateCopyWithImpl(this._self, this._then);

  final _DiaryState _self;
  final $Res Function(_DiaryState) _then;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? selectedDay = null,Object? status = null,Object? report = freezed,Object? failure = freezed,Object? workDays = null,Object? utcOffset = freezed,}) {
  return _then(_DiaryState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiaryStatus,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as DayReport?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,workDays: null == workDays ? _self._workDays : workDays // ignore: cast_nullable_to_non_nullable
as List<WorkDay>,utcOffset: freezed == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DayReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $DayReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}/// Create a copy of DiaryState
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
