// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntelMessageData _$IntelMessageDataFromJson(Map<String, dynamic> json) {
  return _IntelMessageData.fromJson(json);
}

/// @nodoc
mixin _$IntelMessageData {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  IntelGroup? get data => throw _privateConstructorUsedError;

  /// Serializes this IntelMessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelMessageDataCopyWith<IntelMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelMessageDataCopyWith<$Res> {
  factory $IntelMessageDataCopyWith(
          IntelMessageData value, $Res Function(IntelMessageData) then) =
      _$IntelMessageDataCopyWithImpl<$Res, IntelMessageData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'data') IntelGroup? data});

  $IntelGroupCopyWith<$Res>? get data;
}

/// @nodoc
class _$IntelMessageDataCopyWithImpl<$Res, $Val extends IntelMessageData>
    implements $IntelMessageDataCopyWith<$Res> {
  _$IntelMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as IntelGroup?,
    ) as $Val);
  }

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelGroupCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $IntelGroupCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntelMessageDataImplCopyWith<$Res>
    implements $IntelMessageDataCopyWith<$Res> {
  factory _$$IntelMessageDataImplCopyWith(_$IntelMessageDataImpl value,
          $Res Function(_$IntelMessageDataImpl) then) =
      __$$IntelMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'data') IntelGroup? data});

  @override
  $IntelGroupCopyWith<$Res>? get data;
}

/// @nodoc
class __$$IntelMessageDataImplCopyWithImpl<$Res>
    extends _$IntelMessageDataCopyWithImpl<$Res, _$IntelMessageDataImpl>
    implements _$$IntelMessageDataImplCopyWith<$Res> {
  __$$IntelMessageDataImplCopyWithImpl(_$IntelMessageDataImpl _value,
      $Res Function(_$IntelMessageDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? data = freezed,
  }) {
    return _then(_$IntelMessageDataImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as IntelGroup?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelMessageDataImpl implements _IntelMessageData {
  const _$IntelMessageDataImpl(
      {@JsonKey(name: 'type') this.type, @JsonKey(name: 'data') this.data});

  factory _$IntelMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelMessageDataImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'data')
  final IntelGroup? data;

  @override
  String toString() {
    return 'IntelMessageData(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelMessageDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, data);

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelMessageDataImplCopyWith<_$IntelMessageDataImpl> get copyWith =>
      __$$IntelMessageDataImplCopyWithImpl<_$IntelMessageDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelMessageDataImplToJson(
      this,
    );
  }
}

abstract class _IntelMessageData implements IntelMessageData {
  const factory _IntelMessageData(
      {@JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'data') final IntelGroup? data}) = _$IntelMessageDataImpl;

  factory _IntelMessageData.fromJson(Map<String, dynamic> json) =
      _$IntelMessageDataImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'data')
  IntelGroup? get data;

  /// Create a copy of IntelMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelMessageDataImplCopyWith<_$IntelMessageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelGroup _$IntelGroupFromJson(Map<String, dynamic> json) {
  return _IntelGroup.fromJson(json);
}

/// @nodoc
mixin _$IntelGroup {
  @JsonKey(name: 'group_id')
  String? get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_name')
  String? get groupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  IntelMessage? get message => throw _privateConstructorUsedError;

  /// Serializes this IntelGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelGroupCopyWith<IntelGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelGroupCopyWith<$Res> {
  factory $IntelGroupCopyWith(
          IntelGroup value, $Res Function(IntelGroup) then) =
      _$IntelGroupCopyWithImpl<$Res, IntelGroup>;
  @useResult
  $Res call(
      {@JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'group_name') String? groupName,
      @JsonKey(name: 'message') IntelMessage? message});

  $IntelMessageCopyWith<$Res>? get message;
}

/// @nodoc
class _$IntelGroupCopyWithImpl<$Res, $Val extends IntelGroup>
    implements $IntelGroupCopyWith<$Res> {
  _$IntelGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as IntelMessage?,
    ) as $Val);
  }

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelMessageCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $IntelMessageCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntelGroupImplCopyWith<$Res>
    implements $IntelGroupCopyWith<$Res> {
  factory _$$IntelGroupImplCopyWith(
          _$IntelGroupImpl value, $Res Function(_$IntelGroupImpl) then) =
      __$$IntelGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'group_name') String? groupName,
      @JsonKey(name: 'message') IntelMessage? message});

  @override
  $IntelMessageCopyWith<$Res>? get message;
}

/// @nodoc
class __$$IntelGroupImplCopyWithImpl<$Res>
    extends _$IntelGroupCopyWithImpl<$Res, _$IntelGroupImpl>
    implements _$$IntelGroupImplCopyWith<$Res> {
  __$$IntelGroupImplCopyWithImpl(
      _$IntelGroupImpl _value, $Res Function(_$IntelGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? message = freezed,
  }) {
    return _then(_$IntelGroupImpl(
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as IntelMessage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelGroupImpl implements _IntelGroup {
  const _$IntelGroupImpl(
      {@JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'group_name') this.groupName,
      @JsonKey(name: 'message') this.message});

  factory _$IntelGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelGroupImplFromJson(json);

  @override
  @JsonKey(name: 'group_id')
  final String? groupId;
  @override
  @JsonKey(name: 'group_name')
  final String? groupName;
  @override
  @JsonKey(name: 'message')
  final IntelMessage? message;

  @override
  String toString() {
    return 'IntelGroup(groupId: $groupId, groupName: $groupName, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, groupId, groupName, message);

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelGroupImplCopyWith<_$IntelGroupImpl> get copyWith =>
      __$$IntelGroupImplCopyWithImpl<_$IntelGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelGroupImplToJson(
      this,
    );
  }
}

abstract class _IntelGroup implements IntelGroup {
  const factory _IntelGroup(
          {@JsonKey(name: 'group_id') required final String? groupId,
          @JsonKey(name: 'group_name') final String? groupName,
          @JsonKey(name: 'message') final IntelMessage? message}) =
      _$IntelGroupImpl;

  factory _IntelGroup.fromJson(Map<String, dynamic> json) =
      _$IntelGroupImpl.fromJson;

  @override
  @JsonKey(name: 'group_id')
  String? get groupId;
  @override
  @JsonKey(name: 'group_name')
  String? get groupName;
  @override
  @JsonKey(name: 'message')
  IntelMessage? get message;

  /// Create a copy of IntelGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelGroupImplCopyWith<_$IntelGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryData _$HistoryDataFromJson(Map<String, dynamic> json) {
  return _HistoryData.fromJson(json);
}

/// @nodoc
mixin _$HistoryData {
  @JsonKey(name: 'records')
  List<IntelMessage>? get records => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_create_at')
  int? get lastCreateAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_id')
  String? get lastId => throw _privateConstructorUsedError;

  /// Serializes this HistoryData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryDataCopyWith<HistoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryDataCopyWith<$Res> {
  factory $HistoryDataCopyWith(
          HistoryData value, $Res Function(HistoryData) then) =
      _$HistoryDataCopyWithImpl<$Res, HistoryData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'records') List<IntelMessage>? records,
      @JsonKey(name: 'last_create_at') int? lastCreateAt,
      @JsonKey(name: 'last_id') String? lastId});
}

/// @nodoc
class _$HistoryDataCopyWithImpl<$Res, $Val extends HistoryData>
    implements $HistoryDataCopyWith<$Res> {
  _$HistoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = freezed,
    Object? lastCreateAt = freezed,
    Object? lastId = freezed,
  }) {
    return _then(_value.copyWith(
      records: freezed == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>?,
      lastCreateAt: freezed == lastCreateAt
          ? _value.lastCreateAt
          : lastCreateAt // ignore: cast_nullable_to_non_nullable
              as int?,
      lastId: freezed == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryDataImplCopyWith<$Res>
    implements $HistoryDataCopyWith<$Res> {
  factory _$$HistoryDataImplCopyWith(
          _$HistoryDataImpl value, $Res Function(_$HistoryDataImpl) then) =
      __$$HistoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'records') List<IntelMessage>? records,
      @JsonKey(name: 'last_create_at') int? lastCreateAt,
      @JsonKey(name: 'last_id') String? lastId});
}

/// @nodoc
class __$$HistoryDataImplCopyWithImpl<$Res>
    extends _$HistoryDataCopyWithImpl<$Res, _$HistoryDataImpl>
    implements _$$HistoryDataImplCopyWith<$Res> {
  __$$HistoryDataImplCopyWithImpl(
      _$HistoryDataImpl _value, $Res Function(_$HistoryDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = freezed,
    Object? lastCreateAt = freezed,
    Object? lastId = freezed,
  }) {
    return _then(_$HistoryDataImpl(
      records: freezed == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<IntelMessage>?,
      lastCreateAt: freezed == lastCreateAt
          ? _value.lastCreateAt
          : lastCreateAt // ignore: cast_nullable_to_non_nullable
              as int?,
      lastId: freezed == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryDataImpl implements _HistoryData {
  const _$HistoryDataImpl(
      {@JsonKey(name: 'records') final List<IntelMessage>? records,
      @JsonKey(name: 'last_create_at') this.lastCreateAt,
      @JsonKey(name: 'last_id') this.lastId})
      : _records = records;

  factory _$HistoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryDataImplFromJson(json);

  final List<IntelMessage>? _records;
  @override
  @JsonKey(name: 'records')
  List<IntelMessage>? get records {
    final value = _records;
    if (value == null) return null;
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'last_create_at')
  final int? lastCreateAt;
  @override
  @JsonKey(name: 'last_id')
  final String? lastId;

  @override
  String toString() {
    return 'HistoryData(records: $records, lastCreateAt: $lastCreateAt, lastId: $lastId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryDataImpl &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.lastCreateAt, lastCreateAt) ||
                other.lastCreateAt == lastCreateAt) &&
            (identical(other.lastId, lastId) || other.lastId == lastId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_records), lastCreateAt, lastId);

  /// Create a copy of HistoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryDataImplCopyWith<_$HistoryDataImpl> get copyWith =>
      __$$HistoryDataImplCopyWithImpl<_$HistoryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryDataImplToJson(
      this,
    );
  }
}

abstract class _HistoryData implements HistoryData {
  const factory _HistoryData(
      {@JsonKey(name: 'records') final List<IntelMessage>? records,
      @JsonKey(name: 'last_create_at') final int? lastCreateAt,
      @JsonKey(name: 'last_id') final String? lastId}) = _$HistoryDataImpl;

  factory _HistoryData.fromJson(Map<String, dynamic> json) =
      _$HistoryDataImpl.fromJson;

  @override
  @JsonKey(name: 'records')
  List<IntelMessage>? get records;
  @override
  @JsonKey(name: 'last_create_at')
  int? get lastCreateAt;
  @override
  @JsonKey(name: 'last_id')
  String? get lastId;

  /// Create a copy of HistoryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryDataImplCopyWith<_$HistoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelMessage _$IntelMessageFromJson(Map<String, dynamic> json) {
  return _IntelMessage.fromJson(json);
}

/// @nodoc
mixin _$IntelMessage {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError; // 推文作者
  @JsonKey(name: 'timestamp')
  int? get timestamp => throw _privateConstructorUsedError; // 推文发送时间
  @JsonKey(name: "create_at")
  int? get createdAt => throw _privateConstructorUsedError; // 消息推送时间
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError; // 推文内容
  @JsonKey(name: 'origin')
  String? get origin => throw _privateConstructorUsedError; // 推文源链接
  @JsonKey(name: 'analyze')
  String? get analyze => throw _privateConstructorUsedError;
  @JsonKey(name: 'entities')
  List<IntelEntity>? get entities => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  IntelUser? get user => throw _privateConstructorUsedError; // 推文作者信息
  @JsonKey(name: "medias")
  List<IntelMedia>? get medias => throw _privateConstructorUsedError;

  /// Serializes this IntelMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelMessageCopyWith<IntelMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelMessageCopyWith<$Res> {
  factory $IntelMessageCopyWith(
          IntelMessage value, $Res Function(IntelMessage) then) =
      _$IntelMessageCopyWithImpl<$Res, IntelMessage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'timestamp') int? timestamp,
      @JsonKey(name: "create_at") int? createdAt,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'origin') String? origin,
      @JsonKey(name: 'analyze') String? analyze,
      @JsonKey(name: 'entities') List<IntelEntity>? entities,
      @JsonKey(name: 'user') IntelUser? user,
      @JsonKey(name: "medias") List<IntelMedia>? medias});

  $IntelUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$IntelMessageCopyWithImpl<$Res, $Val extends IntelMessage>
    implements $IntelMessageCopyWith<$Res> {
  _$IntelMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? timestamp = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? origin = freezed,
    Object? analyze = freezed,
    Object? entities = freezed,
    Object? user = freezed,
    Object? medias = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      analyze: freezed == analyze
          ? _value.analyze
          : analyze // ignore: cast_nullable_to_non_nullable
              as String?,
      entities: freezed == entities
          ? _value.entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<IntelEntity>?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as IntelUser?,
      medias: freezed == medias
          ? _value.medias
          : medias // ignore: cast_nullable_to_non_nullable
              as List<IntelMedia>?,
    ) as $Val);
  }

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $IntelUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntelMessageImplCopyWith<$Res>
    implements $IntelMessageCopyWith<$Res> {
  factory _$$IntelMessageImplCopyWith(
          _$IntelMessageImpl value, $Res Function(_$IntelMessageImpl) then) =
      __$$IntelMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'timestamp') int? timestamp,
      @JsonKey(name: "create_at") int? createdAt,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'origin') String? origin,
      @JsonKey(name: 'analyze') String? analyze,
      @JsonKey(name: 'entities') List<IntelEntity>? entities,
      @JsonKey(name: 'user') IntelUser? user,
      @JsonKey(name: "medias") List<IntelMedia>? medias});

  @override
  $IntelUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$IntelMessageImplCopyWithImpl<$Res>
    extends _$IntelMessageCopyWithImpl<$Res, _$IntelMessageImpl>
    implements _$$IntelMessageImplCopyWith<$Res> {
  __$$IntelMessageImplCopyWithImpl(
      _$IntelMessageImpl _value, $Res Function(_$IntelMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? timestamp = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? origin = freezed,
    Object? analyze = freezed,
    Object? entities = freezed,
    Object? user = freezed,
    Object? medias = freezed,
  }) {
    return _then(_$IntelMessageImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      analyze: freezed == analyze
          ? _value.analyze
          : analyze // ignore: cast_nullable_to_non_nullable
              as String?,
      entities: freezed == entities
          ? _value._entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<IntelEntity>?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as IntelUser?,
      medias: freezed == medias
          ? _value._medias
          : medias // ignore: cast_nullable_to_non_nullable
              as List<IntelMedia>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelMessageImpl implements _IntelMessage {
  const _$IntelMessageImpl(
      {@JsonKey(name: 'type') this.type,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'timestamp') this.timestamp,
      @JsonKey(name: "create_at") this.createdAt,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'origin') this.origin,
      @JsonKey(name: 'analyze') this.analyze,
      @JsonKey(name: 'entities') final List<IntelEntity>? entities,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: "medias") final List<IntelMedia>? medias})
      : _entities = entities,
        _medias = medias;

  factory _$IntelMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelMessageImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'name')
  final String? name;
// 推文作者
  @override
  @JsonKey(name: 'timestamp')
  final int? timestamp;
// 推文发送时间
  @override
  @JsonKey(name: "create_at")
  final int? createdAt;
// 消息推送时间
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'content')
  final String? content;
// 推文内容
  @override
  @JsonKey(name: 'origin')
  final String? origin;
// 推文源链接
  @override
  @JsonKey(name: 'analyze')
  final String? analyze;
  final List<IntelEntity>? _entities;
  @override
  @JsonKey(name: 'entities')
  List<IntelEntity>? get entities {
    final value = _entities;
    if (value == null) return null;
    if (_entities is EqualUnmodifiableListView) return _entities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'user')
  final IntelUser? user;
// 推文作者信息
  final List<IntelMedia>? _medias;
// 推文作者信息
  @override
  @JsonKey(name: "medias")
  List<IntelMedia>? get medias {
    final value = _medias;
    if (value == null) return null;
    if (_medias is EqualUnmodifiableListView) return _medias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'IntelMessage(type: $type, name: $name, timestamp: $timestamp, createdAt: $createdAt, title: $title, content: $content, origin: $origin, analyze: $analyze, entities: $entities, user: $user, medias: $medias)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelMessageImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.analyze, analyze) || other.analyze == analyze) &&
            const DeepCollectionEquality().equals(other._entities, _entities) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._medias, _medias));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      name,
      timestamp,
      createdAt,
      title,
      content,
      origin,
      analyze,
      const DeepCollectionEquality().hash(_entities),
      user,
      const DeepCollectionEquality().hash(_medias));

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelMessageImplCopyWith<_$IntelMessageImpl> get copyWith =>
      __$$IntelMessageImplCopyWithImpl<_$IntelMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelMessageImplToJson(
      this,
    );
  }
}

abstract class _IntelMessage implements IntelMessage {
  const factory _IntelMessage(
          {@JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'timestamp') final int? timestamp,
          @JsonKey(name: "create_at") final int? createdAt,
          @JsonKey(name: 'title') final String? title,
          @JsonKey(name: 'content') final String? content,
          @JsonKey(name: 'origin') final String? origin,
          @JsonKey(name: 'analyze') final String? analyze,
          @JsonKey(name: 'entities') final List<IntelEntity>? entities,
          @JsonKey(name: 'user') final IntelUser? user,
          @JsonKey(name: "medias") final List<IntelMedia>? medias}) =
      _$IntelMessageImpl;

  factory _IntelMessage.fromJson(Map<String, dynamic> json) =
      _$IntelMessageImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'name')
  String? get name; // 推文作者
  @override
  @JsonKey(name: 'timestamp')
  int? get timestamp; // 推文发送时间
  @override
  @JsonKey(name: "create_at")
  int? get createdAt; // 消息推送时间
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'content')
  String? get content; // 推文内容
  @override
  @JsonKey(name: 'origin')
  String? get origin; // 推文源链接
  @override
  @JsonKey(name: 'analyze')
  String? get analyze;
  @override
  @JsonKey(name: 'entities')
  List<IntelEntity>? get entities;
  @override
  @JsonKey(name: 'user')
  IntelUser? get user; // 推文作者信息
  @override
  @JsonKey(name: "medias")
  List<IntelMedia>? get medias;

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelMessageImplCopyWith<_$IntelMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelMedia _$IntelMediaFromJson(Map<String, dynamic> json) {
  return _IntelMedia.fromJson(json);
}

/// @nodoc
mixin _$IntelMedia {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this IntelMedia to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelMediaCopyWith<IntelMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelMediaCopyWith<$Res> {
  factory $IntelMediaCopyWith(
          IntelMedia value, $Res Function(IntelMedia) then) =
      _$IntelMediaCopyWithImpl<$Res, IntelMedia>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'data') String? data});
}

/// @nodoc
class _$IntelMediaCopyWithImpl<$Res, $Val extends IntelMedia>
    implements $IntelMediaCopyWith<$Res> {
  _$IntelMediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? url = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelMediaImplCopyWith<$Res>
    implements $IntelMediaCopyWith<$Res> {
  factory _$$IntelMediaImplCopyWith(
          _$IntelMediaImpl value, $Res Function(_$IntelMediaImpl) then) =
      __$$IntelMediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'data') String? data});
}

/// @nodoc
class __$$IntelMediaImplCopyWithImpl<$Res>
    extends _$IntelMediaCopyWithImpl<$Res, _$IntelMediaImpl>
    implements _$$IntelMediaImplCopyWith<$Res> {
  __$$IntelMediaImplCopyWithImpl(
      _$IntelMediaImpl _value, $Res Function(_$IntelMediaImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? url = freezed,
    Object? data = freezed,
  }) {
    return _then(_$IntelMediaImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelMediaImpl implements _IntelMedia {
  const _$IntelMediaImpl(
      {@JsonKey(name: 'type') this.type,
      @JsonKey(name: 'url') this.url,
      @JsonKey(name: 'data') this.data});

  factory _$IntelMediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelMediaImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'data')
  final String? data;

  @override
  String toString() {
    return 'IntelMedia(type: $type, url: $url, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelMediaImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, url, data);

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelMediaImplCopyWith<_$IntelMediaImpl> get copyWith =>
      __$$IntelMediaImplCopyWithImpl<_$IntelMediaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelMediaImplToJson(
      this,
    );
  }
}

abstract class _IntelMedia implements IntelMedia {
  const factory _IntelMedia(
      {@JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'url') final String? url,
      @JsonKey(name: 'data') final String? data}) = _$IntelMediaImpl;

  factory _IntelMedia.fromJson(Map<String, dynamic> json) =
      _$IntelMediaImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'data')
  String? get data;

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelMediaImplCopyWith<_$IntelMediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelEntity _$IntelEntityFromJson(Map<String, dynamic> json) {
  return _IntelEntity.fromJson(json);
}

/// @nodoc
mixin _$IntelEntity {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'symbol')
  String? get symbol => throw _privateConstructorUsedError;
  @JsonKey(name: 'network')
  String? get network => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this IntelEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelEntityCopyWith<IntelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelEntityCopyWith<$Res> {
  factory $IntelEntityCopyWith(
          IntelEntity value, $Res Function(IntelEntity) then) =
      _$IntelEntityCopyWithImpl<$Res, IntelEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'symbol') String? symbol,
      @JsonKey(name: 'network') String? network,
      @JsonKey(name: 'address') String? address});
}

/// @nodoc
class _$IntelEntityCopyWithImpl<$Res, $Val extends IntelEntity>
    implements $IntelEntityCopyWith<$Res> {
  _$IntelEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? network = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelEntityImplCopyWith<$Res>
    implements $IntelEntityCopyWith<$Res> {
  factory _$$IntelEntityImplCopyWith(
          _$IntelEntityImpl value, $Res Function(_$IntelEntityImpl) then) =
      __$$IntelEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'symbol') String? symbol,
      @JsonKey(name: 'network') String? network,
      @JsonKey(name: 'address') String? address});
}

/// @nodoc
class __$$IntelEntityImplCopyWithImpl<$Res>
    extends _$IntelEntityCopyWithImpl<$Res, _$IntelEntityImpl>
    implements _$$IntelEntityImplCopyWith<$Res> {
  __$$IntelEntityImplCopyWithImpl(
      _$IntelEntityImpl _value, $Res Function(_$IntelEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? network = freezed,
    Object? address = freezed,
  }) {
    return _then(_$IntelEntityImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelEntityImpl implements _IntelEntity {
  const _$IntelEntityImpl(
      {@JsonKey(name: 'type') this.type,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'symbol') this.symbol,
      @JsonKey(name: 'network') this.network,
      @JsonKey(name: 'address') this.address});

  factory _$IntelEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelEntityImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'symbol')
  final String? symbol;
  @override
  @JsonKey(name: 'network')
  final String? network;
  @override
  @JsonKey(name: 'address')
  final String? address;

  @override
  String toString() {
    return 'IntelEntity(type: $type, name: $name, symbol: $symbol, network: $network, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelEntityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, name, symbol, network, address);

  /// Create a copy of IntelEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelEntityImplCopyWith<_$IntelEntityImpl> get copyWith =>
      __$$IntelEntityImplCopyWithImpl<_$IntelEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelEntityImplToJson(
      this,
    );
  }
}

abstract class _IntelEntity implements IntelEntity {
  const factory _IntelEntity(
      {@JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'symbol') final String? symbol,
      @JsonKey(name: 'network') final String? network,
      @JsonKey(name: 'address') final String? address}) = _$IntelEntityImpl;

  factory _IntelEntity.fromJson(Map<String, dynamic> json) =
      _$IntelEntityImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'symbol')
  String? get symbol;
  @override
  @JsonKey(name: 'network')
  String? get network;
  @override
  @JsonKey(name: 'address')
  String? get address;

  /// Create a copy of IntelEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelEntityImplCopyWith<_$IntelEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelUser _$IntelUserFromJson(Map<String, dynamic> json) {
  return _IntelUser.fromJson(json);
}

/// @nodoc
mixin _$IntelUser {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avator')
  String? get avator => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'screen_name')
  String? get screenName => throw _privateConstructorUsedError;

  /// Serializes this IntelUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelUserCopyWith<IntelUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelUserCopyWith<$Res> {
  factory $IntelUserCopyWith(IntelUser value, $Res Function(IntelUser) then) =
      _$IntelUserCopyWithImpl<$Res, IntelUser>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'avator') String? avator,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'screen_name') String? screenName});
}

/// @nodoc
class _$IntelUserCopyWithImpl<$Res, $Val extends IntelUser>
    implements $IntelUserCopyWith<$Res> {
  _$IntelUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avator = freezed,
    Object? userId = freezed,
    Object? screenName = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avator: freezed == avator
          ? _value.avator
          : avator // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      screenName: freezed == screenName
          ? _value.screenName
          : screenName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelUserImplCopyWith<$Res>
    implements $IntelUserCopyWith<$Res> {
  factory _$$IntelUserImplCopyWith(
          _$IntelUserImpl value, $Res Function(_$IntelUserImpl) then) =
      __$$IntelUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'avator') String? avator,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'screen_name') String? screenName});
}

/// @nodoc
class __$$IntelUserImplCopyWithImpl<$Res>
    extends _$IntelUserCopyWithImpl<$Res, _$IntelUserImpl>
    implements _$$IntelUserImplCopyWith<$Res> {
  __$$IntelUserImplCopyWithImpl(
      _$IntelUserImpl _value, $Res Function(_$IntelUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avator = freezed,
    Object? userId = freezed,
    Object? screenName = freezed,
  }) {
    return _then(_$IntelUserImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avator: freezed == avator
          ? _value.avator
          : avator // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      screenName: freezed == screenName
          ? _value.screenName
          : screenName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelUserImpl implements _IntelUser {
  const _$IntelUserImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'avator') this.avator,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'screen_name') this.screenName});

  factory _$IntelUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelUserImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avator')
  final String? avator;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'screen_name')
  final String? screenName;

  @override
  String toString() {
    return 'IntelUser(name: $name, avator: $avator, userId: $userId, screenName: $screenName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avator, avator) || other.avator == avator) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.screenName, screenName) ||
                other.screenName == screenName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, avator, userId, screenName);

  /// Create a copy of IntelUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelUserImplCopyWith<_$IntelUserImpl> get copyWith =>
      __$$IntelUserImplCopyWithImpl<_$IntelUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelUserImplToJson(
      this,
    );
  }
}

abstract class _IntelUser implements IntelUser {
  const factory _IntelUser(
          {@JsonKey(name: 'name') required final String? name,
          @JsonKey(name: 'avator') final String? avator,
          @JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'screen_name') final String? screenName}) =
      _$IntelUserImpl;

  factory _IntelUser.fromJson(Map<String, dynamic> json) =
      _$IntelUserImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avator')
  String? get avator;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'screen_name')
  String? get screenName;

  /// Create a copy of IntelUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelUserImplCopyWith<_$IntelUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
