// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monitor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Monitor _$MonitorFromJson(Map<String, dynamic> json) {
  return _Monitor.fromJson(json);
}

/// @nodoc
mixin _$Monitor {
  @JsonKey(name: 'subscriptions')
  List<MonitorListType>? get monitorList => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_count')
  int? get totalCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitorCopyWith<Monitor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitorCopyWith<$Res> {
  factory $MonitorCopyWith(Monitor value, $Res Function(Monitor) then) =
      _$MonitorCopyWithImpl<$Res, Monitor>;
  @useResult
  $Res call(
      {@JsonKey(name: 'subscriptions') List<MonitorListType>? monitorList,
      @JsonKey(name: 'total_count') int? totalCount});
}

/// @nodoc
class _$MonitorCopyWithImpl<$Res, $Val extends Monitor>
    implements $MonitorCopyWith<$Res> {
  _$MonitorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monitorList = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_value.copyWith(
      monitorList: freezed == monitorList
          ? _value.monitorList
          : monitorList // ignore: cast_nullable_to_non_nullable
              as List<MonitorListType>?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonitorImplCopyWith<$Res> implements $MonitorCopyWith<$Res> {
  factory _$$MonitorImplCopyWith(
          _$MonitorImpl value, $Res Function(_$MonitorImpl) then) =
      __$$MonitorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'subscriptions') List<MonitorListType>? monitorList,
      @JsonKey(name: 'total_count') int? totalCount});
}

/// @nodoc
class __$$MonitorImplCopyWithImpl<$Res>
    extends _$MonitorCopyWithImpl<$Res, _$MonitorImpl>
    implements _$$MonitorImplCopyWith<$Res> {
  __$$MonitorImplCopyWithImpl(
      _$MonitorImpl _value, $Res Function(_$MonitorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monitorList = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_$MonitorImpl(
      monitorList: freezed == monitorList
          ? _value._monitorList
          : monitorList // ignore: cast_nullable_to_non_nullable
              as List<MonitorListType>?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitorImpl implements _Monitor {
  const _$MonitorImpl(
      {@JsonKey(name: 'subscriptions') final List<MonitorListType>? monitorList,
      @JsonKey(name: 'total_count') this.totalCount})
      : _monitorList = monitorList;

  factory _$MonitorImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitorImplFromJson(json);

  final List<MonitorListType>? _monitorList;
  @override
  @JsonKey(name: 'subscriptions')
  List<MonitorListType>? get monitorList {
    final value = _monitorList;
    if (value == null) return null;
    if (_monitorList is EqualUnmodifiableListView) return _monitorList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'total_count')
  final int? totalCount;

  @override
  String toString() {
    return 'Monitor(monitorList: $monitorList, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorImpl &&
            const DeepCollectionEquality()
                .equals(other._monitorList, _monitorList) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_monitorList), totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorImplCopyWith<_$MonitorImpl> get copyWith =>
      __$$MonitorImplCopyWithImpl<_$MonitorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitorImplToJson(
      this,
    );
  }
}

abstract class _Monitor implements Monitor {
  const factory _Monitor(
      {@JsonKey(name: 'subscriptions') final List<MonitorListType>? monitorList,
      @JsonKey(name: 'total_count') final int? totalCount}) = _$MonitorImpl;

  factory _Monitor.fromJson(Map<String, dynamic> json) = _$MonitorImpl.fromJson;

  @override
  @JsonKey(name: 'subscriptions')
  List<MonitorListType>? get monitorList;
  @override
  @JsonKey(name: 'total_count')
  int? get totalCount;
  @override
  @JsonKey(ignore: true)
  _$$MonitorImplCopyWith<_$MonitorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonitorListType _$MonitorListTypeFromJson(Map<String, dynamic> json) {
  return _MonitorListType.fromJson(json);
}

/// @nodoc
mixin _$MonitorListType {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<MonitorTag>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'not_tags')
  List<MonitorTag>? get notTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscriptions_description')
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitorListTypeCopyWith<MonitorListType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitorListTypeCopyWith<$Res> {
  factory $MonitorListTypeCopyWith(
          MonitorListType value, $Res Function(MonitorListType) then) =
      _$MonitorListTypeCopyWithImpl<$Res, MonitorListType>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'tags') List<MonitorTag>? tags,
      @JsonKey(name: 'not_tags') List<MonitorTag>? notTags,
      @JsonKey(name: 'subscriptions_description') String? description});
}

/// @nodoc
class _$MonitorListTypeCopyWithImpl<$Res, $Val extends MonitorListType>
    implements $MonitorListTypeCopyWith<$Res> {
  _$MonitorListTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tags = freezed,
    Object? notTags = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<MonitorTag>?,
      notTags: freezed == notTags
          ? _value.notTags
          : notTags // ignore: cast_nullable_to_non_nullable
              as List<MonitorTag>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonitorListTypeImplCopyWith<$Res>
    implements $MonitorListTypeCopyWith<$Res> {
  factory _$$MonitorListTypeImplCopyWith(_$MonitorListTypeImpl value,
          $Res Function(_$MonitorListTypeImpl) then) =
      __$$MonitorListTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'tags') List<MonitorTag>? tags,
      @JsonKey(name: 'not_tags') List<MonitorTag>? notTags,
      @JsonKey(name: 'subscriptions_description') String? description});
}

/// @nodoc
class __$$MonitorListTypeImplCopyWithImpl<$Res>
    extends _$MonitorListTypeCopyWithImpl<$Res, _$MonitorListTypeImpl>
    implements _$$MonitorListTypeImplCopyWith<$Res> {
  __$$MonitorListTypeImplCopyWithImpl(
      _$MonitorListTypeImpl _value, $Res Function(_$MonitorListTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tags = freezed,
    Object? notTags = freezed,
    Object? description = freezed,
  }) {
    return _then(_$MonitorListTypeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<MonitorTag>?,
      notTags: freezed == notTags
          ? _value._notTags
          : notTags // ignore: cast_nullable_to_non_nullable
              as List<MonitorTag>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitorListTypeImpl implements _MonitorListType {
  const _$MonitorListTypeImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'tags') final List<MonitorTag>? tags,
      @JsonKey(name: 'not_tags') final List<MonitorTag>? notTags,
      @JsonKey(name: 'subscriptions_description') this.description})
      : _tags = tags,
        _notTags = notTags;

  factory _$MonitorListTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitorListTypeImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  final List<MonitorTag>? _tags;
  @override
  @JsonKey(name: 'tags')
  List<MonitorTag>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MonitorTag>? _notTags;
  @override
  @JsonKey(name: 'not_tags')
  List<MonitorTag>? get notTags {
    final value = _notTags;
    if (value == null) return null;
    if (_notTags is EqualUnmodifiableListView) return _notTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'subscriptions_description')
  final String? description;

  @override
  String toString() {
    return 'MonitorListType(id: $id, tags: $tags, notTags: $notTags, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorListTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._notTags, _notTags) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_notTags),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorListTypeImplCopyWith<_$MonitorListTypeImpl> get copyWith =>
      __$$MonitorListTypeImplCopyWithImpl<_$MonitorListTypeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitorListTypeImplToJson(
      this,
    );
  }
}

abstract class _MonitorListType implements MonitorListType {
  const factory _MonitorListType(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'tags') final List<MonitorTag>? tags,
      @JsonKey(name: 'not_tags') final List<MonitorTag>? notTags,
      @JsonKey(name: 'subscriptions_description')
      final String? description}) = _$MonitorListTypeImpl;

  factory _MonitorListType.fromJson(Map<String, dynamic> json) =
      _$MonitorListTypeImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'tags')
  List<MonitorTag>? get tags;
  @override
  @JsonKey(name: 'not_tags')
  List<MonitorTag>? get notTags;
  @override
  @JsonKey(name: 'subscriptions_description')
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MonitorListTypeImplCopyWith<_$MonitorListTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonitorTag _$MonitorTagFromJson(Map<String, dynamic> json) {
  return _MonitorTag.fromJson(json);
}

/// @nodoc
mixin _$MonitorTag {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'meta')
  MonitorTagMeta? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitorTagCopyWith<MonitorTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitorTagCopyWith<$Res> {
  factory $MonitorTagCopyWith(
          MonitorTag value, $Res Function(MonitorTag) then) =
      _$MonitorTagCopyWithImpl<$Res, MonitorTag>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'meta') MonitorTagMeta? meta});

  $MonitorTagMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$MonitorTagCopyWithImpl<$Res, $Val extends MonitorTag>
    implements $MonitorTagCopyWith<$Res> {
  _$MonitorTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MonitorTagMeta?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MonitorTagMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $MonitorTagMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MonitorTagImplCopyWith<$Res>
    implements $MonitorTagCopyWith<$Res> {
  factory _$$MonitorTagImplCopyWith(
          _$MonitorTagImpl value, $Res Function(_$MonitorTagImpl) then) =
      __$$MonitorTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'meta') MonitorTagMeta? meta});

  @override
  $MonitorTagMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$MonitorTagImplCopyWithImpl<$Res>
    extends _$MonitorTagCopyWithImpl<$Res, _$MonitorTagImpl>
    implements _$$MonitorTagImplCopyWith<$Res> {
  __$$MonitorTagImplCopyWithImpl(
      _$MonitorTagImpl _value, $Res Function(_$MonitorTagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$MonitorTagImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MonitorTagMeta?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitorTagImpl implements _MonitorTag {
  const _$MonitorTagImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'meta') this.meta});

  factory _$MonitorTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitorTagImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'meta')
  final MonitorTagMeta? meta;

  @override
  String toString() {
    return 'MonitorTag(id: $id, type: $type, name: $name, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, name, meta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorTagImplCopyWith<_$MonitorTagImpl> get copyWith =>
      __$$MonitorTagImplCopyWithImpl<_$MonitorTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitorTagImplToJson(
      this,
    );
  }
}

abstract class _MonitorTag implements MonitorTag {
  const factory _MonitorTag(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'meta') final MonitorTagMeta? meta}) = _$MonitorTagImpl;

  factory _MonitorTag.fromJson(Map<String, dynamic> json) =
      _$MonitorTagImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'meta')
  MonitorTagMeta? get meta;
  @override
  @JsonKey(ignore: true)
  _$$MonitorTagImplCopyWith<_$MonitorTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonitorTagMeta _$MonitorTagMetaFromJson(Map<String, dynamic> json) {
  return _MonitorTagMeta.fromJson(json);
}

/// @nodoc
mixin _$MonitorTagMeta {
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitorTagMetaCopyWith<MonitorTagMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitorTagMetaCopyWith<$Res> {
  factory $MonitorTagMetaCopyWith(
          MonitorTagMeta value, $Res Function(MonitorTagMeta) then) =
      _$MonitorTagMetaCopyWithImpl<$Res, MonitorTagMeta>;
  @useResult
  $Res call({@JsonKey(name: 'description') String? description});
}

/// @nodoc
class _$MonitorTagMetaCopyWithImpl<$Res, $Val extends MonitorTagMeta>
    implements $MonitorTagMetaCopyWith<$Res> {
  _$MonitorTagMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonitorTagMetaImplCopyWith<$Res>
    implements $MonitorTagMetaCopyWith<$Res> {
  factory _$$MonitorTagMetaImplCopyWith(_$MonitorTagMetaImpl value,
          $Res Function(_$MonitorTagMetaImpl) then) =
      __$$MonitorTagMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'description') String? description});
}

/// @nodoc
class __$$MonitorTagMetaImplCopyWithImpl<$Res>
    extends _$MonitorTagMetaCopyWithImpl<$Res, _$MonitorTagMetaImpl>
    implements _$$MonitorTagMetaImplCopyWith<$Res> {
  __$$MonitorTagMetaImplCopyWithImpl(
      _$MonitorTagMetaImpl _value, $Res Function(_$MonitorTagMetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_$MonitorTagMetaImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitorTagMetaImpl implements _MonitorTagMeta {
  const _$MonitorTagMetaImpl({@JsonKey(name: 'description') this.description});

  factory _$MonitorTagMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitorTagMetaImplFromJson(json);

  @override
  @JsonKey(name: 'description')
  final String? description;

  @override
  String toString() {
    return 'MonitorTagMeta(description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorTagMetaImpl &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorTagMetaImplCopyWith<_$MonitorTagMetaImpl> get copyWith =>
      __$$MonitorTagMetaImplCopyWithImpl<_$MonitorTagMetaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitorTagMetaImplToJson(
      this,
    );
  }
}

abstract class _MonitorTagMeta implements MonitorTagMeta {
  const factory _MonitorTagMeta(
          {@JsonKey(name: 'description') final String? description}) =
      _$MonitorTagMetaImpl;

  factory _MonitorTagMeta.fromJson(Map<String, dynamic> json) =
      _$MonitorTagMetaImpl.fromJson;

  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MonitorTagMetaImplCopyWith<_$MonitorTagMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
