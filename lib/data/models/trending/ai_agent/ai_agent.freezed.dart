// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_agent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiAgent _$AiAgentFromJson(Map<String, dynamic> json) {
  return _AiAgent.fromJson(json);
}

/// @nodoc
mixin _$AiAgent {
  String get id => throw _privateConstructorUsedError;
  Language get name => throw _privateConstructorUsedError;
  Language get description => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_followed')
  bool get isFollowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'subset_id')
  String get subsetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_id')
  String get tagId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AiAgentCopyWith<AiAgent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiAgentCopyWith<$Res> {
  factory $AiAgentCopyWith(AiAgent value, $Res Function(AiAgent) then) =
      _$AiAgentCopyWithImpl<$Res, AiAgent>;
  @useResult
  $Res call(
      {String id,
      Language name,
      Language description,
      String avatar,
      int rank,
      @JsonKey(name: 'is_followed') bool isFollowed,
      @JsonKey(name: 'subset_id') String subsetId,
      @JsonKey(name: 'tag_id') String tagId});

  $LanguageCopyWith<$Res> get name;
  $LanguageCopyWith<$Res> get description;
}

/// @nodoc
class _$AiAgentCopyWithImpl<$Res, $Val extends AiAgent>
    implements $AiAgentCopyWith<$Res> {
  _$AiAgentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? avatar = null,
    Object? rank = null,
    Object? isFollowed = null,
    Object? subsetId = null,
    Object? tagId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Language,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Language,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowed: null == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool,
      subsetId: null == subsetId
          ? _value.subsetId
          : subsetId // ignore: cast_nullable_to_non_nullable
              as String,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LanguageCopyWith<$Res> get name {
    return $LanguageCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LanguageCopyWith<$Res> get description {
    return $LanguageCopyWith<$Res>(_value.description, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiAgentImplCopyWith<$Res> implements $AiAgentCopyWith<$Res> {
  factory _$$AiAgentImplCopyWith(
          _$AiAgentImpl value, $Res Function(_$AiAgentImpl) then) =
      __$$AiAgentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Language name,
      Language description,
      String avatar,
      int rank,
      @JsonKey(name: 'is_followed') bool isFollowed,
      @JsonKey(name: 'subset_id') String subsetId,
      @JsonKey(name: 'tag_id') String tagId});

  @override
  $LanguageCopyWith<$Res> get name;
  @override
  $LanguageCopyWith<$Res> get description;
}

/// @nodoc
class __$$AiAgentImplCopyWithImpl<$Res>
    extends _$AiAgentCopyWithImpl<$Res, _$AiAgentImpl>
    implements _$$AiAgentImplCopyWith<$Res> {
  __$$AiAgentImplCopyWithImpl(
      _$AiAgentImpl _value, $Res Function(_$AiAgentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? avatar = null,
    Object? rank = null,
    Object? isFollowed = null,
    Object? subsetId = null,
    Object? tagId = null,
  }) {
    return _then(_$AiAgentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Language,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Language,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowed: null == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool,
      subsetId: null == subsetId
          ? _value.subsetId
          : subsetId // ignore: cast_nullable_to_non_nullable
              as String,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiAgentImpl implements _AiAgent {
  const _$AiAgentImpl(
      {this.id = '',
      this.name = const Language(),
      this.description = const Language(),
      this.avatar = '',
      this.rank = 0,
      @JsonKey(name: 'is_followed') this.isFollowed = false,
      @JsonKey(name: 'subset_id') this.subsetId = '',
      @JsonKey(name: 'tag_id') this.tagId = ''});

  factory _$AiAgentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiAgentImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final Language name;
  @override
  @JsonKey()
  final Language description;
  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final int rank;
  @override
  @JsonKey(name: 'is_followed')
  final bool isFollowed;
  @override
  @JsonKey(name: 'subset_id')
  final String subsetId;
  @override
  @JsonKey(name: 'tag_id')
  final String tagId;

  @override
  String toString() {
    return 'AiAgent(id: $id, name: $name, description: $description, avatar: $avatar, rank: $rank, isFollowed: $isFollowed, subsetId: $subsetId, tagId: $tagId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiAgentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.isFollowed, isFollowed) ||
                other.isFollowed == isFollowed) &&
            (identical(other.subsetId, subsetId) ||
                other.subsetId == subsetId) &&
            (identical(other.tagId, tagId) || other.tagId == tagId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, avatar,
      rank, isFollowed, subsetId, tagId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiAgentImplCopyWith<_$AiAgentImpl> get copyWith =>
      __$$AiAgentImplCopyWithImpl<_$AiAgentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiAgentImplToJson(
      this,
    );
  }
}

abstract class _AiAgent implements AiAgent {
  const factory _AiAgent(
      {final String id,
      final Language name,
      final Language description,
      final String avatar,
      final int rank,
      @JsonKey(name: 'is_followed') final bool isFollowed,
      @JsonKey(name: 'subset_id') final String subsetId,
      @JsonKey(name: 'tag_id') final String tagId}) = _$AiAgentImpl;

  factory _AiAgent.fromJson(Map<String, dynamic> json) = _$AiAgentImpl.fromJson;

  @override
  String get id;
  @override
  Language get name;
  @override
  Language get description;
  @override
  String get avatar;
  @override
  int get rank;
  @override
  @JsonKey(name: 'is_followed')
  bool get isFollowed;
  @override
  @JsonKey(name: 'subset_id')
  String get subsetId;
  @override
  @JsonKey(name: 'tag_id')
  String get tagId;
  @override
  @JsonKey(ignore: true)
  _$$AiAgentImplCopyWith<_$AiAgentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
