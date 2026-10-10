// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayReport {

 DateTime get date;/// Часовой пояс водителя: в нём сервер относит поездки к дням.
 Duration get utcOffset; DaySummary get summary;/// Отсортированы по началу.
 List<Trip> get trips;
/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayReportCopyWith<DayReport> get copyWith => _$DayReportCopyWithImpl<DayReport>(this as DayReport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DayReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayReport&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.utcOffset, _this.utcOffset) || other.utcOffset == _this.utcOffset)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.trips, _this.trips));
}


@override
int get hashCode {
  final _this = this as DayReport;
  return Object.hash(runtimeType,_this.date,_this.utcOffset,_this.summary,const DeepCollectionEquality().hash(_this.trips));
}

@override
String toString() {
  final _this = this as DayReport;
  return 'DayReport(date: ${_this.date}, utcOffset: ${_this.utcOffset}, summary: ${_this.summary}, trips: ${_this.trips})';
}


}

/// @nodoc
abstract mixin class $DayReportCopyWith<$Res>  {
  factory $DayReportCopyWith(DayReport value, $Res Function(DayReport) _then) = _$DayReportCopyWithImpl;
@useResult
$Res call({
 DateTime date, Duration utcOffset, DaySummary summary, List<Trip> trips
});


$DaySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$DayReportCopyWithImpl<$Res>
    implements $DayReportCopyWith<$Res> {
  _$DayReportCopyWithImpl(this._self, this._then);

  final DayReport _self;
  final $Res Function(DayReport) _then;

/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? utcOffset = null,Object? summary = null,Object? trips = null,}) {
  return _then(DayReport(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DaySummary,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,
  ));
}
/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DaySummaryCopyWith<$Res> get summary {
  
  return $DaySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DayReport].
extension DayReportPatterns on DayReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayReport value)  $default,){
final _that = this;
switch (_that) {
case _DayReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayReport value)?  $default,){
final _that = this;
switch (_that) {
case _DayReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  Duration utcOffset,  DaySummary summary,  List<Trip> trips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayReport() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  Duration utcOffset,  DaySummary summary,  List<Trip> trips)  $default,) {final _that = this;
switch (_that) {
case _DayReport():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  Duration utcOffset,  DaySummary summary,  List<Trip> trips)?  $default,) {final _that = this;
switch (_that) {
case _DayReport() when $default != null:
return $default(_that.date,_that.utcOffset,_that.summary,_that.trips);case _:
  return null;

}
}

}

/// @nodoc


class _DayReport extends DayReport {
  const _DayReport({required this.date, required this.utcOffset, required this.summary, required  List<Trip> trips}): _trips = trips,super._();
  

@override final  DateTime date;
/// Часовой пояс водителя: в нём сервер относит поездки к дням.
@override final  Duration utcOffset;
@override final  DaySummary summary;
/// Отсортированы по началу.
 final  List<Trip> _trips;
/// Отсортированы по началу.
@override List<Trip> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}


/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayReportCopyWith<_DayReport> get copyWith => __$DayReportCopyWithImpl<_DayReport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayReport&&(identical(other.date, date) || other.date == date)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.trips, _trips));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,utcOffset,summary,const DeepCollectionEquality().hash(_trips));
}

@override
String toString() {
    return 'DayReport(date: $date, utcOffset: $utcOffset, summary: $summary, trips: $trips)';
}


}

/// @nodoc
abstract mixin class _$DayReportCopyWith<$Res> implements $DayReportCopyWith<$Res> {
  factory _$DayReportCopyWith(_DayReport value, $Res Function(_DayReport) _then) = __$DayReportCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, Duration utcOffset, DaySummary summary, List<Trip> trips
});


@override $DaySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$DayReportCopyWithImpl<$Res>
    implements _$DayReportCopyWith<$Res> {
  __$DayReportCopyWithImpl(this._self, this._then);

  final _DayReport _self;
  final $Res Function(_DayReport) _then;

/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? utcOffset = null,Object? summary = null,Object? trips = null,}) {
  return _then(_DayReport(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DaySummary,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,
  ));
}

/// Create a copy of DayReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DaySummaryCopyWith<$Res> get summary {
  
  return $DaySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
