// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IntelState {
// @Default([]) List<IntelMessage> realtimeData,
// @Default([]) List<IntelMessage> pendingData,
  List<dynamic> get realtimeData => throw _privateConstructorUsedError;
  List<dynamic> get pendingData => throw _privateConstructorUsedError;
  String get lastId => throw _privateConstructorUsedError;
  int get lastCreateAt => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<Intel>? get allMessages => throw _privateConstructorUsedError;
  List<String> get visibleIds => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;

  /// Create a copy of IntelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelStateCopyWith<IntelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelStateCopyWith<$Res> {
  factory $IntelStateCopyWith(
          IntelState value, $Res Function(IntelState) then) =
      _$IntelStateCopyWithImpl<$Res, IntelState>;
  @useResult
  $Res call(
      {List<dynamic> realtimeData,
      List<dynamic> pendingData,
      String lastId,
      int lastCreateAt,
      bool isLoading,
      bool isConnected,
      String errorMessage,
      List<Intel>? allMessages,
      List<String> visibleIds,
      int page,
      int pageSize});
}

/// @nodoc
class _$IntelStateCopyWithImpl<$Res, $Val extends IntelState>
    implements $IntelStateCopyWith<$Res> {
  _$IntelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realtimeData = null,
    Object? pendingData = null,
    Object? lastId = null,
    Object? lastCreateAt = null,
    Object? isLoading = null,
    Object? isConnected = null,
    Object? errorMessage = null,
    Object? allMessages = freezed,
    Object? visibleIds = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      realtimeData: null == realtimeData
          ? _value.realtimeData
          : realtimeData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      pendingData: null == pendingData
          ? _value.pendingData
          : pendingData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      lastId: null == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as String,
      lastCreateAt: null == lastCreateAt
          ? _value.lastCreateAt
          : lastCreateAt // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      allMessages: freezed == allMessages
          ? _value.allMessages
          : allMessages // ignore: cast_nullable_to_non_nullable
              as List<Intel>?,
      visibleIds: null == visibleIds
          ? _value.visibleIds
          : visibleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelStateImplCopyWith<$Res>
    implements $IntelStateCopyWith<$Res> {
  factory _$$IntelStateImplCopyWith(
          _$IntelStateImpl value, $Res Function(_$IntelStateImpl) then) =
      __$$IntelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<dynamic> realtimeData,
      List<dynamic> pendingData,
      String lastId,
      int lastCreateAt,
      bool isLoading,
      bool isConnected,
      String errorMessage,
      List<Intel>? allMessages,
      List<String> visibleIds,
      int page,
      int pageSize});
}

/// @nodoc
class __$$IntelStateImplCopyWithImpl<$Res>
    extends _$IntelStateCopyWithImpl<$Res, _$IntelStateImpl>
    implements _$$IntelStateImplCopyWith<$Res> {
  __$$IntelStateImplCopyWithImpl(
      _$IntelStateImpl _value, $Res Function(_$IntelStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realtimeData = null,
    Object? pendingData = null,
    Object? lastId = null,
    Object? lastCreateAt = null,
    Object? isLoading = null,
    Object? isConnected = null,
    Object? errorMessage = null,
    Object? allMessages = freezed,
    Object? visibleIds = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_$IntelStateImpl(
      realtimeData: null == realtimeData
          ? _value._realtimeData
          : realtimeData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      pendingData: null == pendingData
          ? _value._pendingData
          : pendingData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      lastId: null == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as String,
      lastCreateAt: null == lastCreateAt
          ? _value.lastCreateAt
          : lastCreateAt // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      allMessages: freezed == allMessages
          ? _value._allMessages
          : allMessages // ignore: cast_nullable_to_non_nullable
              as List<Intel>?,
      visibleIds: null == visibleIds
          ? _value._visibleIds
          : visibleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$IntelStateImpl implements _IntelState {
  const _$IntelStateImpl(
      {final List<dynamic> realtimeData = const [],
      final List<dynamic> pendingData = const [],
      this.lastId = '',
      this.lastCreateAt = 0,
      this.isLoading = false,
      this.isConnected = false,
      this.errorMessage = '',
      final List<Intel>? allMessages = const [],
      final List<String> visibleIds = const [],
      this.page = 0,
      this.pageSize = 10})
      : _realtimeData = realtimeData,
        _pendingData = pendingData,
        _allMessages = allMessages,
        _visibleIds = visibleIds;

// @Default([]) List<IntelMessage> realtimeData,
// @Default([]) List<IntelMessage> pendingData,
  final List<dynamic> _realtimeData;
// @Default([]) List<IntelMessage> realtimeData,
// @Default([]) List<IntelMessage> pendingData,
  @override
  @JsonKey()
  List<dynamic> get realtimeData {
    if (_realtimeData is EqualUnmodifiableListView) return _realtimeData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_realtimeData);
  }

  final List<dynamic> _pendingData;
  @override
  @JsonKey()
  List<dynamic> get pendingData {
    if (_pendingData is EqualUnmodifiableListView) return _pendingData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingData);
  }

  @override
  @JsonKey()
  final String lastId;
  @override
  @JsonKey()
  final int lastCreateAt;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final String errorMessage;
  final List<Intel>? _allMessages;
  @override
  @JsonKey()
  List<Intel>? get allMessages {
    final value = _allMessages;
    if (value == null) return null;
    if (_allMessages is EqualUnmodifiableListView) return _allMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _visibleIds;
  @override
  @JsonKey()
  List<String> get visibleIds {
    if (_visibleIds is EqualUnmodifiableListView) return _visibleIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleIds);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'IntelState(realtimeData: $realtimeData, pendingData: $pendingData, lastId: $lastId, lastCreateAt: $lastCreateAt, isLoading: $isLoading, isConnected: $isConnected, errorMessage: $errorMessage, allMessages: $allMessages, visibleIds: $visibleIds, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelStateImpl &&
            const DeepCollectionEquality()
                .equals(other._realtimeData, _realtimeData) &&
            const DeepCollectionEquality()
                .equals(other._pendingData, _pendingData) &&
            (identical(other.lastId, lastId) || other.lastId == lastId) &&
            (identical(other.lastCreateAt, lastCreateAt) ||
                other.lastCreateAt == lastCreateAt) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._allMessages, _allMessages) &&
            const DeepCollectionEquality()
                .equals(other._visibleIds, _visibleIds) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_realtimeData),
      const DeepCollectionEquality().hash(_pendingData),
      lastId,
      lastCreateAt,
      isLoading,
      isConnected,
      errorMessage,
      const DeepCollectionEquality().hash(_allMessages),
      const DeepCollectionEquality().hash(_visibleIds),
      page,
      pageSize);

  /// Create a copy of IntelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelStateImplCopyWith<_$IntelStateImpl> get copyWith =>
      __$$IntelStateImplCopyWithImpl<_$IntelStateImpl>(this, _$identity);
}

abstract class _IntelState implements IntelState {
  const factory _IntelState(
      {final List<dynamic> realtimeData,
      final List<dynamic> pendingData,
      final String lastId,
      final int lastCreateAt,
      final bool isLoading,
      final bool isConnected,
      final String errorMessage,
      final List<Intel>? allMessages,
      final List<String> visibleIds,
      final int page,
      final int pageSize}) = _$IntelStateImpl;

// @Default([]) List<IntelMessage> realtimeData,
// @Default([]) List<IntelMessage> pendingData,
  @override
  List<dynamic> get realtimeData;
  @override
  List<dynamic> get pendingData;
  @override
  String get lastId;
  @override
  int get lastCreateAt;
  @override
  bool get isLoading;
  @override
  bool get isConnected;
  @override
  String get errorMessage;
  @override
  List<Intel>? get allMessages;
  @override
  List<String> get visibleIds;
  @override
  int get page;
  @override
  int get pageSize;

  /// Create a copy of IntelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelStateImplCopyWith<_$IntelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
