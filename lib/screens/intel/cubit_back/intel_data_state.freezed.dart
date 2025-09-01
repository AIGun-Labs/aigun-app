// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intel_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IntelDataState {
  List<IntelMessage> get realtimeData => throw _privateConstructorUsedError;
  List<IntelMessage> get pendingData => throw _privateConstructorUsedError;
  String get lastId => throw _privateConstructorUsedError;
  int get lastCreateAt => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of IntelDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelDataStateCopyWith<IntelDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelDataStateCopyWith<$Res> {
  factory $IntelDataStateCopyWith(
          IntelDataState value, $Res Function(IntelDataState) then) =
      _$IntelDataStateCopyWithImpl<$Res, IntelDataState>;
  @useResult
  $Res call(
      {List<IntelMessage> realtimeData,
      List<IntelMessage> pendingData,
      String lastId,
      int lastCreateAt,
      bool isLoading,
      bool isConnected,
      String errorMessage});
}

/// @nodoc
class _$IntelDataStateCopyWithImpl<$Res, $Val extends IntelDataState>
    implements $IntelDataStateCopyWith<$Res> {
  _$IntelDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelDataState
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
  }) {
    return _then(_value.copyWith(
      realtimeData: null == realtimeData
          ? _value.realtimeData
          : realtimeData // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>,
      pendingData: null == pendingData
          ? _value.pendingData
          : pendingData // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelDataStateImplCopyWith<$Res>
    implements $IntelDataStateCopyWith<$Res> {
  factory _$$IntelDataStateImplCopyWith(_$IntelDataStateImpl value,
          $Res Function(_$IntelDataStateImpl) then) =
      __$$IntelDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<IntelMessage> realtimeData,
      List<IntelMessage> pendingData,
      String lastId,
      int lastCreateAt,
      bool isLoading,
      bool isConnected,
      String errorMessage});
}

/// @nodoc
class __$$IntelDataStateImplCopyWithImpl<$Res>
    extends _$IntelDataStateCopyWithImpl<$Res, _$IntelDataStateImpl>
    implements _$$IntelDataStateImplCopyWith<$Res> {
  __$$IntelDataStateImplCopyWithImpl(
      _$IntelDataStateImpl _value, $Res Function(_$IntelDataStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelDataState
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
  }) {
    return _then(_$IntelDataStateImpl(
      realtimeData: null == realtimeData
          ? _value._realtimeData
          : realtimeData // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>,
      pendingData: null == pendingData
          ? _value._pendingData
          : pendingData // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>,
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
    ));
  }
}

/// @nodoc

class _$IntelDataStateImpl implements _IntelDataState {
  const _$IntelDataStateImpl(
      {final List<IntelMessage> realtimeData = const [],
      final List<IntelMessage> pendingData = const [],
      this.lastId = '',
      this.lastCreateAt = 0,
      this.isLoading = false,
      this.isConnected = false,
      this.errorMessage = ''})
      : _realtimeData = realtimeData,
        _pendingData = pendingData;

  final List<IntelMessage> _realtimeData;
  @override
  @JsonKey()
  List<IntelMessage> get realtimeData {
    if (_realtimeData is EqualUnmodifiableListView) return _realtimeData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_realtimeData);
  }

  final List<IntelMessage> _pendingData;
  @override
  @JsonKey()
  List<IntelMessage> get pendingData {
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

  @override
  String toString() {
    return 'IntelDataState(realtimeData: $realtimeData, pendingData: $pendingData, lastId: $lastId, lastCreateAt: $lastCreateAt, isLoading: $isLoading, isConnected: $isConnected, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelDataStateImpl &&
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
                other.errorMessage == errorMessage));
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
      errorMessage);

  /// Create a copy of IntelDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelDataStateImplCopyWith<_$IntelDataStateImpl> get copyWith =>
      __$$IntelDataStateImplCopyWithImpl<_$IntelDataStateImpl>(
          this, _$identity);
}

abstract class _IntelDataState implements IntelDataState {
  const factory _IntelDataState(
      {final List<IntelMessage> realtimeData,
      final List<IntelMessage> pendingData,
      final String lastId,
      final int lastCreateAt,
      final bool isLoading,
      final bool isConnected,
      final String errorMessage}) = _$IntelDataStateImpl;

  @override
  List<IntelMessage> get realtimeData;
  @override
  List<IntelMessage> get pendingData;
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

  /// Create a copy of IntelDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelDataStateImplCopyWith<_$IntelDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
