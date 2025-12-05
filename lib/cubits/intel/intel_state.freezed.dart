// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntelState {

 List<dynamic> get realtimeData; List<dynamic> get pendingData; String get lastId; int get lastCreateAt; bool get isLoading; bool get isConnected; String get errorMessage; List<Intel>? get allMessages; List<String> get visibleIds; int get eventPage; int get eventPageSize; bool get isFetchingMore; bool get isNotMore;// @Default([]) List<String> unreadIds,
 List<Intel> get unreadIntels; List<Intel> get singleIntelligences; int get singlePage; int get singlePageSize; String get singleId; List<Intel> get eventIntelligences; bool get isFetchingSingleMore; bool get isNotSingleMore; List<SingleTypeOptions> get singleTypeOptions; bool get showUnreadBar;// @Default(false) bool isTop
 bool get isTopped;
/// Create a copy of IntelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelStateCopyWith<IntelState> get copyWith => _$IntelStateCopyWithImpl<IntelState>(this as IntelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelState&&const DeepCollectionEquality().equals(other.realtimeData, realtimeData)&&const DeepCollectionEquality().equals(other.pendingData, pendingData)&&(identical(other.lastId, lastId) || other.lastId == lastId)&&(identical(other.lastCreateAt, lastCreateAt) || other.lastCreateAt == lastCreateAt)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.allMessages, allMessages)&&const DeepCollectionEquality().equals(other.visibleIds, visibleIds)&&(identical(other.eventPage, eventPage) || other.eventPage == eventPage)&&(identical(other.eventPageSize, eventPageSize) || other.eventPageSize == eventPageSize)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore)&&(identical(other.isNotMore, isNotMore) || other.isNotMore == isNotMore)&&const DeepCollectionEquality().equals(other.unreadIntels, unreadIntels)&&const DeepCollectionEquality().equals(other.singleIntelligences, singleIntelligences)&&(identical(other.singlePage, singlePage) || other.singlePage == singlePage)&&(identical(other.singlePageSize, singlePageSize) || other.singlePageSize == singlePageSize)&&(identical(other.singleId, singleId) || other.singleId == singleId)&&const DeepCollectionEquality().equals(other.eventIntelligences, eventIntelligences)&&(identical(other.isFetchingSingleMore, isFetchingSingleMore) || other.isFetchingSingleMore == isFetchingSingleMore)&&(identical(other.isNotSingleMore, isNotSingleMore) || other.isNotSingleMore == isNotSingleMore)&&const DeepCollectionEquality().equals(other.singleTypeOptions, singleTypeOptions)&&(identical(other.showUnreadBar, showUnreadBar) || other.showUnreadBar == showUnreadBar)&&(identical(other.isTopped, isTopped) || other.isTopped == isTopped));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(realtimeData),const DeepCollectionEquality().hash(pendingData),lastId,lastCreateAt,isLoading,isConnected,errorMessage,const DeepCollectionEquality().hash(allMessages),const DeepCollectionEquality().hash(visibleIds),eventPage,eventPageSize,isFetchingMore,isNotMore,const DeepCollectionEquality().hash(unreadIntels),const DeepCollectionEquality().hash(singleIntelligences),singlePage,singlePageSize,singleId,const DeepCollectionEquality().hash(eventIntelligences),isFetchingSingleMore,isNotSingleMore,const DeepCollectionEquality().hash(singleTypeOptions),showUnreadBar,isTopped]);

@override
String toString() {
  return 'IntelState(realtimeData: $realtimeData, pendingData: $pendingData, lastId: $lastId, lastCreateAt: $lastCreateAt, isLoading: $isLoading, isConnected: $isConnected, errorMessage: $errorMessage, allMessages: $allMessages, visibleIds: $visibleIds, eventPage: $eventPage, eventPageSize: $eventPageSize, isFetchingMore: $isFetchingMore, isNotMore: $isNotMore, unreadIntels: $unreadIntels, singleIntelligences: $singleIntelligences, singlePage: $singlePage, singlePageSize: $singlePageSize, singleId: $singleId, eventIntelligences: $eventIntelligences, isFetchingSingleMore: $isFetchingSingleMore, isNotSingleMore: $isNotSingleMore, singleTypeOptions: $singleTypeOptions, showUnreadBar: $showUnreadBar, isTopped: $isTopped)';
}


}

/// @nodoc
abstract mixin class $IntelStateCopyWith<$Res>  {
  factory $IntelStateCopyWith(IntelState value, $Res Function(IntelState) _then) = _$IntelStateCopyWithImpl;
@useResult
$Res call({
 List<dynamic> realtimeData, List<dynamic> pendingData, String lastId, int lastCreateAt, bool isLoading, bool isConnected, String errorMessage, List<Intel>? allMessages, List<String> visibleIds, int eventPage, int eventPageSize, bool isFetchingMore, bool isNotMore, List<Intel> unreadIntels, List<Intel> singleIntelligences, int singlePage, int singlePageSize, String singleId, List<Intel> eventIntelligences, bool isFetchingSingleMore, bool isNotSingleMore, List<SingleTypeOptions> singleTypeOptions, bool showUnreadBar, bool isTopped
});




}
/// @nodoc
class _$IntelStateCopyWithImpl<$Res>
    implements $IntelStateCopyWith<$Res> {
  _$IntelStateCopyWithImpl(this._self, this._then);

  final IntelState _self;
  final $Res Function(IntelState) _then;

/// Create a copy of IntelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? realtimeData = null,Object? pendingData = null,Object? lastId = null,Object? lastCreateAt = null,Object? isLoading = null,Object? isConnected = null,Object? errorMessage = null,Object? allMessages = freezed,Object? visibleIds = null,Object? eventPage = null,Object? eventPageSize = null,Object? isFetchingMore = null,Object? isNotMore = null,Object? unreadIntels = null,Object? singleIntelligences = null,Object? singlePage = null,Object? singlePageSize = null,Object? singleId = null,Object? eventIntelligences = null,Object? isFetchingSingleMore = null,Object? isNotSingleMore = null,Object? singleTypeOptions = null,Object? showUnreadBar = null,Object? isTopped = null,}) {
  return _then(_self.copyWith(
realtimeData: null == realtimeData ? _self.realtimeData : realtimeData // ignore: cast_nullable_to_non_nullable
as List<dynamic>,pendingData: null == pendingData ? _self.pendingData : pendingData // ignore: cast_nullable_to_non_nullable
as List<dynamic>,lastId: null == lastId ? _self.lastId : lastId // ignore: cast_nullable_to_non_nullable
as String,lastCreateAt: null == lastCreateAt ? _self.lastCreateAt : lastCreateAt // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,allMessages: freezed == allMessages ? _self.allMessages : allMessages // ignore: cast_nullable_to_non_nullable
as List<Intel>?,visibleIds: null == visibleIds ? _self.visibleIds : visibleIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventPage: null == eventPage ? _self.eventPage : eventPage // ignore: cast_nullable_to_non_nullable
as int,eventPageSize: null == eventPageSize ? _self.eventPageSize : eventPageSize // ignore: cast_nullable_to_non_nullable
as int,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,isNotMore: null == isNotMore ? _self.isNotMore : isNotMore // ignore: cast_nullable_to_non_nullable
as bool,unreadIntels: null == unreadIntels ? _self.unreadIntels : unreadIntels // ignore: cast_nullable_to_non_nullable
as List<Intel>,singleIntelligences: null == singleIntelligences ? _self.singleIntelligences : singleIntelligences // ignore: cast_nullable_to_non_nullable
as List<Intel>,singlePage: null == singlePage ? _self.singlePage : singlePage // ignore: cast_nullable_to_non_nullable
as int,singlePageSize: null == singlePageSize ? _self.singlePageSize : singlePageSize // ignore: cast_nullable_to_non_nullable
as int,singleId: null == singleId ? _self.singleId : singleId // ignore: cast_nullable_to_non_nullable
as String,eventIntelligences: null == eventIntelligences ? _self.eventIntelligences : eventIntelligences // ignore: cast_nullable_to_non_nullable
as List<Intel>,isFetchingSingleMore: null == isFetchingSingleMore ? _self.isFetchingSingleMore : isFetchingSingleMore // ignore: cast_nullable_to_non_nullable
as bool,isNotSingleMore: null == isNotSingleMore ? _self.isNotSingleMore : isNotSingleMore // ignore: cast_nullable_to_non_nullable
as bool,singleTypeOptions: null == singleTypeOptions ? _self.singleTypeOptions : singleTypeOptions // ignore: cast_nullable_to_non_nullable
as List<SingleTypeOptions>,showUnreadBar: null == showUnreadBar ? _self.showUnreadBar : showUnreadBar // ignore: cast_nullable_to_non_nullable
as bool,isTopped: null == isTopped ? _self.isTopped : isTopped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelState].
extension IntelStatePatterns on IntelState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelState value)  $default,){
final _that = this;
switch (_that) {
case _IntelState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelState value)?  $default,){
final _that = this;
switch (_that) {
case _IntelState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic> realtimeData,  List<dynamic> pendingData,  String lastId,  int lastCreateAt,  bool isLoading,  bool isConnected,  String errorMessage,  List<Intel>? allMessages,  List<String> visibleIds,  int eventPage,  int eventPageSize,  bool isFetchingMore,  bool isNotMore,  List<Intel> unreadIntels,  List<Intel> singleIntelligences,  int singlePage,  int singlePageSize,  String singleId,  List<Intel> eventIntelligences,  bool isFetchingSingleMore,  bool isNotSingleMore,  List<SingleTypeOptions> singleTypeOptions,  bool showUnreadBar,  bool isTopped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelState() when $default != null:
return $default(_that.realtimeData,_that.pendingData,_that.lastId,_that.lastCreateAt,_that.isLoading,_that.isConnected,_that.errorMessage,_that.allMessages,_that.visibleIds,_that.eventPage,_that.eventPageSize,_that.isFetchingMore,_that.isNotMore,_that.unreadIntels,_that.singleIntelligences,_that.singlePage,_that.singlePageSize,_that.singleId,_that.eventIntelligences,_that.isFetchingSingleMore,_that.isNotSingleMore,_that.singleTypeOptions,_that.showUnreadBar,_that.isTopped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic> realtimeData,  List<dynamic> pendingData,  String lastId,  int lastCreateAt,  bool isLoading,  bool isConnected,  String errorMessage,  List<Intel>? allMessages,  List<String> visibleIds,  int eventPage,  int eventPageSize,  bool isFetchingMore,  bool isNotMore,  List<Intel> unreadIntels,  List<Intel> singleIntelligences,  int singlePage,  int singlePageSize,  String singleId,  List<Intel> eventIntelligences,  bool isFetchingSingleMore,  bool isNotSingleMore,  List<SingleTypeOptions> singleTypeOptions,  bool showUnreadBar,  bool isTopped)  $default,) {final _that = this;
switch (_that) {
case _IntelState():
return $default(_that.realtimeData,_that.pendingData,_that.lastId,_that.lastCreateAt,_that.isLoading,_that.isConnected,_that.errorMessage,_that.allMessages,_that.visibleIds,_that.eventPage,_that.eventPageSize,_that.isFetchingMore,_that.isNotMore,_that.unreadIntels,_that.singleIntelligences,_that.singlePage,_that.singlePageSize,_that.singleId,_that.eventIntelligences,_that.isFetchingSingleMore,_that.isNotSingleMore,_that.singleTypeOptions,_that.showUnreadBar,_that.isTopped);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic> realtimeData,  List<dynamic> pendingData,  String lastId,  int lastCreateAt,  bool isLoading,  bool isConnected,  String errorMessage,  List<Intel>? allMessages,  List<String> visibleIds,  int eventPage,  int eventPageSize,  bool isFetchingMore,  bool isNotMore,  List<Intel> unreadIntels,  List<Intel> singleIntelligences,  int singlePage,  int singlePageSize,  String singleId,  List<Intel> eventIntelligences,  bool isFetchingSingleMore,  bool isNotSingleMore,  List<SingleTypeOptions> singleTypeOptions,  bool showUnreadBar,  bool isTopped)?  $default,) {final _that = this;
switch (_that) {
case _IntelState() when $default != null:
return $default(_that.realtimeData,_that.pendingData,_that.lastId,_that.lastCreateAt,_that.isLoading,_that.isConnected,_that.errorMessage,_that.allMessages,_that.visibleIds,_that.eventPage,_that.eventPageSize,_that.isFetchingMore,_that.isNotMore,_that.unreadIntels,_that.singleIntelligences,_that.singlePage,_that.singlePageSize,_that.singleId,_that.eventIntelligences,_that.isFetchingSingleMore,_that.isNotSingleMore,_that.singleTypeOptions,_that.showUnreadBar,_that.isTopped);case _:
  return null;

}
}

}

/// @nodoc


class _IntelState implements IntelState {
  const _IntelState({final  List<dynamic> realtimeData = const [], final  List<dynamic> pendingData = const [], this.lastId = '', this.lastCreateAt = 0, this.isLoading = false, this.isConnected = false, this.errorMessage = '', final  List<Intel>? allMessages = const [], final  List<String> visibleIds = const [], this.eventPage = 1, this.eventPageSize = 10, this.isFetchingMore = false, this.isNotMore = false, final  List<Intel> unreadIntels = const [], final  List<Intel> singleIntelligences = const [], this.singlePage = 1, this.singlePageSize = 10, this.singleId = 'all', final  List<Intel> eventIntelligences = const [], this.isFetchingSingleMore = false, this.isNotSingleMore = false, final  List<SingleTypeOptions> singleTypeOptions = const [], this.showUnreadBar = false, this.isTopped = false}): _realtimeData = realtimeData,_pendingData = pendingData,_allMessages = allMessages,_visibleIds = visibleIds,_unreadIntels = unreadIntels,_singleIntelligences = singleIntelligences,_eventIntelligences = eventIntelligences,_singleTypeOptions = singleTypeOptions;
  

 final  List<dynamic> _realtimeData;
@override@JsonKey() List<dynamic> get realtimeData {
  if (_realtimeData is EqualUnmodifiableListView) return _realtimeData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_realtimeData);
}

 final  List<dynamic> _pendingData;
@override@JsonKey() List<dynamic> get pendingData {
  if (_pendingData is EqualUnmodifiableListView) return _pendingData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingData);
}

@override@JsonKey() final  String lastId;
@override@JsonKey() final  int lastCreateAt;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  String errorMessage;
 final  List<Intel>? _allMessages;
@override@JsonKey() List<Intel>? get allMessages {
  final value = _allMessages;
  if (value == null) return null;
  if (_allMessages is EqualUnmodifiableListView) return _allMessages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String> _visibleIds;
@override@JsonKey() List<String> get visibleIds {
  if (_visibleIds is EqualUnmodifiableListView) return _visibleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleIds);
}

@override@JsonKey() final  int eventPage;
@override@JsonKey() final  int eventPageSize;
@override@JsonKey() final  bool isFetchingMore;
@override@JsonKey() final  bool isNotMore;
// @Default([]) List<String> unreadIds,
 final  List<Intel> _unreadIntels;
// @Default([]) List<String> unreadIds,
@override@JsonKey() List<Intel> get unreadIntels {
  if (_unreadIntels is EqualUnmodifiableListView) return _unreadIntels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unreadIntels);
}

 final  List<Intel> _singleIntelligences;
@override@JsonKey() List<Intel> get singleIntelligences {
  if (_singleIntelligences is EqualUnmodifiableListView) return _singleIntelligences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_singleIntelligences);
}

@override@JsonKey() final  int singlePage;
@override@JsonKey() final  int singlePageSize;
@override@JsonKey() final  String singleId;
 final  List<Intel> _eventIntelligences;
@override@JsonKey() List<Intel> get eventIntelligences {
  if (_eventIntelligences is EqualUnmodifiableListView) return _eventIntelligences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIntelligences);
}

@override@JsonKey() final  bool isFetchingSingleMore;
@override@JsonKey() final  bool isNotSingleMore;
 final  List<SingleTypeOptions> _singleTypeOptions;
@override@JsonKey() List<SingleTypeOptions> get singleTypeOptions {
  if (_singleTypeOptions is EqualUnmodifiableListView) return _singleTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_singleTypeOptions);
}

@override@JsonKey() final  bool showUnreadBar;
// @Default(false) bool isTop
@override@JsonKey() final  bool isTopped;

/// Create a copy of IntelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelStateCopyWith<_IntelState> get copyWith => __$IntelStateCopyWithImpl<_IntelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelState&&const DeepCollectionEquality().equals(other._realtimeData, _realtimeData)&&const DeepCollectionEquality().equals(other._pendingData, _pendingData)&&(identical(other.lastId, lastId) || other.lastId == lastId)&&(identical(other.lastCreateAt, lastCreateAt) || other.lastCreateAt == lastCreateAt)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._allMessages, _allMessages)&&const DeepCollectionEquality().equals(other._visibleIds, _visibleIds)&&(identical(other.eventPage, eventPage) || other.eventPage == eventPage)&&(identical(other.eventPageSize, eventPageSize) || other.eventPageSize == eventPageSize)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore)&&(identical(other.isNotMore, isNotMore) || other.isNotMore == isNotMore)&&const DeepCollectionEquality().equals(other._unreadIntels, _unreadIntels)&&const DeepCollectionEquality().equals(other._singleIntelligences, _singleIntelligences)&&(identical(other.singlePage, singlePage) || other.singlePage == singlePage)&&(identical(other.singlePageSize, singlePageSize) || other.singlePageSize == singlePageSize)&&(identical(other.singleId, singleId) || other.singleId == singleId)&&const DeepCollectionEquality().equals(other._eventIntelligences, _eventIntelligences)&&(identical(other.isFetchingSingleMore, isFetchingSingleMore) || other.isFetchingSingleMore == isFetchingSingleMore)&&(identical(other.isNotSingleMore, isNotSingleMore) || other.isNotSingleMore == isNotSingleMore)&&const DeepCollectionEquality().equals(other._singleTypeOptions, _singleTypeOptions)&&(identical(other.showUnreadBar, showUnreadBar) || other.showUnreadBar == showUnreadBar)&&(identical(other.isTopped, isTopped) || other.isTopped == isTopped));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_realtimeData),const DeepCollectionEquality().hash(_pendingData),lastId,lastCreateAt,isLoading,isConnected,errorMessage,const DeepCollectionEquality().hash(_allMessages),const DeepCollectionEquality().hash(_visibleIds),eventPage,eventPageSize,isFetchingMore,isNotMore,const DeepCollectionEquality().hash(_unreadIntels),const DeepCollectionEquality().hash(_singleIntelligences),singlePage,singlePageSize,singleId,const DeepCollectionEquality().hash(_eventIntelligences),isFetchingSingleMore,isNotSingleMore,const DeepCollectionEquality().hash(_singleTypeOptions),showUnreadBar,isTopped]);

@override
String toString() {
  return 'IntelState(realtimeData: $realtimeData, pendingData: $pendingData, lastId: $lastId, lastCreateAt: $lastCreateAt, isLoading: $isLoading, isConnected: $isConnected, errorMessage: $errorMessage, allMessages: $allMessages, visibleIds: $visibleIds, eventPage: $eventPage, eventPageSize: $eventPageSize, isFetchingMore: $isFetchingMore, isNotMore: $isNotMore, unreadIntels: $unreadIntels, singleIntelligences: $singleIntelligences, singlePage: $singlePage, singlePageSize: $singlePageSize, singleId: $singleId, eventIntelligences: $eventIntelligences, isFetchingSingleMore: $isFetchingSingleMore, isNotSingleMore: $isNotSingleMore, singleTypeOptions: $singleTypeOptions, showUnreadBar: $showUnreadBar, isTopped: $isTopped)';
}


}

/// @nodoc
abstract mixin class _$IntelStateCopyWith<$Res> implements $IntelStateCopyWith<$Res> {
  factory _$IntelStateCopyWith(_IntelState value, $Res Function(_IntelState) _then) = __$IntelStateCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> realtimeData, List<dynamic> pendingData, String lastId, int lastCreateAt, bool isLoading, bool isConnected, String errorMessage, List<Intel>? allMessages, List<String> visibleIds, int eventPage, int eventPageSize, bool isFetchingMore, bool isNotMore, List<Intel> unreadIntels, List<Intel> singleIntelligences, int singlePage, int singlePageSize, String singleId, List<Intel> eventIntelligences, bool isFetchingSingleMore, bool isNotSingleMore, List<SingleTypeOptions> singleTypeOptions, bool showUnreadBar, bool isTopped
});




}
/// @nodoc
class __$IntelStateCopyWithImpl<$Res>
    implements _$IntelStateCopyWith<$Res> {
  __$IntelStateCopyWithImpl(this._self, this._then);

  final _IntelState _self;
  final $Res Function(_IntelState) _then;

/// Create a copy of IntelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? realtimeData = null,Object? pendingData = null,Object? lastId = null,Object? lastCreateAt = null,Object? isLoading = null,Object? isConnected = null,Object? errorMessage = null,Object? allMessages = freezed,Object? visibleIds = null,Object? eventPage = null,Object? eventPageSize = null,Object? isFetchingMore = null,Object? isNotMore = null,Object? unreadIntels = null,Object? singleIntelligences = null,Object? singlePage = null,Object? singlePageSize = null,Object? singleId = null,Object? eventIntelligences = null,Object? isFetchingSingleMore = null,Object? isNotSingleMore = null,Object? singleTypeOptions = null,Object? showUnreadBar = null,Object? isTopped = null,}) {
  return _then(_IntelState(
realtimeData: null == realtimeData ? _self._realtimeData : realtimeData // ignore: cast_nullable_to_non_nullable
as List<dynamic>,pendingData: null == pendingData ? _self._pendingData : pendingData // ignore: cast_nullable_to_non_nullable
as List<dynamic>,lastId: null == lastId ? _self.lastId : lastId // ignore: cast_nullable_to_non_nullable
as String,lastCreateAt: null == lastCreateAt ? _self.lastCreateAt : lastCreateAt // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,allMessages: freezed == allMessages ? _self._allMessages : allMessages // ignore: cast_nullable_to_non_nullable
as List<Intel>?,visibleIds: null == visibleIds ? _self._visibleIds : visibleIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventPage: null == eventPage ? _self.eventPage : eventPage // ignore: cast_nullable_to_non_nullable
as int,eventPageSize: null == eventPageSize ? _self.eventPageSize : eventPageSize // ignore: cast_nullable_to_non_nullable
as int,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,isNotMore: null == isNotMore ? _self.isNotMore : isNotMore // ignore: cast_nullable_to_non_nullable
as bool,unreadIntels: null == unreadIntels ? _self._unreadIntels : unreadIntels // ignore: cast_nullable_to_non_nullable
as List<Intel>,singleIntelligences: null == singleIntelligences ? _self._singleIntelligences : singleIntelligences // ignore: cast_nullable_to_non_nullable
as List<Intel>,singlePage: null == singlePage ? _self.singlePage : singlePage // ignore: cast_nullable_to_non_nullable
as int,singlePageSize: null == singlePageSize ? _self.singlePageSize : singlePageSize // ignore: cast_nullable_to_non_nullable
as int,singleId: null == singleId ? _self.singleId : singleId // ignore: cast_nullable_to_non_nullable
as String,eventIntelligences: null == eventIntelligences ? _self._eventIntelligences : eventIntelligences // ignore: cast_nullable_to_non_nullable
as List<Intel>,isFetchingSingleMore: null == isFetchingSingleMore ? _self.isFetchingSingleMore : isFetchingSingleMore // ignore: cast_nullable_to_non_nullable
as bool,isNotSingleMore: null == isNotSingleMore ? _self.isNotSingleMore : isNotSingleMore // ignore: cast_nullable_to_non_nullable
as bool,singleTypeOptions: null == singleTypeOptions ? _self._singleTypeOptions : singleTypeOptions // ignore: cast_nullable_to_non_nullable
as List<SingleTypeOptions>,showUnreadBar: null == showUnreadBar ? _self.showUnreadBar : showUnreadBar // ignore: cast_nullable_to_non_nullable
as bool,isTopped: null == isTopped ? _self.isTopped : isTopped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
