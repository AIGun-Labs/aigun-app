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

IntelMessage _$IntelMessageFromJson(Map<String, dynamic> json) {
  return _IntelMessage.fromJson(json);
}

/// @nodoc
mixin _$IntelMessage {
  String? get type => throw _privateConstructorUsedError;
  Intel? get data => throw _privateConstructorUsedError;

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
  $Res call({String? type, Intel? data});

  $IntelCopyWith<$Res>? get data;
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
              as Intel?,
    ) as $Val);
  }

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $IntelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
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
  $Res call({String? type, Intel? data});

  @override
  $IntelCopyWith<$Res>? get data;
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
    Object? data = freezed,
  }) {
    return _then(_$IntelMessageImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Intel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelMessageImpl with DiagnosticableTreeMixin implements _IntelMessage {
  const _$IntelMessageImpl({this.type, this.data});

  factory _$IntelMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelMessageImplFromJson(json);

  @override
  final String? type;
  @override
  final Intel? data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelMessage(type: $type, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelMessage'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelMessageImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, data);

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
  const factory _IntelMessage({final String? type, final Intel? data}) =
      _$IntelMessageImpl;

  factory _IntelMessage.fromJson(Map<String, dynamic> json) =
      _$IntelMessageImpl.fromJson;

  @override
  String? get type;
  @override
  Intel? get data;

  /// Create a copy of IntelMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelMessageImplCopyWith<_$IntelMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Intel _$IntelFromJson(Map<String, dynamic> json) {
  return _Intel.fromJson(json);
}

/// @nodoc
mixin _$Intel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "signal_tags")
  List<String>? get signalTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_valuable')
  bool? get isValuable => throw _privateConstructorUsedError;
  @JsonKey(name: "token_keys")
  List<String>? get tokenKeys =>
      throw _privateConstructorUsedError; // @JsonKey(name: "is_published")
  @JsonKey(name: 'source_url')
  String? get sourceUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'extra_datas')
  IntelExtraDatas? get extraDatas => throw _privateConstructorUsedError;
  List<IntelMedia>? get medias => throw _privateConstructorUsedError;
  Analyzed? get analyzed => throw _privateConstructorUsedError;
  double? get score => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  List<Entity>? get entities => throw _privateConstructorUsedError;
  @JsonKey(name: "analyzed_time")
  double? get analyzedTime => throw _privateConstructorUsedError;
  @JsonKey(name: "monitor_time")
  double? get monitorTime => throw _privateConstructorUsedError;
  @JsonKey(name: "ai_agent")
  AIAgent? get aiAgent => throw _privateConstructorUsedError;
  @JsonKey(name: "author")
  Author? get author => throw _privateConstructorUsedError;

  /// Serializes this Intel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelCopyWith<Intel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelCopyWith<$Res> {
  factory $IntelCopyWith(Intel value, $Res Function(Intel) then) =
      _$IntelCopyWithImpl<$Res, Intel>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
      DateTime? publishedAt,
      @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
      DateTime? createdAt,
      @JsonKey(name: "signal_tags") List<String>? signalTags,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
      DateTime? updatedAt,
      @JsonKey(name: 'is_valuable') bool? isValuable,
      @JsonKey(name: "token_keys") List<String>? tokenKeys,
      @JsonKey(name: 'source_url') String? sourceUrl,
      @JsonKey(name: "type") String? type,
      String? title,
      String? content,
      @JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas,
      List<IntelMedia>? medias,
      Analyzed? analyzed,
      double? score,
      List<String>? tags,
      List<Entity>? entities,
      @JsonKey(name: "analyzed_time") double? analyzedTime,
      @JsonKey(name: "monitor_time") double? monitorTime,
      @JsonKey(name: "ai_agent") AIAgent? aiAgent,
      @JsonKey(name: "author") Author? author});

  $IntelExtraDatasCopyWith<$Res>? get extraDatas;
  $AnalyzedCopyWith<$Res>? get analyzed;
  $AIAgentCopyWith<$Res>? get aiAgent;
  $AuthorCopyWith<$Res>? get author;
}

/// @nodoc
class _$IntelCopyWithImpl<$Res, $Val extends Intel>
    implements $IntelCopyWith<$Res> {
  _$IntelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? publishedAt = freezed,
    Object? createdAt = freezed,
    Object? signalTags = freezed,
    Object? updatedAt = freezed,
    Object? isValuable = freezed,
    Object? tokenKeys = freezed,
    Object? sourceUrl = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? extraDatas = freezed,
    Object? medias = freezed,
    Object? analyzed = freezed,
    Object? score = freezed,
    Object? tags = freezed,
    Object? entities = freezed,
    Object? analyzedTime = freezed,
    Object? monitorTime = freezed,
    Object? aiAgent = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signalTags: freezed == signalTags
          ? _value.signalTags
          : signalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isValuable: freezed == isValuable
          ? _value.isValuable
          : isValuable // ignore: cast_nullable_to_non_nullable
              as bool?,
      tokenKeys: freezed == tokenKeys
          ? _value.tokenKeys
          : tokenKeys // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      extraDatas: freezed == extraDatas
          ? _value.extraDatas
          : extraDatas // ignore: cast_nullable_to_non_nullable
              as IntelExtraDatas?,
      medias: freezed == medias
          ? _value.medias
          : medias // ignore: cast_nullable_to_non_nullable
              as List<IntelMedia>?,
      analyzed: freezed == analyzed
          ? _value.analyzed
          : analyzed // ignore: cast_nullable_to_non_nullable
              as Analyzed?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      entities: freezed == entities
          ? _value.entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<Entity>?,
      analyzedTime: freezed == analyzedTime
          ? _value.analyzedTime
          : analyzedTime // ignore: cast_nullable_to_non_nullable
              as double?,
      monitorTime: freezed == monitorTime
          ? _value.monitorTime
          : monitorTime // ignore: cast_nullable_to_non_nullable
              as double?,
      aiAgent: freezed == aiAgent
          ? _value.aiAgent
          : aiAgent // ignore: cast_nullable_to_non_nullable
              as AIAgent?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author?,
    ) as $Val);
  }

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelExtraDatasCopyWith<$Res>? get extraDatas {
    if (_value.extraDatas == null) {
      return null;
    }

    return $IntelExtraDatasCopyWith<$Res>(_value.extraDatas!, (value) {
      return _then(_value.copyWith(extraDatas: value) as $Val);
    });
  }

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalyzedCopyWith<$Res>? get analyzed {
    if (_value.analyzed == null) {
      return null;
    }

    return $AnalyzedCopyWith<$Res>(_value.analyzed!, (value) {
      return _then(_value.copyWith(analyzed: value) as $Val);
    });
  }

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AIAgentCopyWith<$Res>? get aiAgent {
    if (_value.aiAgent == null) {
      return null;
    }

    return $AIAgentCopyWith<$Res>(_value.aiAgent!, (value) {
      return _then(_value.copyWith(aiAgent: value) as $Val);
    });
  }

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $AuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntelImplCopyWith<$Res> implements $IntelCopyWith<$Res> {
  factory _$$IntelImplCopyWith(
          _$IntelImpl value, $Res Function(_$IntelImpl) then) =
      __$$IntelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
      DateTime? publishedAt,
      @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
      DateTime? createdAt,
      @JsonKey(name: "signal_tags") List<String>? signalTags,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
      DateTime? updatedAt,
      @JsonKey(name: 'is_valuable') bool? isValuable,
      @JsonKey(name: "token_keys") List<String>? tokenKeys,
      @JsonKey(name: 'source_url') String? sourceUrl,
      @JsonKey(name: "type") String? type,
      String? title,
      String? content,
      @JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas,
      List<IntelMedia>? medias,
      Analyzed? analyzed,
      double? score,
      List<String>? tags,
      List<Entity>? entities,
      @JsonKey(name: "analyzed_time") double? analyzedTime,
      @JsonKey(name: "monitor_time") double? monitorTime,
      @JsonKey(name: "ai_agent") AIAgent? aiAgent,
      @JsonKey(name: "author") Author? author});

  @override
  $IntelExtraDatasCopyWith<$Res>? get extraDatas;
  @override
  $AnalyzedCopyWith<$Res>? get analyzed;
  @override
  $AIAgentCopyWith<$Res>? get aiAgent;
  @override
  $AuthorCopyWith<$Res>? get author;
}

/// @nodoc
class __$$IntelImplCopyWithImpl<$Res>
    extends _$IntelCopyWithImpl<$Res, _$IntelImpl>
    implements _$$IntelImplCopyWith<$Res> {
  __$$IntelImplCopyWithImpl(
      _$IntelImpl _value, $Res Function(_$IntelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? publishedAt = freezed,
    Object? createdAt = freezed,
    Object? signalTags = freezed,
    Object? updatedAt = freezed,
    Object? isValuable = freezed,
    Object? tokenKeys = freezed,
    Object? sourceUrl = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? extraDatas = freezed,
    Object? medias = freezed,
    Object? analyzed = freezed,
    Object? score = freezed,
    Object? tags = freezed,
    Object? entities = freezed,
    Object? analyzedTime = freezed,
    Object? monitorTime = freezed,
    Object? aiAgent = freezed,
    Object? author = freezed,
  }) {
    return _then(_$IntelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signalTags: freezed == signalTags
          ? _value._signalTags
          : signalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isValuable: freezed == isValuable
          ? _value.isValuable
          : isValuable // ignore: cast_nullable_to_non_nullable
              as bool?,
      tokenKeys: freezed == tokenKeys
          ? _value._tokenKeys
          : tokenKeys // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      extraDatas: freezed == extraDatas
          ? _value.extraDatas
          : extraDatas // ignore: cast_nullable_to_non_nullable
              as IntelExtraDatas?,
      medias: freezed == medias
          ? _value._medias
          : medias // ignore: cast_nullable_to_non_nullable
              as List<IntelMedia>?,
      analyzed: freezed == analyzed
          ? _value.analyzed
          : analyzed // ignore: cast_nullable_to_non_nullable
              as Analyzed?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      entities: freezed == entities
          ? _value._entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<Entity>?,
      analyzedTime: freezed == analyzedTime
          ? _value.analyzedTime
          : analyzedTime // ignore: cast_nullable_to_non_nullable
              as double?,
      monitorTime: freezed == monitorTime
          ? _value.monitorTime
          : monitorTime // ignore: cast_nullable_to_non_nullable
              as double?,
      aiAgent: freezed == aiAgent
          ? _value.aiAgent
          : aiAgent // ignore: cast_nullable_to_non_nullable
              as AIAgent?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$IntelImpl with DiagnosticableTreeMixin implements _Intel {
  const _$IntelImpl(
      {this.id,
      @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
      this.publishedAt,
      @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
      this.createdAt,
      @JsonKey(name: "signal_tags") final List<String>? signalTags,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
      this.updatedAt,
      @JsonKey(name: 'is_valuable') this.isValuable,
      @JsonKey(name: "token_keys") final List<String>? tokenKeys,
      @JsonKey(name: 'source_url') this.sourceUrl,
      @JsonKey(name: "type") this.type,
      this.title,
      this.content,
      @JsonKey(name: 'extra_datas') this.extraDatas,
      final List<IntelMedia>? medias,
      this.analyzed,
      this.score,
      final List<String>? tags,
      final List<Entity>? entities,
      @JsonKey(name: "analyzed_time") this.analyzedTime,
      @JsonKey(name: "monitor_time") this.monitorTime,
      @JsonKey(name: "ai_agent") this.aiAgent,
      @JsonKey(name: "author") this.author})
      : _signalTags = signalTags,
        _tokenKeys = tokenKeys,
        _medias = medias,
        _tags = tags,
        _entities = entities;

  factory _$IntelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
  final DateTime? publishedAt;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
  final DateTime? createdAt;
  final List<String>? _signalTags;
  @override
  @JsonKey(name: "signal_tags")
  List<String>? get signalTags {
    final value = _signalTags;
    if (value == null) return null;
    if (_signalTags is EqualUnmodifiableListView) return _signalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'is_valuable')
  final bool? isValuable;
  final List<String>? _tokenKeys;
  @override
  @JsonKey(name: "token_keys")
  List<String>? get tokenKeys {
    final value = _tokenKeys;
    if (value == null) return null;
    if (_tokenKeys is EqualUnmodifiableListView) return _tokenKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// @JsonKey(name: "is_published")
  @override
  @JsonKey(name: 'source_url')
  final String? sourceUrl;
  @override
  @JsonKey(name: "type")
  final String? type;
  @override
  final String? title;
  @override
  final String? content;
  @override
  @JsonKey(name: 'extra_datas')
  final IntelExtraDatas? extraDatas;
  final List<IntelMedia>? _medias;
  @override
  List<IntelMedia>? get medias {
    final value = _medias;
    if (value == null) return null;
    if (_medias is EqualUnmodifiableListView) return _medias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Analyzed? analyzed;
  @override
  final double? score;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Entity>? _entities;
  @override
  List<Entity>? get entities {
    final value = _entities;
    if (value == null) return null;
    if (_entities is EqualUnmodifiableListView) return _entities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "analyzed_time")
  final double? analyzedTime;
  @override
  @JsonKey(name: "monitor_time")
  final double? monitorTime;
  @override
  @JsonKey(name: "ai_agent")
  final AIAgent? aiAgent;
  @override
  @JsonKey(name: "author")
  final Author? author;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Intel(id: $id, publishedAt: $publishedAt, createdAt: $createdAt, signalTags: $signalTags, updatedAt: $updatedAt, isValuable: $isValuable, tokenKeys: $tokenKeys, sourceUrl: $sourceUrl, type: $type, title: $title, content: $content, extraDatas: $extraDatas, medias: $medias, analyzed: $analyzed, score: $score, tags: $tags, entities: $entities, analyzedTime: $analyzedTime, monitorTime: $monitorTime, aiAgent: $aiAgent, author: $author)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Intel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('signalTags', signalTags))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('isValuable', isValuable))
      ..add(DiagnosticsProperty('tokenKeys', tokenKeys))
      ..add(DiagnosticsProperty('sourceUrl', sourceUrl))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('extraDatas', extraDatas))
      ..add(DiagnosticsProperty('medias', medias))
      ..add(DiagnosticsProperty('analyzed', analyzed))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('entities', entities))
      ..add(DiagnosticsProperty('analyzedTime', analyzedTime))
      ..add(DiagnosticsProperty('monitorTime', monitorTime))
      ..add(DiagnosticsProperty('aiAgent', aiAgent))
      ..add(DiagnosticsProperty('author', author));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._signalTags, _signalTags) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isValuable, isValuable) ||
                other.isValuable == isValuable) &&
            const DeepCollectionEquality()
                .equals(other._tokenKeys, _tokenKeys) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.extraDatas, extraDatas) ||
                other.extraDatas == extraDatas) &&
            const DeepCollectionEquality().equals(other._medias, _medias) &&
            (identical(other.analyzed, analyzed) ||
                other.analyzed == analyzed) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._entities, _entities) &&
            (identical(other.analyzedTime, analyzedTime) ||
                other.analyzedTime == analyzedTime) &&
            (identical(other.monitorTime, monitorTime) ||
                other.monitorTime == monitorTime) &&
            (identical(other.aiAgent, aiAgent) || other.aiAgent == aiAgent) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        publishedAt,
        createdAt,
        const DeepCollectionEquality().hash(_signalTags),
        updatedAt,
        isValuable,
        const DeepCollectionEquality().hash(_tokenKeys),
        sourceUrl,
        type,
        title,
        content,
        extraDatas,
        const DeepCollectionEquality().hash(_medias),
        analyzed,
        score,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_entities),
        analyzedTime,
        monitorTime,
        aiAgent,
        author
      ]);

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelImplCopyWith<_$IntelImpl> get copyWith =>
      __$$IntelImplCopyWithImpl<_$IntelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelImplToJson(
      this,
    );
  }
}

abstract class _Intel implements Intel {
  const factory _Intel(
      {final String? id,
      @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
      final DateTime? publishedAt,
      @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
      final DateTime? createdAt,
      @JsonKey(name: "signal_tags") final List<String>? signalTags,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
      final DateTime? updatedAt,
      @JsonKey(name: 'is_valuable') final bool? isValuable,
      @JsonKey(name: "token_keys") final List<String>? tokenKeys,
      @JsonKey(name: 'source_url') final String? sourceUrl,
      @JsonKey(name: "type") final String? type,
      final String? title,
      final String? content,
      @JsonKey(name: 'extra_datas') final IntelExtraDatas? extraDatas,
      final List<IntelMedia>? medias,
      final Analyzed? analyzed,
      final double? score,
      final List<String>? tags,
      final List<Entity>? entities,
      @JsonKey(name: "analyzed_time") final double? analyzedTime,
      @JsonKey(name: "monitor_time") final double? monitorTime,
      @JsonKey(name: "ai_agent") final AIAgent? aiAgent,
      @JsonKey(name: "author") final Author? author}) = _$IntelImpl;

  factory _Intel.fromJson(Map<String, dynamic> json) = _$IntelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'published_at', fromJson: _dateTimeFromDynamic)
  DateTime? get publishedAt;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
  DateTime? get createdAt;
  @override
  @JsonKey(name: "signal_tags")
  List<String>? get signalTags;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'is_valuable')
  bool? get isValuable;
  @override
  @JsonKey(name: "token_keys")
  List<String>? get tokenKeys; // @JsonKey(name: "is_published")
  @override
  @JsonKey(name: 'source_url')
  String? get sourceUrl;
  @override
  @JsonKey(name: "type")
  String? get type;
  @override
  String? get title;
  @override
  String? get content;
  @override
  @JsonKey(name: 'extra_datas')
  IntelExtraDatas? get extraDatas;
  @override
  List<IntelMedia>? get medias;
  @override
  Analyzed? get analyzed;
  @override
  double? get score;
  @override
  List<String>? get tags;
  @override
  List<Entity>? get entities;
  @override
  @JsonKey(name: "analyzed_time")
  double? get analyzedTime;
  @override
  @JsonKey(name: "monitor_time")
  double? get monitorTime;
  @override
  @JsonKey(name: "ai_agent")
  AIAgent? get aiAgent;
  @override
  @JsonKey(name: "author")
  Author? get author;

  /// Create a copy of Intel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelImplCopyWith<_$IntelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelExtraDatas _$IntelExtraDatasFromJson(Map<String, dynamic> json) {
  return _IntelExtraDatas.fromJson(json);
}

/// @nodoc
mixin _$IntelExtraDatas {
  @JsonKey(name: "is_alpha")
  bool? get isAlpha => throw _privateConstructorUsedError;

  /// Serializes this IntelExtraDatas to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelExtraDatas
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelExtraDatasCopyWith<IntelExtraDatas> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelExtraDatasCopyWith<$Res> {
  factory $IntelExtraDatasCopyWith(
          IntelExtraDatas value, $Res Function(IntelExtraDatas) then) =
      _$IntelExtraDatasCopyWithImpl<$Res, IntelExtraDatas>;
  @useResult
  $Res call({@JsonKey(name: "is_alpha") bool? isAlpha});
}

/// @nodoc
class _$IntelExtraDatasCopyWithImpl<$Res, $Val extends IntelExtraDatas>
    implements $IntelExtraDatasCopyWith<$Res> {
  _$IntelExtraDatasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelExtraDatas
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlpha = freezed,
  }) {
    return _then(_value.copyWith(
      isAlpha: freezed == isAlpha
          ? _value.isAlpha
          : isAlpha // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelExtraDatasImplCopyWith<$Res>
    implements $IntelExtraDatasCopyWith<$Res> {
  factory _$$IntelExtraDatasImplCopyWith(_$IntelExtraDatasImpl value,
          $Res Function(_$IntelExtraDatasImpl) then) =
      __$$IntelExtraDatasImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "is_alpha") bool? isAlpha});
}

/// @nodoc
class __$$IntelExtraDatasImplCopyWithImpl<$Res>
    extends _$IntelExtraDatasCopyWithImpl<$Res, _$IntelExtraDatasImpl>
    implements _$$IntelExtraDatasImplCopyWith<$Res> {
  __$$IntelExtraDatasImplCopyWithImpl(
      _$IntelExtraDatasImpl _value, $Res Function(_$IntelExtraDatasImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelExtraDatas
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlpha = freezed,
  }) {
    return _then(_$IntelExtraDatasImpl(
      isAlpha: freezed == isAlpha
          ? _value.isAlpha
          : isAlpha // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelExtraDatasImpl
    with DiagnosticableTreeMixin
    implements _IntelExtraDatas {
  const _$IntelExtraDatasImpl(
      {@JsonKey(name: "is_alpha") this.isAlpha = false});

  factory _$IntelExtraDatasImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelExtraDatasImplFromJson(json);

  @override
  @JsonKey(name: "is_alpha")
  final bool? isAlpha;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelExtraDatas(isAlpha: $isAlpha)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelExtraDatas'))
      ..add(DiagnosticsProperty('isAlpha', isAlpha));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelExtraDatasImpl &&
            (identical(other.isAlpha, isAlpha) || other.isAlpha == isAlpha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isAlpha);

  /// Create a copy of IntelExtraDatas
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelExtraDatasImplCopyWith<_$IntelExtraDatasImpl> get copyWith =>
      __$$IntelExtraDatasImplCopyWithImpl<_$IntelExtraDatasImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelExtraDatasImplToJson(
      this,
    );
  }
}

abstract class _IntelExtraDatas implements IntelExtraDatas {
  const factory _IntelExtraDatas(
      {@JsonKey(name: "is_alpha") final bool? isAlpha}) = _$IntelExtraDatasImpl;

  factory _IntelExtraDatas.fromJson(Map<String, dynamic> json) =
      _$IntelExtraDatasImpl.fromJson;

  @override
  @JsonKey(name: "is_alpha")
  bool? get isAlpha;

  /// Create a copy of IntelExtraDatas
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelExtraDatasImplCopyWith<_$IntelExtraDatasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelStats _$IntelStatsFromJson(Map<String, dynamic> json) {
  return _IntelStats.fromJson(json);
}

/// @nodoc
mixin _$IntelStats {
  @JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
  String? get warningPriceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
  String? get warningMarketCap => throw _privateConstructorUsedError;
  @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
  String? get currentPriceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
  String? get currentMarketCap => throw _privateConstructorUsedError;
  @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
  String? get increaseRate => throw _privateConstructorUsedError;
  @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
  String? get heighestIncreaseRate => throw _privateConstructorUsedError;
  @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
  String? get highestDecreaseRate => throw _privateConstructorUsedError;

  /// Serializes this IntelStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelStatsCopyWith<IntelStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelStatsCopyWith<$Res> {
  factory $IntelStatsCopyWith(
          IntelStats value, $Res Function(IntelStats) then) =
      _$IntelStatsCopyWithImpl<$Res, IntelStats>;
  @useResult
  $Res call(
      {@JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
      String? warningPriceUsd,
      @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
      String? warningMarketCap,
      @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
      String? currentPriceUsd,
      @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
      String? currentMarketCap,
      @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
      String? increaseRate,
      @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
      String? heighestIncreaseRate,
      @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
      String? highestDecreaseRate});
}

/// @nodoc
class _$IntelStatsCopyWithImpl<$Res, $Val extends IntelStats>
    implements $IntelStatsCopyWith<$Res> {
  _$IntelStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warningPriceUsd = freezed,
    Object? warningMarketCap = freezed,
    Object? currentPriceUsd = freezed,
    Object? currentMarketCap = freezed,
    Object? increaseRate = freezed,
    Object? heighestIncreaseRate = freezed,
    Object? highestDecreaseRate = freezed,
  }) {
    return _then(_value.copyWith(
      warningPriceUsd: freezed == warningPriceUsd
          ? _value.warningPriceUsd
          : warningPriceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      warningMarketCap: freezed == warningMarketCap
          ? _value.warningMarketCap
          : warningMarketCap // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPriceUsd: freezed == currentPriceUsd
          ? _value.currentPriceUsd
          : currentPriceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMarketCap: freezed == currentMarketCap
          ? _value.currentMarketCap
          : currentMarketCap // ignore: cast_nullable_to_non_nullable
              as String?,
      increaseRate: freezed == increaseRate
          ? _value.increaseRate
          : increaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      heighestIncreaseRate: freezed == heighestIncreaseRate
          ? _value.heighestIncreaseRate
          : heighestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      highestDecreaseRate: freezed == highestDecreaseRate
          ? _value.highestDecreaseRate
          : highestDecreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelStatsImplCopyWith<$Res>
    implements $IntelStatsCopyWith<$Res> {
  factory _$$IntelStatsImplCopyWith(
          _$IntelStatsImpl value, $Res Function(_$IntelStatsImpl) then) =
      __$$IntelStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
      String? warningPriceUsd,
      @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
      String? warningMarketCap,
      @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
      String? currentPriceUsd,
      @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
      String? currentMarketCap,
      @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
      String? increaseRate,
      @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
      String? heighestIncreaseRate,
      @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
      String? highestDecreaseRate});
}

/// @nodoc
class __$$IntelStatsImplCopyWithImpl<$Res>
    extends _$IntelStatsCopyWithImpl<$Res, _$IntelStatsImpl>
    implements _$$IntelStatsImplCopyWith<$Res> {
  __$$IntelStatsImplCopyWithImpl(
      _$IntelStatsImpl _value, $Res Function(_$IntelStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warningPriceUsd = freezed,
    Object? warningMarketCap = freezed,
    Object? currentPriceUsd = freezed,
    Object? currentMarketCap = freezed,
    Object? increaseRate = freezed,
    Object? heighestIncreaseRate = freezed,
    Object? highestDecreaseRate = freezed,
  }) {
    return _then(_$IntelStatsImpl(
      warningPriceUsd: freezed == warningPriceUsd
          ? _value.warningPriceUsd
          : warningPriceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      warningMarketCap: freezed == warningMarketCap
          ? _value.warningMarketCap
          : warningMarketCap // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPriceUsd: freezed == currentPriceUsd
          ? _value.currentPriceUsd
          : currentPriceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMarketCap: freezed == currentMarketCap
          ? _value.currentMarketCap
          : currentMarketCap // ignore: cast_nullable_to_non_nullable
              as String?,
      increaseRate: freezed == increaseRate
          ? _value.increaseRate
          : increaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      heighestIncreaseRate: freezed == heighestIncreaseRate
          ? _value.heighestIncreaseRate
          : heighestIncreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
      highestDecreaseRate: freezed == highestDecreaseRate
          ? _value.highestDecreaseRate
          : highestDecreaseRate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelStatsImpl with DiagnosticableTreeMixin implements _IntelStats {
  const _$IntelStatsImpl(
      {@JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
      this.warningPriceUsd,
      @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
      this.warningMarketCap,
      @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
      this.currentPriceUsd,
      @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
      this.currentMarketCap,
      @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
      this.increaseRate,
      @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
      this.heighestIncreaseRate,
      @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
      this.highestDecreaseRate});

  factory _$IntelStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelStatsImplFromJson(json);

  @override
  @JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
  final String? warningPriceUsd;
  @override
  @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
  final String? warningMarketCap;
  @override
  @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
  final String? currentPriceUsd;
  @override
  @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
  final String? currentMarketCap;
  @override
  @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
  final String? increaseRate;
  @override
  @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
  final String? heighestIncreaseRate;
  @override
  @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
  final String? highestDecreaseRate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelStats(warningPriceUsd: $warningPriceUsd, warningMarketCap: $warningMarketCap, currentPriceUsd: $currentPriceUsd, currentMarketCap: $currentMarketCap, increaseRate: $increaseRate, heighestIncreaseRate: $heighestIncreaseRate, highestDecreaseRate: $highestDecreaseRate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelStats'))
      ..add(DiagnosticsProperty('warningPriceUsd', warningPriceUsd))
      ..add(DiagnosticsProperty('warningMarketCap', warningMarketCap))
      ..add(DiagnosticsProperty('currentPriceUsd', currentPriceUsd))
      ..add(DiagnosticsProperty('currentMarketCap', currentMarketCap))
      ..add(DiagnosticsProperty('increaseRate', increaseRate))
      ..add(DiagnosticsProperty('heighestIncreaseRate', heighestIncreaseRate))
      ..add(DiagnosticsProperty('highestDecreaseRate', highestDecreaseRate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelStatsImpl &&
            (identical(other.warningPriceUsd, warningPriceUsd) ||
                other.warningPriceUsd == warningPriceUsd) &&
            (identical(other.warningMarketCap, warningMarketCap) ||
                other.warningMarketCap == warningMarketCap) &&
            (identical(other.currentPriceUsd, currentPriceUsd) ||
                other.currentPriceUsd == currentPriceUsd) &&
            (identical(other.currentMarketCap, currentMarketCap) ||
                other.currentMarketCap == currentMarketCap) &&
            (identical(other.increaseRate, increaseRate) ||
                other.increaseRate == increaseRate) &&
            (identical(other.heighestIncreaseRate, heighestIncreaseRate) ||
                other.heighestIncreaseRate == heighestIncreaseRate) &&
            (identical(other.highestDecreaseRate, highestDecreaseRate) ||
                other.highestDecreaseRate == highestDecreaseRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      warningPriceUsd,
      warningMarketCap,
      currentPriceUsd,
      currentMarketCap,
      increaseRate,
      heighestIncreaseRate,
      highestDecreaseRate);

  /// Create a copy of IntelStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelStatsImplCopyWith<_$IntelStatsImpl> get copyWith =>
      __$$IntelStatsImplCopyWithImpl<_$IntelStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelStatsImplToJson(
      this,
    );
  }
}

abstract class _IntelStats implements IntelStats {
  const factory _IntelStats(
      {@JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
      final String? warningPriceUsd,
      @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
      final String? warningMarketCap,
      @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
      final String? currentPriceUsd,
      @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
      final String? currentMarketCap,
      @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
      final String? increaseRate,
      @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
      final String? heighestIncreaseRate,
      @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
      final String? highestDecreaseRate}) = _$IntelStatsImpl;

  factory _IntelStats.fromJson(Map<String, dynamic> json) =
      _$IntelStatsImpl.fromJson;

  @override
  @JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
  String? get warningPriceUsd;
  @override
  @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
  String? get warningMarketCap;
  @override
  @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
  String? get currentPriceUsd;
  @override
  @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
  String? get currentMarketCap;
  @override
  @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
  String? get increaseRate;
  @override
  @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
  String? get heighestIncreaseRate;
  @override
  @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
  String? get highestDecreaseRate;

  /// Create a copy of IntelStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelStatsImplCopyWith<_$IntelStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIAgent _$AIAgentFromJson(Map<String, dynamic> json) {
  return _AIAgent.fromJson(json);
}

/// @nodoc
mixin _$AIAgent {
  Map<String, String>? get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this AIAgent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIAgent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIAgentCopyWith<AIAgent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIAgentCopyWith<$Res> {
  factory $AIAgentCopyWith(AIAgent value, $Res Function(AIAgent) then) =
      _$AIAgentCopyWithImpl<$Res, AIAgent>;
  @useResult
  $Res call({Map<String, String>? name, String? avatar});
}

/// @nodoc
class _$AIAgentCopyWithImpl<$Res, $Val extends AIAgent>
    implements $AIAgentCopyWith<$Res> {
  _$AIAgentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIAgent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIAgentImplCopyWith<$Res> implements $AIAgentCopyWith<$Res> {
  factory _$$AIAgentImplCopyWith(
          _$AIAgentImpl value, $Res Function(_$AIAgentImpl) then) =
      __$$AIAgentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String>? name, String? avatar});
}

/// @nodoc
class __$$AIAgentImplCopyWithImpl<$Res>
    extends _$AIAgentCopyWithImpl<$Res, _$AIAgentImpl>
    implements _$$AIAgentImplCopyWith<$Res> {
  __$$AIAgentImplCopyWithImpl(
      _$AIAgentImpl _value, $Res Function(_$AIAgentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIAgent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$AIAgentImpl(
      name: freezed == name
          ? _value._name
          : name // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIAgentImpl with DiagnosticableTreeMixin implements _AIAgent {
  const _$AIAgentImpl({final Map<String, String>? name, this.avatar})
      : _name = name;

  factory _$AIAgentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIAgentImplFromJson(json);

  final Map<String, String>? _name;
  @override
  Map<String, String>? get name {
    final value = _name;
    if (value == null) return null;
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? avatar;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AIAgent(name: $name, avatar: $avatar)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AIAgent'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('avatar', avatar));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIAgentImpl &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_name), avatar);

  /// Create a copy of AIAgent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIAgentImplCopyWith<_$AIAgentImpl> get copyWith =>
      __$$AIAgentImplCopyWithImpl<_$AIAgentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIAgentImplToJson(
      this,
    );
  }
}

abstract class _AIAgent implements AIAgent {
  const factory _AIAgent(
      {final Map<String, String>? name, final String? avatar}) = _$AIAgentImpl;

  factory _AIAgent.fromJson(Map<String, dynamic> json) = _$AIAgentImpl.fromJson;

  @override
  Map<String, String>? get name;
  @override
  String? get avatar;

  /// Create a copy of AIAgent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIAgentImplCopyWith<_$AIAgentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return _Author.fromJson(json);
}

/// @nodoc
mixin _$Author {
  String? get avatar => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  IntelPlatform? get platform => throw _privateConstructorUsedError;
  String? get prompt => throw _privateConstructorUsedError;

  /// Serializes this Author to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthorCopyWith<Author> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorCopyWith<$Res> {
  factory $AuthorCopyWith(Author value, $Res Function(Author) then) =
      _$AuthorCopyWithImpl<$Res, Author>;
  @useResult
  $Res call(
      {String? avatar, String? slug, IntelPlatform? platform, String? prompt});

  $IntelPlatformCopyWith<$Res>? get platform;
}

/// @nodoc
class _$AuthorCopyWithImpl<$Res, $Val extends Author>
    implements $AuthorCopyWith<$Res> {
  _$AuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
    Object? slug = freezed,
    Object? platform = freezed,
    Object? prompt = freezed,
  }) {
    return _then(_value.copyWith(
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as IntelPlatform?,
      prompt: freezed == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelPlatformCopyWith<$Res>? get platform {
    if (_value.platform == null) {
      return null;
    }

    return $IntelPlatformCopyWith<$Res>(_value.platform!, (value) {
      return _then(_value.copyWith(platform: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthorImplCopyWith<$Res> implements $AuthorCopyWith<$Res> {
  factory _$$AuthorImplCopyWith(
          _$AuthorImpl value, $Res Function(_$AuthorImpl) then) =
      __$$AuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? avatar, String? slug, IntelPlatform? platform, String? prompt});

  @override
  $IntelPlatformCopyWith<$Res>? get platform;
}

/// @nodoc
class __$$AuthorImplCopyWithImpl<$Res>
    extends _$AuthorCopyWithImpl<$Res, _$AuthorImpl>
    implements _$$AuthorImplCopyWith<$Res> {
  __$$AuthorImplCopyWithImpl(
      _$AuthorImpl _value, $Res Function(_$AuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
    Object? slug = freezed,
    Object? platform = freezed,
    Object? prompt = freezed,
  }) {
    return _then(_$AuthorImpl(
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as IntelPlatform?,
      prompt: freezed == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorImpl with DiagnosticableTreeMixin implements _Author {
  const _$AuthorImpl({this.avatar, this.slug, this.platform, this.prompt});

  factory _$AuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorImplFromJson(json);

  @override
  final String? avatar;
  @override
  final String? slug;
  @override
  final IntelPlatform? platform;
  @override
  final String? prompt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Author(avatar: $avatar, slug: $slug, platform: $platform, prompt: $prompt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Author'))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('platform', platform))
      ..add(DiagnosticsProperty('prompt', prompt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorImpl &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, avatar, slug, platform, prompt);

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      __$$AuthorImplCopyWithImpl<_$AuthorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorImplToJson(
      this,
    );
  }
}

abstract class _Author implements Author {
  const factory _Author(
      {final String? avatar,
      final String? slug,
      final IntelPlatform? platform,
      final String? prompt}) = _$AuthorImpl;

  factory _Author.fromJson(Map<String, dynamic> json) = _$AuthorImpl.fromJson;

  @override
  String? get avatar;
  @override
  String? get slug;
  @override
  IntelPlatform? get platform;
  @override
  String? get prompt;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelPlatform _$IntelPlatformFromJson(Map<String, dynamic> json) {
  return _IntelPlatform.fromJson(json);
}

/// @nodoc
mixin _$IntelPlatform {
  String? get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  /// Serializes this IntelPlatform to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelPlatform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelPlatformCopyWith<IntelPlatform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelPlatformCopyWith<$Res> {
  factory $IntelPlatformCopyWith(
          IntelPlatform value, $Res Function(IntelPlatform) then) =
      _$IntelPlatformCopyWithImpl<$Res, IntelPlatform>;
  @useResult
  $Res call({String? name, String? id, String? logo});
}

/// @nodoc
class _$IntelPlatformCopyWithImpl<$Res, $Val extends IntelPlatform>
    implements $IntelPlatformCopyWith<$Res> {
  _$IntelPlatformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelPlatform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? logo = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelPlatformImplCopyWith<$Res>
    implements $IntelPlatformCopyWith<$Res> {
  factory _$$IntelPlatformImplCopyWith(
          _$IntelPlatformImpl value, $Res Function(_$IntelPlatformImpl) then) =
      __$$IntelPlatformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? id, String? logo});
}

/// @nodoc
class __$$IntelPlatformImplCopyWithImpl<$Res>
    extends _$IntelPlatformCopyWithImpl<$Res, _$IntelPlatformImpl>
    implements _$$IntelPlatformImplCopyWith<$Res> {
  __$$IntelPlatformImplCopyWithImpl(
      _$IntelPlatformImpl _value, $Res Function(_$IntelPlatformImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelPlatform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$IntelPlatformImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelPlatformImpl
    with DiagnosticableTreeMixin
    implements _IntelPlatform {
  const _$IntelPlatformImpl({this.name, this.id, this.logo});

  factory _$IntelPlatformImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelPlatformImplFromJson(json);

  @override
  final String? name;
  @override
  final String? id;
  @override
  final String? logo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelPlatform(name: $name, id: $id, logo: $logo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelPlatform'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('logo', logo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelPlatformImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, logo);

  /// Create a copy of IntelPlatform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelPlatformImplCopyWith<_$IntelPlatformImpl> get copyWith =>
      __$$IntelPlatformImplCopyWithImpl<_$IntelPlatformImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelPlatformImplToJson(
      this,
    );
  }
}

abstract class _IntelPlatform implements IntelPlatform {
  const factory _IntelPlatform(
      {final String? name,
      final String? id,
      final String? logo}) = _$IntelPlatformImpl;

  factory _IntelPlatform.fromJson(Map<String, dynamic> json) =
      _$IntelPlatformImpl.fromJson;

  @override
  String? get name;
  @override
  String? get id;
  @override
  String? get logo;

  /// Create a copy of IntelPlatform
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelPlatformImplCopyWith<_$IntelPlatformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelMedia _$IntelMediaFromJson(Map<String, dynamic> json) {
  return _IntelMedia.fromJson(json);
}

/// @nodoc
mixin _$IntelMedia {
  String? get url => throw _privateConstructorUsedError;
  MediaType? get type => throw _privateConstructorUsedError;

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
  $Res call({String? url, MediaType? type});
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
    Object? url = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MediaType?,
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
  $Res call({String? url, MediaType? type});
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
    Object? url = freezed,
    Object? type = freezed,
  }) {
    return _then(_$IntelMediaImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MediaType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelMediaImpl with DiagnosticableTreeMixin implements _IntelMedia {
  const _$IntelMediaImpl({this.url, this.type});

  factory _$IntelMediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelMediaImplFromJson(json);

  @override
  final String? url;
  @override
  final MediaType? type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelMedia(url: $url, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelMedia'))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelMediaImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type);

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
  const factory _IntelMedia({final String? url, final MediaType? type}) =
      _$IntelMediaImpl;

  factory _IntelMedia.fromJson(Map<String, dynamic> json) =
      _$IntelMediaImpl.fromJson;

  @override
  String? get url;
  @override
  MediaType? get type;

  /// Create a copy of IntelMedia
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelMediaImplCopyWith<_$IntelMediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Analyzed _$AnalyzedFromJson(Map<String, dynamic> json) {
  return _Analyzed.fromJson(json);
}

/// @nodoc
mixin _$Analyzed {
  String? get zh => throw _privateConstructorUsedError;
  String? get en => throw _privateConstructorUsedError;

  /// Serializes this Analyzed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Analyzed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyzedCopyWith<Analyzed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyzedCopyWith<$Res> {
  factory $AnalyzedCopyWith(Analyzed value, $Res Function(Analyzed) then) =
      _$AnalyzedCopyWithImpl<$Res, Analyzed>;
  @useResult
  $Res call({String? zh, String? en});
}

/// @nodoc
class _$AnalyzedCopyWithImpl<$Res, $Val extends Analyzed>
    implements $AnalyzedCopyWith<$Res> {
  _$AnalyzedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Analyzed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
  }) {
    return _then(_value.copyWith(
      zh: freezed == zh
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String?,
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyzedImplCopyWith<$Res>
    implements $AnalyzedCopyWith<$Res> {
  factory _$$AnalyzedImplCopyWith(
          _$AnalyzedImpl value, $Res Function(_$AnalyzedImpl) then) =
      __$$AnalyzedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? zh, String? en});
}

/// @nodoc
class __$$AnalyzedImplCopyWithImpl<$Res>
    extends _$AnalyzedCopyWithImpl<$Res, _$AnalyzedImpl>
    implements _$$AnalyzedImplCopyWith<$Res> {
  __$$AnalyzedImplCopyWithImpl(
      _$AnalyzedImpl _value, $Res Function(_$AnalyzedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Analyzed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
  }) {
    return _then(_$AnalyzedImpl(
      zh: freezed == zh
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String?,
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyzedImpl with DiagnosticableTreeMixin implements _Analyzed {
  const _$AnalyzedImpl({this.zh, this.en});

  factory _$AnalyzedImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyzedImplFromJson(json);

  @override
  final String? zh;
  @override
  final String? en;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Analyzed(zh: $zh, en: $en)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Analyzed'))
      ..add(DiagnosticsProperty('zh', zh))
      ..add(DiagnosticsProperty('en', en));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyzedImpl &&
            (identical(other.zh, zh) || other.zh == zh) &&
            (identical(other.en, en) || other.en == en));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, zh, en);

  /// Create a copy of Analyzed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyzedImplCopyWith<_$AnalyzedImpl> get copyWith =>
      __$$AnalyzedImplCopyWithImpl<_$AnalyzedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyzedImplToJson(
      this,
    );
  }
}

abstract class _Analyzed implements Analyzed {
  const factory _Analyzed({final String? zh, final String? en}) =
      _$AnalyzedImpl;

  factory _Analyzed.fromJson(Map<String, dynamic> json) =
      _$AnalyzedImpl.fromJson;

  @override
  String? get zh;
  @override
  String? get en;

  /// Create a copy of Analyzed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyzedImplCopyWith<_$AnalyzedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntelChain _$IntelChainFromJson(Map<String, dynamic> json) {
  return _IntelChain.fromJson(json);
}

/// @nodoc
mixin _$IntelChain {
  String? get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: "network_id")
  String? get networkId => throw _privateConstructorUsedError;

  /// Serializes this IntelChain to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntelChain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntelChainCopyWith<IntelChain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelChainCopyWith<$Res> {
  factory $IntelChainCopyWith(
          IntelChain value, $Res Function(IntelChain) then) =
      _$IntelChainCopyWithImpl<$Res, IntelChain>;
  @useResult
  $Res call(
      {String? name,
      String? id,
      String? address,
      String? logo,
      String? slug,
      @JsonKey(name: "network_id") String? networkId});
}

/// @nodoc
class _$IntelChainCopyWithImpl<$Res, $Val extends IntelChain>
    implements $IntelChainCopyWith<$Res> {
  _$IntelChainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntelChain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? logo = freezed,
    Object? slug = freezed,
    Object? networkId = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      networkId: freezed == networkId
          ? _value.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntelChainImplCopyWith<$Res>
    implements $IntelChainCopyWith<$Res> {
  factory _$$IntelChainImplCopyWith(
          _$IntelChainImpl value, $Res Function(_$IntelChainImpl) then) =
      __$$IntelChainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? id,
      String? address,
      String? logo,
      String? slug,
      @JsonKey(name: "network_id") String? networkId});
}

/// @nodoc
class __$$IntelChainImplCopyWithImpl<$Res>
    extends _$IntelChainCopyWithImpl<$Res, _$IntelChainImpl>
    implements _$$IntelChainImplCopyWith<$Res> {
  __$$IntelChainImplCopyWithImpl(
      _$IntelChainImpl _value, $Res Function(_$IntelChainImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntelChain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? logo = freezed,
    Object? slug = freezed,
    Object? networkId = freezed,
  }) {
    return _then(_$IntelChainImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      networkId: freezed == networkId
          ? _value.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelChainImpl with DiagnosticableTreeMixin implements _IntelChain {
  const _$IntelChainImpl(
      {this.name,
      this.id,
      this.address,
      this.logo,
      this.slug,
      @JsonKey(name: "network_id") this.networkId});

  factory _$IntelChainImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelChainImplFromJson(json);

  @override
  final String? name;
  @override
  final String? id;
  @override
  final String? address;
  @override
  final String? logo;
  @override
  final String? slug;
  @override
  @JsonKey(name: "network_id")
  final String? networkId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntelChain(name: $name, id: $id, address: $address, logo: $logo, slug: $slug, networkId: $networkId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntelChain'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('networkId', networkId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelChainImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, id, address, logo, slug, networkId);

  /// Create a copy of IntelChain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelChainImplCopyWith<_$IntelChainImpl> get copyWith =>
      __$$IntelChainImplCopyWithImpl<_$IntelChainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelChainImplToJson(
      this,
    );
  }
}

abstract class _IntelChain implements IntelChain {
  const factory _IntelChain(
      {final String? name,
      final String? id,
      final String? address,
      final String? logo,
      final String? slug,
      @JsonKey(name: "network_id") final String? networkId}) = _$IntelChainImpl;

  factory _IntelChain.fromJson(Map<String, dynamic> json) =
      _$IntelChainImpl.fromJson;

  @override
  String? get name;
  @override
  String? get id;
  @override
  String? get address;
  @override
  String? get logo;
  @override
  String? get slug;
  @override
  @JsonKey(name: "network_id")
  String? get networkId;

  /// Create a copy of IntelChain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntelChainImplCopyWith<_$IntelChainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return _Entity.fromJson(json);
}

/// @nodoc
mixin _$Entity {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "entity_id")
  String? get entityId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;
  String? get standard => throw _privateConstructorUsedError;
  int? get decimals => throw _privateConstructorUsedError;
  @JsonKey(name: "contract_address")
  String? get contractAddress => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  @JsonKey(name: "stats")
  IntelStats? get stats => throw _privateConstructorUsedError;
  @JsonKey(name: "chain")
  IntelChain? get chain => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "is_native")
  bool? get isNative => throw _privateConstructorUsedError;

  /// Serializes this Entity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntityCopyWith<Entity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityCopyWith<$Res> {
  factory $EntityCopyWith(Entity value, $Res Function(Entity) then) =
      _$EntityCopyWithImpl<$Res, Entity>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: "entity_id") String? entityId,
      String? name,
      String? symbol,
      String? standard,
      int? decimals,
      @JsonKey(name: "contract_address") String? contractAddress,
      String? logo,
      @JsonKey(name: "stats") IntelStats? stats,
      @JsonKey(name: "chain") IntelChain? chain,
      @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
      DateTime? createdAt,
      @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
      DateTime? updatedAt,
      @JsonKey(name: "is_native") bool? isNative});

  $IntelStatsCopyWith<$Res>? get stats;
  $IntelChainCopyWith<$Res>? get chain;
}

/// @nodoc
class _$EntityCopyWithImpl<$Res, $Val extends Entity>
    implements $EntityCopyWith<$Res> {
  _$EntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? entityId = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? standard = freezed,
    Object? decimals = freezed,
    Object? contractAddress = freezed,
    Object? logo = freezed,
    Object? stats = freezed,
    Object? chain = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isNative = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      standard: freezed == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      contractAddress: freezed == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as IntelStats?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as IntelChain?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isNative: freezed == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $IntelStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntelChainCopyWith<$Res>? get chain {
    if (_value.chain == null) {
      return null;
    }

    return $IntelChainCopyWith<$Res>(_value.chain!, (value) {
      return _then(_value.copyWith(chain: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntityImplCopyWith<$Res> implements $EntityCopyWith<$Res> {
  factory _$$EntityImplCopyWith(
          _$EntityImpl value, $Res Function(_$EntityImpl) then) =
      __$$EntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: "entity_id") String? entityId,
      String? name,
      String? symbol,
      String? standard,
      int? decimals,
      @JsonKey(name: "contract_address") String? contractAddress,
      String? logo,
      @JsonKey(name: "stats") IntelStats? stats,
      @JsonKey(name: "chain") IntelChain? chain,
      @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
      DateTime? createdAt,
      @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
      DateTime? updatedAt,
      @JsonKey(name: "is_native") bool? isNative});

  @override
  $IntelStatsCopyWith<$Res>? get stats;
  @override
  $IntelChainCopyWith<$Res>? get chain;
}

/// @nodoc
class __$$EntityImplCopyWithImpl<$Res>
    extends _$EntityCopyWithImpl<$Res, _$EntityImpl>
    implements _$$EntityImplCopyWith<$Res> {
  __$$EntityImplCopyWithImpl(
      _$EntityImpl _value, $Res Function(_$EntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? entityId = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? standard = freezed,
    Object? decimals = freezed,
    Object? contractAddress = freezed,
    Object? logo = freezed,
    Object? stats = freezed,
    Object? chain = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isNative = freezed,
  }) {
    return _then(_$EntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      standard: freezed == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      contractAddress: freezed == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as IntelStats?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as IntelChain?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isNative: freezed == isNative
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntityImpl extends _Entity with DiagnosticableTreeMixin {
  const _$EntityImpl(
      {this.id,
      @JsonKey(name: "entity_id") this.entityId,
      this.name,
      this.symbol,
      this.standard,
      this.decimals,
      @JsonKey(name: "contract_address") this.contractAddress,
      this.logo,
      @JsonKey(name: "stats") this.stats,
      @JsonKey(name: "chain") this.chain,
      @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
      this.createdAt,
      @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
      this.updatedAt,
      @JsonKey(name: "is_native") this.isNative})
      : super._();

  factory _$EntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntityImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: "entity_id")
  final String? entityId;
  @override
  final String? name;
  @override
  final String? symbol;
  @override
  final String? standard;
  @override
  final int? decimals;
  @override
  @JsonKey(name: "contract_address")
  final String? contractAddress;
  @override
  final String? logo;
  @override
  @JsonKey(name: "stats")
  final IntelStats? stats;
  @override
  @JsonKey(name: "chain")
  final IntelChain? chain;
  @override
  @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: "is_native")
  final bool? isNative;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Entity(id: $id, entityId: $entityId, name: $name, symbol: $symbol, standard: $standard, decimals: $decimals, contractAddress: $contractAddress, logo: $logo, stats: $stats, chain: $chain, createdAt: $createdAt, updatedAt: $updatedAt, isNative: $isNative)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Entity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('entityId', entityId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('symbol', symbol))
      ..add(DiagnosticsProperty('standard', standard))
      ..add(DiagnosticsProperty('decimals', decimals))
      ..add(DiagnosticsProperty('contractAddress', contractAddress))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('stats', stats))
      ..add(DiagnosticsProperty('chain', chain))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('isNative', isNative));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.standard, standard) ||
                other.standard == standard) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.contractAddress, contractAddress) ||
                other.contractAddress == contractAddress) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.chain, chain) || other.chain == chain) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isNative, isNative) ||
                other.isNative == isNative));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      entityId,
      name,
      symbol,
      standard,
      decimals,
      contractAddress,
      logo,
      stats,
      chain,
      createdAt,
      updatedAt,
      isNative);

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityImplCopyWith<_$EntityImpl> get copyWith =>
      __$$EntityImplCopyWithImpl<_$EntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntityImplToJson(
      this,
    );
  }
}

abstract class _Entity extends Entity {
  const factory _Entity(
      {final String? id,
      @JsonKey(name: "entity_id") final String? entityId,
      final String? name,
      final String? symbol,
      final String? standard,
      final int? decimals,
      @JsonKey(name: "contract_address") final String? contractAddress,
      final String? logo,
      @JsonKey(name: "stats") final IntelStats? stats,
      @JsonKey(name: "chain") final IntelChain? chain,
      @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
      final DateTime? createdAt,
      @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
      final DateTime? updatedAt,
      @JsonKey(name: "is_native") final bool? isNative}) = _$EntityImpl;
  const _Entity._() : super._();

  factory _Entity.fromJson(Map<String, dynamic> json) = _$EntityImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: "entity_id")
  String? get entityId;
  @override
  String? get name;
  @override
  String? get symbol;
  @override
  String? get standard;
  @override
  int? get decimals;
  @override
  @JsonKey(name: "contract_address")
  String? get contractAddress;
  @override
  String? get logo;
  @override
  @JsonKey(name: "stats")
  IntelStats? get stats;
  @override
  @JsonKey(name: "chain")
  IntelChain? get chain;
  @override
  @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
  DateTime? get createdAt;
  @override
  @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
  DateTime? get updatedAt;
  @override
  @JsonKey(name: "is_native")
  bool? get isNative;

  /// Create a copy of Entity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntityImplCopyWith<_$EntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
