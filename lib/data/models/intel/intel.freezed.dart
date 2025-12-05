// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntelMessage implements DiagnosticableTreeMixin {

 String? get type; Intel? get data;
/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelMessageCopyWith<IntelMessage> get copyWith => _$IntelMessageCopyWithImpl<IntelMessage>(this as IntelMessage, _$identity);

  /// Serializes this IntelMessage to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelMessage'))
    ..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelMessage(type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $IntelMessageCopyWith<$Res>  {
  factory $IntelMessageCopyWith(IntelMessage value, $Res Function(IntelMessage) _then) = _$IntelMessageCopyWithImpl;
@useResult
$Res call({
 String? type, Intel? data
});


$IntelCopyWith<$Res>? get data;

}
/// @nodoc
class _$IntelMessageCopyWithImpl<$Res>
    implements $IntelMessageCopyWith<$Res> {
  _$IntelMessageCopyWithImpl(this._self, this._then);

  final IntelMessage _self;
  final $Res Function(IntelMessage) _then;

/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Intel?,
  ));
}
/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $IntelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntelMessage].
extension IntelMessagePatterns on IntelMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelMessage value)  $default,){
final _that = this;
switch (_that) {
case _IntelMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelMessage value)?  $default,){
final _that = this;
switch (_that) {
case _IntelMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  Intel? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelMessage() when $default != null:
return $default(_that.type,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  Intel? data)  $default,) {final _that = this;
switch (_that) {
case _IntelMessage():
return $default(_that.type,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  Intel? data)?  $default,) {final _that = this;
switch (_that) {
case _IntelMessage() when $default != null:
return $default(_that.type,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelMessage with DiagnosticableTreeMixin implements IntelMessage {
  const _IntelMessage({this.type, this.data});
  factory _IntelMessage.fromJson(Map<String, dynamic> json) => _$IntelMessageFromJson(json);

@override final  String? type;
@override final  Intel? data;

/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelMessageCopyWith<_IntelMessage> get copyWith => __$IntelMessageCopyWithImpl<_IntelMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelMessageToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelMessage'))
    ..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelMessage(type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class _$IntelMessageCopyWith<$Res> implements $IntelMessageCopyWith<$Res> {
  factory _$IntelMessageCopyWith(_IntelMessage value, $Res Function(_IntelMessage) _then) = __$IntelMessageCopyWithImpl;
@override @useResult
$Res call({
 String? type, Intel? data
});


@override $IntelCopyWith<$Res>? get data;

}
/// @nodoc
class __$IntelMessageCopyWithImpl<$Res>
    implements _$IntelMessageCopyWith<$Res> {
  __$IntelMessageCopyWithImpl(this._self, this._then);

  final _IntelMessage _self;
  final $Res Function(_IntelMessage) _then;

/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? data = freezed,}) {
  return _then(_IntelMessage(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Intel?,
  ));
}

/// Create a copy of IntelMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $IntelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$Intel implements DiagnosticableTreeMixin {

 String? get id;@JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter() DateTime? get publishedAt;@JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter() DateTime? get createdAt;@JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter() List<Multilingual>? get signalTags;@JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter() DateTime? get updatedAt;@JsonKey(name: 'is_valuable') bool? get isValuable;@JsonKey(name: 'token_keys') List<String>? get tokenKeys;// @JsonKey(name: "is_published")
@JsonKey(name: 'source_url') String? get sourceUrl;@JsonKey(name: 'type') String? get type;@MultilingualStringConverter() Multilingual? get title;@MultilingualStringConverter() Multilingual? get content;@JsonKey(name: 'extra_datas') IntelExtraDatas? get extraDatas; List<IntelMedia>? get medias; Analyzed? get analyzed;// double? score,
 List<String>? get tags; List<Entity>? get entities;@JsonKey(name: 'news_logo') String? get newsLogo;@JsonKey(name: 'news_title') Multilingual? get newsTitle;@JsonKey(name: 'analyzed_time') double? get analyzedTime;@JsonKey(name: 'monitor_time') double? get monitorTime;@JsonKey(name: 'ai_agent') AIAgent? get aiAgent;@JsonKey(name: 'author') Author? get author;
/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelCopyWith<Intel> get copyWith => _$IntelCopyWithImpl<Intel>(this as Intel, _$identity);

  /// Serializes this Intel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Intel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('publishedAt', publishedAt))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('signalTags', signalTags))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isValuable', isValuable))..add(DiagnosticsProperty('tokenKeys', tokenKeys))..add(DiagnosticsProperty('sourceUrl', sourceUrl))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('extraDatas', extraDatas))..add(DiagnosticsProperty('medias', medias))..add(DiagnosticsProperty('analyzed', analyzed))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('entities', entities))..add(DiagnosticsProperty('newsLogo', newsLogo))..add(DiagnosticsProperty('newsTitle', newsTitle))..add(DiagnosticsProperty('analyzedTime', analyzedTime))..add(DiagnosticsProperty('monitorTime', monitorTime))..add(DiagnosticsProperty('aiAgent', aiAgent))..add(DiagnosticsProperty('author', author));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intel&&(identical(other.id, id) || other.id == id)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.signalTags, signalTags)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isValuable, isValuable) || other.isValuable == isValuable)&&const DeepCollectionEquality().equals(other.tokenKeys, tokenKeys)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.extraDatas, extraDatas) || other.extraDatas == extraDatas)&&const DeepCollectionEquality().equals(other.medias, medias)&&(identical(other.analyzed, analyzed) || other.analyzed == analyzed)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.entities, entities)&&(identical(other.newsLogo, newsLogo) || other.newsLogo == newsLogo)&&(identical(other.newsTitle, newsTitle) || other.newsTitle == newsTitle)&&(identical(other.analyzedTime, analyzedTime) || other.analyzedTime == analyzedTime)&&(identical(other.monitorTime, monitorTime) || other.monitorTime == monitorTime)&&(identical(other.aiAgent, aiAgent) || other.aiAgent == aiAgent)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,publishedAt,createdAt,const DeepCollectionEquality().hash(signalTags),updatedAt,isValuable,const DeepCollectionEquality().hash(tokenKeys),sourceUrl,type,title,content,extraDatas,const DeepCollectionEquality().hash(medias),analyzed,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(entities),newsLogo,newsTitle,analyzedTime,monitorTime,aiAgent,author]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Intel(id: $id, publishedAt: $publishedAt, createdAt: $createdAt, signalTags: $signalTags, updatedAt: $updatedAt, isValuable: $isValuable, tokenKeys: $tokenKeys, sourceUrl: $sourceUrl, type: $type, title: $title, content: $content, extraDatas: $extraDatas, medias: $medias, analyzed: $analyzed, tags: $tags, entities: $entities, newsLogo: $newsLogo, newsTitle: $newsTitle, analyzedTime: $analyzedTime, monitorTime: $monitorTime, aiAgent: $aiAgent, author: $author)';
}


}

/// @nodoc
abstract mixin class $IntelCopyWith<$Res>  {
  factory $IntelCopyWith(Intel value, $Res Function(Intel) _then) = _$IntelCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter() DateTime? publishedAt,@JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter() DateTime? createdAt,@JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter() List<Multilingual>? signalTags,@JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter() DateTime? updatedAt,@JsonKey(name: 'is_valuable') bool? isValuable,@JsonKey(name: 'token_keys') List<String>? tokenKeys,@JsonKey(name: 'source_url') String? sourceUrl,@JsonKey(name: 'type') String? type,@MultilingualStringConverter() Multilingual? title,@MultilingualStringConverter() Multilingual? content,@JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas, List<IntelMedia>? medias, Analyzed? analyzed, List<String>? tags, List<Entity>? entities,@JsonKey(name: 'news_logo') String? newsLogo,@JsonKey(name: 'news_title') Multilingual? newsTitle,@JsonKey(name: 'analyzed_time') double? analyzedTime,@JsonKey(name: 'monitor_time') double? monitorTime,@JsonKey(name: 'ai_agent') AIAgent? aiAgent,@JsonKey(name: 'author') Author? author
});


$MultilingualCopyWith<$Res>? get title;$MultilingualCopyWith<$Res>? get content;$IntelExtraDatasCopyWith<$Res>? get extraDatas;$AnalyzedCopyWith<$Res>? get analyzed;$MultilingualCopyWith<$Res>? get newsTitle;$AIAgentCopyWith<$Res>? get aiAgent;$AuthorCopyWith<$Res>? get author;

}
/// @nodoc
class _$IntelCopyWithImpl<$Res>
    implements $IntelCopyWith<$Res> {
  _$IntelCopyWithImpl(this._self, this._then);

  final Intel _self;
  final $Res Function(Intel) _then;

/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? publishedAt = freezed,Object? createdAt = freezed,Object? signalTags = freezed,Object? updatedAt = freezed,Object? isValuable = freezed,Object? tokenKeys = freezed,Object? sourceUrl = freezed,Object? type = freezed,Object? title = freezed,Object? content = freezed,Object? extraDatas = freezed,Object? medias = freezed,Object? analyzed = freezed,Object? tags = freezed,Object? entities = freezed,Object? newsLogo = freezed,Object? newsTitle = freezed,Object? analyzedTime = freezed,Object? monitorTime = freezed,Object? aiAgent = freezed,Object? author = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signalTags: freezed == signalTags ? _self.signalTags : signalTags // ignore: cast_nullable_to_non_nullable
as List<Multilingual>?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isValuable: freezed == isValuable ? _self.isValuable : isValuable // ignore: cast_nullable_to_non_nullable
as bool?,tokenKeys: freezed == tokenKeys ? _self.tokenKeys : tokenKeys // ignore: cast_nullable_to_non_nullable
as List<String>?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Multilingual?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Multilingual?,extraDatas: freezed == extraDatas ? _self.extraDatas : extraDatas // ignore: cast_nullable_to_non_nullable
as IntelExtraDatas?,medias: freezed == medias ? _self.medias : medias // ignore: cast_nullable_to_non_nullable
as List<IntelMedia>?,analyzed: freezed == analyzed ? _self.analyzed : analyzed // ignore: cast_nullable_to_non_nullable
as Analyzed?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,entities: freezed == entities ? _self.entities : entities // ignore: cast_nullable_to_non_nullable
as List<Entity>?,newsLogo: freezed == newsLogo ? _self.newsLogo : newsLogo // ignore: cast_nullable_to_non_nullable
as String?,newsTitle: freezed == newsTitle ? _self.newsTitle : newsTitle // ignore: cast_nullable_to_non_nullable
as Multilingual?,analyzedTime: freezed == analyzedTime ? _self.analyzedTime : analyzedTime // ignore: cast_nullable_to_non_nullable
as double?,monitorTime: freezed == monitorTime ? _self.monitorTime : monitorTime // ignore: cast_nullable_to_non_nullable
as double?,aiAgent: freezed == aiAgent ? _self.aiAgent : aiAgent // ignore: cast_nullable_to_non_nullable
as AIAgent?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,
  ));
}
/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelExtraDatasCopyWith<$Res>? get extraDatas {
    if (_self.extraDatas == null) {
    return null;
  }

  return $IntelExtraDatasCopyWith<$Res>(_self.extraDatas!, (value) {
    return _then(_self.copyWith(extraDatas: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnalyzedCopyWith<$Res>? get analyzed {
    if (_self.analyzed == null) {
    return null;
  }

  return $AnalyzedCopyWith<$Res>(_self.analyzed!, (value) {
    return _then(_self.copyWith(analyzed: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get newsTitle {
    if (_self.newsTitle == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.newsTitle!, (value) {
    return _then(_self.copyWith(newsTitle: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAgentCopyWith<$Res>? get aiAgent {
    if (_self.aiAgent == null) {
    return null;
  }

  return $AIAgentCopyWith<$Res>(_self.aiAgent!, (value) {
    return _then(_self.copyWith(aiAgent: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Intel].
extension IntelPatterns on Intel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Intel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Intel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Intel value)  $default,){
final _that = this;
switch (_that) {
case _Intel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Intel value)?  $default,){
final _that = this;
switch (_that) {
case _Intel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter()  DateTime? publishedAt, @JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter()  DateTime? createdAt, @JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter()  List<Multilingual>? signalTags, @JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter()  DateTime? updatedAt, @JsonKey(name: 'is_valuable')  bool? isValuable, @JsonKey(name: 'token_keys')  List<String>? tokenKeys, @JsonKey(name: 'source_url')  String? sourceUrl, @JsonKey(name: 'type')  String? type, @MultilingualStringConverter()  Multilingual? title, @MultilingualStringConverter()  Multilingual? content, @JsonKey(name: 'extra_datas')  IntelExtraDatas? extraDatas,  List<IntelMedia>? medias,  Analyzed? analyzed,  List<String>? tags,  List<Entity>? entities, @JsonKey(name: 'news_logo')  String? newsLogo, @JsonKey(name: 'news_title')  Multilingual? newsTitle, @JsonKey(name: 'analyzed_time')  double? analyzedTime, @JsonKey(name: 'monitor_time')  double? monitorTime, @JsonKey(name: 'ai_agent')  AIAgent? aiAgent, @JsonKey(name: 'author')  Author? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Intel() when $default != null:
return $default(_that.id,_that.publishedAt,_that.createdAt,_that.signalTags,_that.updatedAt,_that.isValuable,_that.tokenKeys,_that.sourceUrl,_that.type,_that.title,_that.content,_that.extraDatas,_that.medias,_that.analyzed,_that.tags,_that.entities,_that.newsLogo,_that.newsTitle,_that.analyzedTime,_that.monitorTime,_that.aiAgent,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter()  DateTime? publishedAt, @JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter()  DateTime? createdAt, @JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter()  List<Multilingual>? signalTags, @JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter()  DateTime? updatedAt, @JsonKey(name: 'is_valuable')  bool? isValuable, @JsonKey(name: 'token_keys')  List<String>? tokenKeys, @JsonKey(name: 'source_url')  String? sourceUrl, @JsonKey(name: 'type')  String? type, @MultilingualStringConverter()  Multilingual? title, @MultilingualStringConverter()  Multilingual? content, @JsonKey(name: 'extra_datas')  IntelExtraDatas? extraDatas,  List<IntelMedia>? medias,  Analyzed? analyzed,  List<String>? tags,  List<Entity>? entities, @JsonKey(name: 'news_logo')  String? newsLogo, @JsonKey(name: 'news_title')  Multilingual? newsTitle, @JsonKey(name: 'analyzed_time')  double? analyzedTime, @JsonKey(name: 'monitor_time')  double? monitorTime, @JsonKey(name: 'ai_agent')  AIAgent? aiAgent, @JsonKey(name: 'author')  Author? author)  $default,) {final _that = this;
switch (_that) {
case _Intel():
return $default(_that.id,_that.publishedAt,_that.createdAt,_that.signalTags,_that.updatedAt,_that.isValuable,_that.tokenKeys,_that.sourceUrl,_that.type,_that.title,_that.content,_that.extraDatas,_that.medias,_that.analyzed,_that.tags,_that.entities,_that.newsLogo,_that.newsTitle,_that.analyzedTime,_that.monitorTime,_that.aiAgent,_that.author);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter()  DateTime? publishedAt, @JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter()  DateTime? createdAt, @JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter()  List<Multilingual>? signalTags, @JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter()  DateTime? updatedAt, @JsonKey(name: 'is_valuable')  bool? isValuable, @JsonKey(name: 'token_keys')  List<String>? tokenKeys, @JsonKey(name: 'source_url')  String? sourceUrl, @JsonKey(name: 'type')  String? type, @MultilingualStringConverter()  Multilingual? title, @MultilingualStringConverter()  Multilingual? content, @JsonKey(name: 'extra_datas')  IntelExtraDatas? extraDatas,  List<IntelMedia>? medias,  Analyzed? analyzed,  List<String>? tags,  List<Entity>? entities, @JsonKey(name: 'news_logo')  String? newsLogo, @JsonKey(name: 'news_title')  Multilingual? newsTitle, @JsonKey(name: 'analyzed_time')  double? analyzedTime, @JsonKey(name: 'monitor_time')  double? monitorTime, @JsonKey(name: 'ai_agent')  AIAgent? aiAgent, @JsonKey(name: 'author')  Author? author)?  $default,) {final _that = this;
switch (_that) {
case _Intel() when $default != null:
return $default(_that.id,_that.publishedAt,_that.createdAt,_that.signalTags,_that.updatedAt,_that.isValuable,_that.tokenKeys,_that.sourceUrl,_that.type,_that.title,_that.content,_that.extraDatas,_that.medias,_that.analyzed,_that.tags,_that.entities,_that.newsLogo,_that.newsTitle,_that.analyzedTime,_that.monitorTime,_that.aiAgent,_that.author);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Intel extends Intel with DiagnosticableTreeMixin {
  const _Intel({this.id, @JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter() this.publishedAt, @JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter() this.createdAt, @JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter() final  List<Multilingual>? signalTags, @JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter() this.updatedAt, @JsonKey(name: 'is_valuable') this.isValuable, @JsonKey(name: 'token_keys') final  List<String>? tokenKeys, @JsonKey(name: 'source_url') this.sourceUrl, @JsonKey(name: 'type') this.type, @MultilingualStringConverter() this.title, @MultilingualStringConverter() this.content, @JsonKey(name: 'extra_datas') this.extraDatas, final  List<IntelMedia>? medias, this.analyzed, final  List<String>? tags, final  List<Entity>? entities, @JsonKey(name: 'news_logo') this.newsLogo, @JsonKey(name: 'news_title') this.newsTitle, @JsonKey(name: 'analyzed_time') this.analyzedTime, @JsonKey(name: 'monitor_time') this.monitorTime, @JsonKey(name: 'ai_agent') this.aiAgent, @JsonKey(name: 'author') this.author}): _signalTags = signalTags,_tokenKeys = tokenKeys,_medias = medias,_tags = tags,_entities = entities,super._();
  factory _Intel.fromJson(Map<String, dynamic> json) => _$IntelFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter() final  DateTime? publishedAt;
@override@JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter() final  DateTime? createdAt;
 final  List<Multilingual>? _signalTags;
@override@JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter() List<Multilingual>? get signalTags {
  final value = _signalTags;
  if (value == null) return null;
  if (_signalTags is EqualUnmodifiableListView) return _signalTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter() final  DateTime? updatedAt;
@override@JsonKey(name: 'is_valuable') final  bool? isValuable;
 final  List<String>? _tokenKeys;
@override@JsonKey(name: 'token_keys') List<String>? get tokenKeys {
  final value = _tokenKeys;
  if (value == null) return null;
  if (_tokenKeys is EqualUnmodifiableListView) return _tokenKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// @JsonKey(name: "is_published")
@override@JsonKey(name: 'source_url') final  String? sourceUrl;
@override@JsonKey(name: 'type') final  String? type;
@override@MultilingualStringConverter() final  Multilingual? title;
@override@MultilingualStringConverter() final  Multilingual? content;
@override@JsonKey(name: 'extra_datas') final  IntelExtraDatas? extraDatas;
 final  List<IntelMedia>? _medias;
@override List<IntelMedia>? get medias {
  final value = _medias;
  if (value == null) return null;
  if (_medias is EqualUnmodifiableListView) return _medias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Analyzed? analyzed;
// double? score,
 final  List<String>? _tags;
// double? score,
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Entity>? _entities;
@override List<Entity>? get entities {
  final value = _entities;
  if (value == null) return null;
  if (_entities is EqualUnmodifiableListView) return _entities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'news_logo') final  String? newsLogo;
@override@JsonKey(name: 'news_title') final  Multilingual? newsTitle;
@override@JsonKey(name: 'analyzed_time') final  double? analyzedTime;
@override@JsonKey(name: 'monitor_time') final  double? monitorTime;
@override@JsonKey(name: 'ai_agent') final  AIAgent? aiAgent;
@override@JsonKey(name: 'author') final  Author? author;

/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelCopyWith<_Intel> get copyWith => __$IntelCopyWithImpl<_Intel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Intel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('publishedAt', publishedAt))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('signalTags', signalTags))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isValuable', isValuable))..add(DiagnosticsProperty('tokenKeys', tokenKeys))..add(DiagnosticsProperty('sourceUrl', sourceUrl))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('extraDatas', extraDatas))..add(DiagnosticsProperty('medias', medias))..add(DiagnosticsProperty('analyzed', analyzed))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('entities', entities))..add(DiagnosticsProperty('newsLogo', newsLogo))..add(DiagnosticsProperty('newsTitle', newsTitle))..add(DiagnosticsProperty('analyzedTime', analyzedTime))..add(DiagnosticsProperty('monitorTime', monitorTime))..add(DiagnosticsProperty('aiAgent', aiAgent))..add(DiagnosticsProperty('author', author));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intel&&(identical(other.id, id) || other.id == id)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._signalTags, _signalTags)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isValuable, isValuable) || other.isValuable == isValuable)&&const DeepCollectionEquality().equals(other._tokenKeys, _tokenKeys)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.extraDatas, extraDatas) || other.extraDatas == extraDatas)&&const DeepCollectionEquality().equals(other._medias, _medias)&&(identical(other.analyzed, analyzed) || other.analyzed == analyzed)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._entities, _entities)&&(identical(other.newsLogo, newsLogo) || other.newsLogo == newsLogo)&&(identical(other.newsTitle, newsTitle) || other.newsTitle == newsTitle)&&(identical(other.analyzedTime, analyzedTime) || other.analyzedTime == analyzedTime)&&(identical(other.monitorTime, monitorTime) || other.monitorTime == monitorTime)&&(identical(other.aiAgent, aiAgent) || other.aiAgent == aiAgent)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,publishedAt,createdAt,const DeepCollectionEquality().hash(_signalTags),updatedAt,isValuable,const DeepCollectionEquality().hash(_tokenKeys),sourceUrl,type,title,content,extraDatas,const DeepCollectionEquality().hash(_medias),analyzed,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_entities),newsLogo,newsTitle,analyzedTime,monitorTime,aiAgent,author]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Intel(id: $id, publishedAt: $publishedAt, createdAt: $createdAt, signalTags: $signalTags, updatedAt: $updatedAt, isValuable: $isValuable, tokenKeys: $tokenKeys, sourceUrl: $sourceUrl, type: $type, title: $title, content: $content, extraDatas: $extraDatas, medias: $medias, analyzed: $analyzed, tags: $tags, entities: $entities, newsLogo: $newsLogo, newsTitle: $newsTitle, analyzedTime: $analyzedTime, monitorTime: $monitorTime, aiAgent: $aiAgent, author: $author)';
}


}

/// @nodoc
abstract mixin class _$IntelCopyWith<$Res> implements $IntelCopyWith<$Res> {
  factory _$IntelCopyWith(_Intel value, $Res Function(_Intel) _then) = __$IntelCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'published_at')@NaiveToUtcDateTimeConverter() DateTime? publishedAt,@JsonKey(name: 'created_at')@NaiveToUtcDateTimeConverter() DateTime? createdAt,@JsonKey(name: 'signal_tags', fromJson: multilingualListFromJson, toJson: multilingualListToJson)@MultilingualListConverter() List<Multilingual>? signalTags,@JsonKey(name: 'updated_at')@NaiveToUtcDateTimeConverter() DateTime? updatedAt,@JsonKey(name: 'is_valuable') bool? isValuable,@JsonKey(name: 'token_keys') List<String>? tokenKeys,@JsonKey(name: 'source_url') String? sourceUrl,@JsonKey(name: 'type') String? type,@MultilingualStringConverter() Multilingual? title,@MultilingualStringConverter() Multilingual? content,@JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas, List<IntelMedia>? medias, Analyzed? analyzed, List<String>? tags, List<Entity>? entities,@JsonKey(name: 'news_logo') String? newsLogo,@JsonKey(name: 'news_title') Multilingual? newsTitle,@JsonKey(name: 'analyzed_time') double? analyzedTime,@JsonKey(name: 'monitor_time') double? monitorTime,@JsonKey(name: 'ai_agent') AIAgent? aiAgent,@JsonKey(name: 'author') Author? author
});


@override $MultilingualCopyWith<$Res>? get title;@override $MultilingualCopyWith<$Res>? get content;@override $IntelExtraDatasCopyWith<$Res>? get extraDatas;@override $AnalyzedCopyWith<$Res>? get analyzed;@override $MultilingualCopyWith<$Res>? get newsTitle;@override $AIAgentCopyWith<$Res>? get aiAgent;@override $AuthorCopyWith<$Res>? get author;

}
/// @nodoc
class __$IntelCopyWithImpl<$Res>
    implements _$IntelCopyWith<$Res> {
  __$IntelCopyWithImpl(this._self, this._then);

  final _Intel _self;
  final $Res Function(_Intel) _then;

/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? publishedAt = freezed,Object? createdAt = freezed,Object? signalTags = freezed,Object? updatedAt = freezed,Object? isValuable = freezed,Object? tokenKeys = freezed,Object? sourceUrl = freezed,Object? type = freezed,Object? title = freezed,Object? content = freezed,Object? extraDatas = freezed,Object? medias = freezed,Object? analyzed = freezed,Object? tags = freezed,Object? entities = freezed,Object? newsLogo = freezed,Object? newsTitle = freezed,Object? analyzedTime = freezed,Object? monitorTime = freezed,Object? aiAgent = freezed,Object? author = freezed,}) {
  return _then(_Intel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signalTags: freezed == signalTags ? _self._signalTags : signalTags // ignore: cast_nullable_to_non_nullable
as List<Multilingual>?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isValuable: freezed == isValuable ? _self.isValuable : isValuable // ignore: cast_nullable_to_non_nullable
as bool?,tokenKeys: freezed == tokenKeys ? _self._tokenKeys : tokenKeys // ignore: cast_nullable_to_non_nullable
as List<String>?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Multilingual?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Multilingual?,extraDatas: freezed == extraDatas ? _self.extraDatas : extraDatas // ignore: cast_nullable_to_non_nullable
as IntelExtraDatas?,medias: freezed == medias ? _self._medias : medias // ignore: cast_nullable_to_non_nullable
as List<IntelMedia>?,analyzed: freezed == analyzed ? _self.analyzed : analyzed // ignore: cast_nullable_to_non_nullable
as Analyzed?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,entities: freezed == entities ? _self._entities : entities // ignore: cast_nullable_to_non_nullable
as List<Entity>?,newsLogo: freezed == newsLogo ? _self.newsLogo : newsLogo // ignore: cast_nullable_to_non_nullable
as String?,newsTitle: freezed == newsTitle ? _self.newsTitle : newsTitle // ignore: cast_nullable_to_non_nullable
as Multilingual?,analyzedTime: freezed == analyzedTime ? _self.analyzedTime : analyzedTime // ignore: cast_nullable_to_non_nullable
as double?,monitorTime: freezed == monitorTime ? _self.monitorTime : monitorTime // ignore: cast_nullable_to_non_nullable
as double?,aiAgent: freezed == aiAgent ? _self.aiAgent : aiAgent // ignore: cast_nullable_to_non_nullable
as AIAgent?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,
  ));
}

/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelExtraDatasCopyWith<$Res>? get extraDatas {
    if (_self.extraDatas == null) {
    return null;
  }

  return $IntelExtraDatasCopyWith<$Res>(_self.extraDatas!, (value) {
    return _then(_self.copyWith(extraDatas: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnalyzedCopyWith<$Res>? get analyzed {
    if (_self.analyzed == null) {
    return null;
  }

  return $AnalyzedCopyWith<$Res>(_self.analyzed!, (value) {
    return _then(_self.copyWith(analyzed: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get newsTitle {
    if (_self.newsTitle == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.newsTitle!, (value) {
    return _then(_self.copyWith(newsTitle: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAgentCopyWith<$Res>? get aiAgent {
    if (_self.aiAgent == null) {
    return null;
  }

  return $AIAgentCopyWith<$Res>(_self.aiAgent!, (value) {
    return _then(_self.copyWith(aiAgent: value));
  });
}/// Create a copy of Intel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$IntelExtraDatas implements DiagnosticableTreeMixin {

@JsonKey(name: 'is_alpha') bool? get isAlpha;
/// Create a copy of IntelExtraDatas
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelExtraDatasCopyWith<IntelExtraDatas> get copyWith => _$IntelExtraDatasCopyWithImpl<IntelExtraDatas>(this as IntelExtraDatas, _$identity);

  /// Serializes this IntelExtraDatas to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelExtraDatas'))
    ..add(DiagnosticsProperty('isAlpha', isAlpha));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelExtraDatas&&(identical(other.isAlpha, isAlpha) || other.isAlpha == isAlpha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAlpha);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelExtraDatas(isAlpha: $isAlpha)';
}


}

/// @nodoc
abstract mixin class $IntelExtraDatasCopyWith<$Res>  {
  factory $IntelExtraDatasCopyWith(IntelExtraDatas value, $Res Function(IntelExtraDatas) _then) = _$IntelExtraDatasCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_alpha') bool? isAlpha
});




}
/// @nodoc
class _$IntelExtraDatasCopyWithImpl<$Res>
    implements $IntelExtraDatasCopyWith<$Res> {
  _$IntelExtraDatasCopyWithImpl(this._self, this._then);

  final IntelExtraDatas _self;
  final $Res Function(IntelExtraDatas) _then;

/// Create a copy of IntelExtraDatas
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAlpha = freezed,}) {
  return _then(_self.copyWith(
isAlpha: freezed == isAlpha ? _self.isAlpha : isAlpha // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelExtraDatas].
extension IntelExtraDatasPatterns on IntelExtraDatas {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelExtraDatas value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelExtraDatas() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelExtraDatas value)  $default,){
final _that = this;
switch (_that) {
case _IntelExtraDatas():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelExtraDatas value)?  $default,){
final _that = this;
switch (_that) {
case _IntelExtraDatas() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_alpha')  bool? isAlpha)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelExtraDatas() when $default != null:
return $default(_that.isAlpha);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_alpha')  bool? isAlpha)  $default,) {final _that = this;
switch (_that) {
case _IntelExtraDatas():
return $default(_that.isAlpha);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_alpha')  bool? isAlpha)?  $default,) {final _that = this;
switch (_that) {
case _IntelExtraDatas() when $default != null:
return $default(_that.isAlpha);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelExtraDatas with DiagnosticableTreeMixin implements IntelExtraDatas {
  const _IntelExtraDatas({@JsonKey(name: 'is_alpha') this.isAlpha = false});
  factory _IntelExtraDatas.fromJson(Map<String, dynamic> json) => _$IntelExtraDatasFromJson(json);

@override@JsonKey(name: 'is_alpha') final  bool? isAlpha;

/// Create a copy of IntelExtraDatas
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelExtraDatasCopyWith<_IntelExtraDatas> get copyWith => __$IntelExtraDatasCopyWithImpl<_IntelExtraDatas>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelExtraDatasToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelExtraDatas'))
    ..add(DiagnosticsProperty('isAlpha', isAlpha));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelExtraDatas&&(identical(other.isAlpha, isAlpha) || other.isAlpha == isAlpha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAlpha);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelExtraDatas(isAlpha: $isAlpha)';
}


}

/// @nodoc
abstract mixin class _$IntelExtraDatasCopyWith<$Res> implements $IntelExtraDatasCopyWith<$Res> {
  factory _$IntelExtraDatasCopyWith(_IntelExtraDatas value, $Res Function(_IntelExtraDatas) _then) = __$IntelExtraDatasCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_alpha') bool? isAlpha
});




}
/// @nodoc
class __$IntelExtraDatasCopyWithImpl<$Res>
    implements _$IntelExtraDatasCopyWith<$Res> {
  __$IntelExtraDatasCopyWithImpl(this._self, this._then);

  final _IntelExtraDatas _self;
  final $Res Function(_IntelExtraDatas) _then;

/// Create a copy of IntelExtraDatas
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAlpha = freezed,}) {
  return _then(_IntelExtraDatas(
isAlpha: freezed == isAlpha ? _self.isAlpha : isAlpha // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$IntelStats implements DiagnosticableTreeMixin {

@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic) String? get warningPriceUsd;@JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic) String? get warningMarketCap;@JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic) String? get currentPriceUsd;@JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic) String? get currentMarketCap;@JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic) String? get increaseRate;@JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic) String? get heighestIncreaseRate;@JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic) String? get highestDecreaseRate;
/// Create a copy of IntelStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelStatsCopyWith<IntelStats> get copyWith => _$IntelStatsCopyWithImpl<IntelStats>(this as IntelStats, _$identity);

  /// Serializes this IntelStats to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelStats'))
    ..add(DiagnosticsProperty('warningPriceUsd', warningPriceUsd))..add(DiagnosticsProperty('warningMarketCap', warningMarketCap))..add(DiagnosticsProperty('currentPriceUsd', currentPriceUsd))..add(DiagnosticsProperty('currentMarketCap', currentMarketCap))..add(DiagnosticsProperty('increaseRate', increaseRate))..add(DiagnosticsProperty('heighestIncreaseRate', heighestIncreaseRate))..add(DiagnosticsProperty('highestDecreaseRate', highestDecreaseRate));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelStats&&(identical(other.warningPriceUsd, warningPriceUsd) || other.warningPriceUsd == warningPriceUsd)&&(identical(other.warningMarketCap, warningMarketCap) || other.warningMarketCap == warningMarketCap)&&(identical(other.currentPriceUsd, currentPriceUsd) || other.currentPriceUsd == currentPriceUsd)&&(identical(other.currentMarketCap, currentMarketCap) || other.currentMarketCap == currentMarketCap)&&(identical(other.increaseRate, increaseRate) || other.increaseRate == increaseRate)&&(identical(other.heighestIncreaseRate, heighestIncreaseRate) || other.heighestIncreaseRate == heighestIncreaseRate)&&(identical(other.highestDecreaseRate, highestDecreaseRate) || other.highestDecreaseRate == highestDecreaseRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,warningPriceUsd,warningMarketCap,currentPriceUsd,currentMarketCap,increaseRate,heighestIncreaseRate,highestDecreaseRate);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelStats(warningPriceUsd: $warningPriceUsd, warningMarketCap: $warningMarketCap, currentPriceUsd: $currentPriceUsd, currentMarketCap: $currentMarketCap, increaseRate: $increaseRate, heighestIncreaseRate: $heighestIncreaseRate, highestDecreaseRate: $highestDecreaseRate)';
}


}

/// @nodoc
abstract mixin class $IntelStatsCopyWith<$Res>  {
  factory $IntelStatsCopyWith(IntelStats value, $Res Function(IntelStats) _then) = _$IntelStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic) String? warningPriceUsd,@JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic) String? warningMarketCap,@JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic) String? currentPriceUsd,@JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic) String? currentMarketCap,@JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic) String? increaseRate,@JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic) String? heighestIncreaseRate,@JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic) String? highestDecreaseRate
});




}
/// @nodoc
class _$IntelStatsCopyWithImpl<$Res>
    implements $IntelStatsCopyWith<$Res> {
  _$IntelStatsCopyWithImpl(this._self, this._then);

  final IntelStats _self;
  final $Res Function(IntelStats) _then;

/// Create a copy of IntelStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? warningPriceUsd = freezed,Object? warningMarketCap = freezed,Object? currentPriceUsd = freezed,Object? currentMarketCap = freezed,Object? increaseRate = freezed,Object? heighestIncreaseRate = freezed,Object? highestDecreaseRate = freezed,}) {
  return _then(_self.copyWith(
warningPriceUsd: freezed == warningPriceUsd ? _self.warningPriceUsd : warningPriceUsd // ignore: cast_nullable_to_non_nullable
as String?,warningMarketCap: freezed == warningMarketCap ? _self.warningMarketCap : warningMarketCap // ignore: cast_nullable_to_non_nullable
as String?,currentPriceUsd: freezed == currentPriceUsd ? _self.currentPriceUsd : currentPriceUsd // ignore: cast_nullable_to_non_nullable
as String?,currentMarketCap: freezed == currentMarketCap ? _self.currentMarketCap : currentMarketCap // ignore: cast_nullable_to_non_nullable
as String?,increaseRate: freezed == increaseRate ? _self.increaseRate : increaseRate // ignore: cast_nullable_to_non_nullable
as String?,heighestIncreaseRate: freezed == heighestIncreaseRate ? _self.heighestIncreaseRate : heighestIncreaseRate // ignore: cast_nullable_to_non_nullable
as String?,highestDecreaseRate: freezed == highestDecreaseRate ? _self.highestDecreaseRate : highestDecreaseRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelStats].
extension IntelStatsPatterns on IntelStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelStats value)  $default,){
final _that = this;
switch (_that) {
case _IntelStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelStats value)?  $default,){
final _that = this;
switch (_that) {
case _IntelStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic)  String? warningPriceUsd, @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic)  String? warningMarketCap, @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic)  String? currentPriceUsd, @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic)  String? currentMarketCap, @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic)  String? increaseRate, @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic)  String? heighestIncreaseRate, @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic)  String? highestDecreaseRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelStats() when $default != null:
return $default(_that.warningPriceUsd,_that.warningMarketCap,_that.currentPriceUsd,_that.currentMarketCap,_that.increaseRate,_that.heighestIncreaseRate,_that.highestDecreaseRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic)  String? warningPriceUsd, @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic)  String? warningMarketCap, @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic)  String? currentPriceUsd, @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic)  String? currentMarketCap, @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic)  String? increaseRate, @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic)  String? heighestIncreaseRate, @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic)  String? highestDecreaseRate)  $default,) {final _that = this;
switch (_that) {
case _IntelStats():
return $default(_that.warningPriceUsd,_that.warningMarketCap,_that.currentPriceUsd,_that.currentMarketCap,_that.increaseRate,_that.heighestIncreaseRate,_that.highestDecreaseRate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic)  String? warningPriceUsd, @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic)  String? warningMarketCap, @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic)  String? currentPriceUsd, @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic)  String? currentMarketCap, @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic)  String? increaseRate, @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic)  String? heighestIncreaseRate, @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic)  String? highestDecreaseRate)?  $default,) {final _that = this;
switch (_that) {
case _IntelStats() when $default != null:
return $default(_that.warningPriceUsd,_that.warningMarketCap,_that.currentPriceUsd,_that.currentMarketCap,_that.increaseRate,_that.heighestIncreaseRate,_that.highestDecreaseRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelStats with DiagnosticableTreeMixin implements IntelStats {
  const _IntelStats({@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic) this.warningPriceUsd, @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic) this.warningMarketCap, @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic) this.currentPriceUsd, @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic) this.currentMarketCap, @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic) this.increaseRate, @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic) this.heighestIncreaseRate, @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic) this.highestDecreaseRate});
  factory _IntelStats.fromJson(Map<String, dynamic> json) => _$IntelStatsFromJson(json);

@override@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic) final  String? warningPriceUsd;
@override@JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic) final  String? warningMarketCap;
@override@JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic) final  String? currentPriceUsd;
@override@JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic) final  String? currentMarketCap;
@override@JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic) final  String? increaseRate;
@override@JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic) final  String? heighestIncreaseRate;
@override@JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic) final  String? highestDecreaseRate;

/// Create a copy of IntelStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelStatsCopyWith<_IntelStats> get copyWith => __$IntelStatsCopyWithImpl<_IntelStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelStatsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelStats'))
    ..add(DiagnosticsProperty('warningPriceUsd', warningPriceUsd))..add(DiagnosticsProperty('warningMarketCap', warningMarketCap))..add(DiagnosticsProperty('currentPriceUsd', currentPriceUsd))..add(DiagnosticsProperty('currentMarketCap', currentMarketCap))..add(DiagnosticsProperty('increaseRate', increaseRate))..add(DiagnosticsProperty('heighestIncreaseRate', heighestIncreaseRate))..add(DiagnosticsProperty('highestDecreaseRate', highestDecreaseRate));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelStats&&(identical(other.warningPriceUsd, warningPriceUsd) || other.warningPriceUsd == warningPriceUsd)&&(identical(other.warningMarketCap, warningMarketCap) || other.warningMarketCap == warningMarketCap)&&(identical(other.currentPriceUsd, currentPriceUsd) || other.currentPriceUsd == currentPriceUsd)&&(identical(other.currentMarketCap, currentMarketCap) || other.currentMarketCap == currentMarketCap)&&(identical(other.increaseRate, increaseRate) || other.increaseRate == increaseRate)&&(identical(other.heighestIncreaseRate, heighestIncreaseRate) || other.heighestIncreaseRate == heighestIncreaseRate)&&(identical(other.highestDecreaseRate, highestDecreaseRate) || other.highestDecreaseRate == highestDecreaseRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,warningPriceUsd,warningMarketCap,currentPriceUsd,currentMarketCap,increaseRate,heighestIncreaseRate,highestDecreaseRate);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelStats(warningPriceUsd: $warningPriceUsd, warningMarketCap: $warningMarketCap, currentPriceUsd: $currentPriceUsd, currentMarketCap: $currentMarketCap, increaseRate: $increaseRate, heighestIncreaseRate: $heighestIncreaseRate, highestDecreaseRate: $highestDecreaseRate)';
}


}

/// @nodoc
abstract mixin class _$IntelStatsCopyWith<$Res> implements $IntelStatsCopyWith<$Res> {
  factory _$IntelStatsCopyWith(_IntelStats value, $Res Function(_IntelStats) _then) = __$IntelStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic) String? warningPriceUsd,@JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic) String? warningMarketCap,@JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic) String? currentPriceUsd,@JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic) String? currentMarketCap,@JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic) String? increaseRate,@JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic) String? heighestIncreaseRate,@JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic) String? highestDecreaseRate
});




}
/// @nodoc
class __$IntelStatsCopyWithImpl<$Res>
    implements _$IntelStatsCopyWith<$Res> {
  __$IntelStatsCopyWithImpl(this._self, this._then);

  final _IntelStats _self;
  final $Res Function(_IntelStats) _then;

/// Create a copy of IntelStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? warningPriceUsd = freezed,Object? warningMarketCap = freezed,Object? currentPriceUsd = freezed,Object? currentMarketCap = freezed,Object? increaseRate = freezed,Object? heighestIncreaseRate = freezed,Object? highestDecreaseRate = freezed,}) {
  return _then(_IntelStats(
warningPriceUsd: freezed == warningPriceUsd ? _self.warningPriceUsd : warningPriceUsd // ignore: cast_nullable_to_non_nullable
as String?,warningMarketCap: freezed == warningMarketCap ? _self.warningMarketCap : warningMarketCap // ignore: cast_nullable_to_non_nullable
as String?,currentPriceUsd: freezed == currentPriceUsd ? _self.currentPriceUsd : currentPriceUsd // ignore: cast_nullable_to_non_nullable
as String?,currentMarketCap: freezed == currentMarketCap ? _self.currentMarketCap : currentMarketCap // ignore: cast_nullable_to_non_nullable
as String?,increaseRate: freezed == increaseRate ? _self.increaseRate : increaseRate // ignore: cast_nullable_to_non_nullable
as String?,heighestIncreaseRate: freezed == heighestIncreaseRate ? _self.heighestIncreaseRate : heighestIncreaseRate // ignore: cast_nullable_to_non_nullable
as String?,highestDecreaseRate: freezed == highestDecreaseRate ? _self.highestDecreaseRate : highestDecreaseRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AIAgent implements DiagnosticableTreeMixin {

 Map<String, String>? get name; String? get avatar;
/// Create a copy of AIAgent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIAgentCopyWith<AIAgent> get copyWith => _$AIAgentCopyWithImpl<AIAgent>(this as AIAgent, _$identity);

  /// Serializes this AIAgent to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AIAgent'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('avatar', avatar));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIAgent&&const DeepCollectionEquality().equals(other.name, name)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(name),avatar);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AIAgent(name: $name, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $AIAgentCopyWith<$Res>  {
  factory $AIAgentCopyWith(AIAgent value, $Res Function(AIAgent) _then) = _$AIAgentCopyWithImpl;
@useResult
$Res call({
 Map<String, String>? name, String? avatar
});




}
/// @nodoc
class _$AIAgentCopyWithImpl<$Res>
    implements $AIAgentCopyWith<$Res> {
  _$AIAgentCopyWithImpl(this._self, this._then);

  final AIAgent _self;
  final $Res Function(AIAgent) _then;

/// Create a copy of AIAgent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? avatar = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AIAgent].
extension AIAgentPatterns on AIAgent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIAgent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIAgent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIAgent value)  $default,){
final _that = this;
switch (_that) {
case _AIAgent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIAgent value)?  $default,){
final _that = this;
switch (_that) {
case _AIAgent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String>? name,  String? avatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIAgent() when $default != null:
return $default(_that.name,_that.avatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String>? name,  String? avatar)  $default,) {final _that = this;
switch (_that) {
case _AIAgent():
return $default(_that.name,_that.avatar);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String>? name,  String? avatar)?  $default,) {final _that = this;
switch (_that) {
case _AIAgent() when $default != null:
return $default(_that.name,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIAgent with DiagnosticableTreeMixin implements AIAgent {
  const _AIAgent({final  Map<String, String>? name, this.avatar}): _name = name;
  factory _AIAgent.fromJson(Map<String, dynamic> json) => _$AIAgentFromJson(json);

 final  Map<String, String>? _name;
@override Map<String, String>? get name {
  final value = _name;
  if (value == null) return null;
  if (_name is EqualUnmodifiableMapView) return _name;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? avatar;

/// Create a copy of AIAgent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIAgentCopyWith<_AIAgent> get copyWith => __$AIAgentCopyWithImpl<_AIAgent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIAgentToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AIAgent'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('avatar', avatar));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIAgent&&const DeepCollectionEquality().equals(other._name, _name)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_name),avatar);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AIAgent(name: $name, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$AIAgentCopyWith<$Res> implements $AIAgentCopyWith<$Res> {
  factory _$AIAgentCopyWith(_AIAgent value, $Res Function(_AIAgent) _then) = __$AIAgentCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String>? name, String? avatar
});




}
/// @nodoc
class __$AIAgentCopyWithImpl<$Res>
    implements _$AIAgentCopyWith<$Res> {
  __$AIAgentCopyWithImpl(this._self, this._then);

  final _AIAgent _self;
  final $Res Function(_AIAgent) _then;

/// Create a copy of AIAgent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? avatar = freezed,}) {
  return _then(_AIAgent(
name: freezed == name ? _self._name : name // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Author implements DiagnosticableTreeMixin {

 String? get avatar; String? get slug; IntelPlatform? get platform;@JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter() Multilingual? get prompt;
/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorCopyWith<Author> get copyWith => _$AuthorCopyWithImpl<Author>(this as Author, _$identity);

  /// Serializes this Author to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Author'))
    ..add(DiagnosticsProperty('avatar', avatar))..add(DiagnosticsProperty('slug', slug))..add(DiagnosticsProperty('platform', platform))..add(DiagnosticsProperty('prompt', prompt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Author&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.prompt, prompt) || other.prompt == prompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatar,slug,platform,prompt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Author(avatar: $avatar, slug: $slug, platform: $platform, prompt: $prompt)';
}


}

/// @nodoc
abstract mixin class $AuthorCopyWith<$Res>  {
  factory $AuthorCopyWith(Author value, $Res Function(Author) _then) = _$AuthorCopyWithImpl;
@useResult
$Res call({
 String? avatar, String? slug, IntelPlatform? platform,@JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter() Multilingual? prompt
});


$IntelPlatformCopyWith<$Res>? get platform;$MultilingualCopyWith<$Res>? get prompt;

}
/// @nodoc
class _$AuthorCopyWithImpl<$Res>
    implements $AuthorCopyWith<$Res> {
  _$AuthorCopyWithImpl(this._self, this._then);

  final Author _self;
  final $Res Function(Author) _then;

/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avatar = freezed,Object? slug = freezed,Object? platform = freezed,Object? prompt = freezed,}) {
  return _then(_self.copyWith(
avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as IntelPlatform?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as Multilingual?,
  ));
}
/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelPlatformCopyWith<$Res>? get platform {
    if (_self.platform == null) {
    return null;
  }

  return $IntelPlatformCopyWith<$Res>(_self.platform!, (value) {
    return _then(_self.copyWith(platform: value));
  });
}/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get prompt {
    if (_self.prompt == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.prompt!, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}
}


/// Adds pattern-matching-related methods to [Author].
extension AuthorPatterns on Author {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Author value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Author() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Author value)  $default,){
final _that = this;
switch (_that) {
case _Author():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Author value)?  $default,){
final _that = this;
switch (_that) {
case _Author() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? avatar,  String? slug,  IntelPlatform? platform, @JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter()  Multilingual? prompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Author() when $default != null:
return $default(_that.avatar,_that.slug,_that.platform,_that.prompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? avatar,  String? slug,  IntelPlatform? platform, @JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter()  Multilingual? prompt)  $default,) {final _that = this;
switch (_that) {
case _Author():
return $default(_that.avatar,_that.slug,_that.platform,_that.prompt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? avatar,  String? slug,  IntelPlatform? platform, @JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter()  Multilingual? prompt)?  $default,) {final _that = this;
switch (_that) {
case _Author() when $default != null:
return $default(_that.avatar,_that.slug,_that.platform,_that.prompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Author with DiagnosticableTreeMixin implements Author {
  const _Author({this.avatar, this.slug, this.platform, @JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter() this.prompt});
  factory _Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

@override final  String? avatar;
@override final  String? slug;
@override final  IntelPlatform? platform;
@override@JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter() final  Multilingual? prompt;

/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorCopyWith<_Author> get copyWith => __$AuthorCopyWithImpl<_Author>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Author'))
    ..add(DiagnosticsProperty('avatar', avatar))..add(DiagnosticsProperty('slug', slug))..add(DiagnosticsProperty('platform', platform))..add(DiagnosticsProperty('prompt', prompt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Author&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.prompt, prompt) || other.prompt == prompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatar,slug,platform,prompt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Author(avatar: $avatar, slug: $slug, platform: $platform, prompt: $prompt)';
}


}

/// @nodoc
abstract mixin class _$AuthorCopyWith<$Res> implements $AuthorCopyWith<$Res> {
  factory _$AuthorCopyWith(_Author value, $Res Function(_Author) _then) = __$AuthorCopyWithImpl;
@override @useResult
$Res call({
 String? avatar, String? slug, IntelPlatform? platform,@JsonKey(fromJson: multilingualStringFromJson, toJson: multilingualStringToJson)@MultilingualStringConverter() Multilingual? prompt
});


@override $IntelPlatformCopyWith<$Res>? get platform;@override $MultilingualCopyWith<$Res>? get prompt;

}
/// @nodoc
class __$AuthorCopyWithImpl<$Res>
    implements _$AuthorCopyWith<$Res> {
  __$AuthorCopyWithImpl(this._self, this._then);

  final _Author _self;
  final $Res Function(_Author) _then;

/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatar = freezed,Object? slug = freezed,Object? platform = freezed,Object? prompt = freezed,}) {
  return _then(_Author(
avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as IntelPlatform?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as Multilingual?,
  ));
}

/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelPlatformCopyWith<$Res>? get platform {
    if (_self.platform == null) {
    return null;
  }

  return $IntelPlatformCopyWith<$Res>(_self.platform!, (value) {
    return _then(_self.copyWith(platform: value));
  });
}/// Create a copy of Author
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get prompt {
    if (_self.prompt == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.prompt!, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}
}


/// @nodoc
mixin _$IntelPlatform implements DiagnosticableTreeMixin {

 String? get name; String? get id; String? get logo;
/// Create a copy of IntelPlatform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelPlatformCopyWith<IntelPlatform> get copyWith => _$IntelPlatformCopyWithImpl<IntelPlatform>(this as IntelPlatform, _$identity);

  /// Serializes this IntelPlatform to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelPlatform'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('logo', logo));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelPlatform&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,logo);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelPlatform(name: $name, id: $id, logo: $logo)';
}


}

/// @nodoc
abstract mixin class $IntelPlatformCopyWith<$Res>  {
  factory $IntelPlatformCopyWith(IntelPlatform value, $Res Function(IntelPlatform) _then) = _$IntelPlatformCopyWithImpl;
@useResult
$Res call({
 String? name, String? id, String? logo
});




}
/// @nodoc
class _$IntelPlatformCopyWithImpl<$Res>
    implements $IntelPlatformCopyWith<$Res> {
  _$IntelPlatformCopyWithImpl(this._self, this._then);

  final IntelPlatform _self;
  final $Res Function(IntelPlatform) _then;

/// Create a copy of IntelPlatform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? id = freezed,Object? logo = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelPlatform].
extension IntelPlatformPatterns on IntelPlatform {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelPlatform value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelPlatform() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelPlatform value)  $default,){
final _that = this;
switch (_that) {
case _IntelPlatform():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelPlatform value)?  $default,){
final _that = this;
switch (_that) {
case _IntelPlatform() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? id,  String? logo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelPlatform() when $default != null:
return $default(_that.name,_that.id,_that.logo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? id,  String? logo)  $default,) {final _that = this;
switch (_that) {
case _IntelPlatform():
return $default(_that.name,_that.id,_that.logo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? id,  String? logo)?  $default,) {final _that = this;
switch (_that) {
case _IntelPlatform() when $default != null:
return $default(_that.name,_that.id,_that.logo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelPlatform with DiagnosticableTreeMixin implements IntelPlatform {
  const _IntelPlatform({this.name, this.id, this.logo});
  factory _IntelPlatform.fromJson(Map<String, dynamic> json) => _$IntelPlatformFromJson(json);

@override final  String? name;
@override final  String? id;
@override final  String? logo;

/// Create a copy of IntelPlatform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelPlatformCopyWith<_IntelPlatform> get copyWith => __$IntelPlatformCopyWithImpl<_IntelPlatform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelPlatformToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelPlatform'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('logo', logo));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelPlatform&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,logo);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelPlatform(name: $name, id: $id, logo: $logo)';
}


}

/// @nodoc
abstract mixin class _$IntelPlatformCopyWith<$Res> implements $IntelPlatformCopyWith<$Res> {
  factory _$IntelPlatformCopyWith(_IntelPlatform value, $Res Function(_IntelPlatform) _then) = __$IntelPlatformCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? id, String? logo
});




}
/// @nodoc
class __$IntelPlatformCopyWithImpl<$Res>
    implements _$IntelPlatformCopyWith<$Res> {
  __$IntelPlatformCopyWithImpl(this._self, this._then);

  final _IntelPlatform _self;
  final $Res Function(_IntelPlatform) _then;

/// Create a copy of IntelPlatform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? id = freezed,Object? logo = freezed,}) {
  return _then(_IntelPlatform(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntelMedia implements DiagnosticableTreeMixin {

 String? get url;@JsonKey(name: 'type') String? get type;
/// Create a copy of IntelMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelMediaCopyWith<IntelMedia> get copyWith => _$IntelMediaCopyWithImpl<IntelMedia>(this as IntelMedia, _$identity);

  /// Serializes this IntelMedia to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelMedia'))
    ..add(DiagnosticsProperty('url', url))..add(DiagnosticsProperty('type', type));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelMedia(url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class $IntelMediaCopyWith<$Res>  {
  factory $IntelMediaCopyWith(IntelMedia value, $Res Function(IntelMedia) _then) = _$IntelMediaCopyWithImpl;
@useResult
$Res call({
 String? url,@JsonKey(name: 'type') String? type
});




}
/// @nodoc
class _$IntelMediaCopyWithImpl<$Res>
    implements $IntelMediaCopyWith<$Res> {
  _$IntelMediaCopyWithImpl(this._self, this._then);

  final IntelMedia _self;
  final $Res Function(IntelMedia) _then;

/// Create a copy of IntelMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelMedia].
extension IntelMediaPatterns on IntelMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelMedia value)  $default,){
final _that = this;
switch (_that) {
case _IntelMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelMedia value)?  $default,){
final _that = this;
switch (_that) {
case _IntelMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url, @JsonKey(name: 'type')  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelMedia() when $default != null:
return $default(_that.url,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url, @JsonKey(name: 'type')  String? type)  $default,) {final _that = this;
switch (_that) {
case _IntelMedia():
return $default(_that.url,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url, @JsonKey(name: 'type')  String? type)?  $default,) {final _that = this;
switch (_that) {
case _IntelMedia() when $default != null:
return $default(_that.url,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelMedia with DiagnosticableTreeMixin implements IntelMedia {
  const _IntelMedia({this.url, @JsonKey(name: 'type') this.type});
  factory _IntelMedia.fromJson(Map<String, dynamic> json) => _$IntelMediaFromJson(json);

@override final  String? url;
@override@JsonKey(name: 'type') final  String? type;

/// Create a copy of IntelMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelMediaCopyWith<_IntelMedia> get copyWith => __$IntelMediaCopyWithImpl<_IntelMedia>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelMediaToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelMedia'))
    ..add(DiagnosticsProperty('url', url))..add(DiagnosticsProperty('type', type));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelMedia(url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class _$IntelMediaCopyWith<$Res> implements $IntelMediaCopyWith<$Res> {
  factory _$IntelMediaCopyWith(_IntelMedia value, $Res Function(_IntelMedia) _then) = __$IntelMediaCopyWithImpl;
@override @useResult
$Res call({
 String? url,@JsonKey(name: 'type') String? type
});




}
/// @nodoc
class __$IntelMediaCopyWithImpl<$Res>
    implements _$IntelMediaCopyWith<$Res> {
  __$IntelMediaCopyWithImpl(this._self, this._then);

  final _IntelMedia _self;
  final $Res Function(_IntelMedia) _then;

/// Create a copy of IntelMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? type = freezed,}) {
  return _then(_IntelMedia(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Analyzed implements DiagnosticableTreeMixin {

 String? get zh; String? get en;
/// Create a copy of Analyzed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyzedCopyWith<Analyzed> get copyWith => _$AnalyzedCopyWithImpl<Analyzed>(this as Analyzed, _$identity);

  /// Serializes this Analyzed to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Analyzed'))
    ..add(DiagnosticsProperty('zh', zh))..add(DiagnosticsProperty('en', en));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Analyzed&&(identical(other.zh, zh) || other.zh == zh)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,zh,en);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Analyzed(zh: $zh, en: $en)';
}


}

/// @nodoc
abstract mixin class $AnalyzedCopyWith<$Res>  {
  factory $AnalyzedCopyWith(Analyzed value, $Res Function(Analyzed) _then) = _$AnalyzedCopyWithImpl;
@useResult
$Res call({
 String? zh, String? en
});




}
/// @nodoc
class _$AnalyzedCopyWithImpl<$Res>
    implements $AnalyzedCopyWith<$Res> {
  _$AnalyzedCopyWithImpl(this._self, this._then);

  final Analyzed _self;
  final $Res Function(Analyzed) _then;

/// Create a copy of Analyzed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zh = freezed,Object? en = freezed,}) {
  return _then(_self.copyWith(
zh: freezed == zh ? _self.zh : zh // ignore: cast_nullable_to_non_nullable
as String?,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Analyzed].
extension AnalyzedPatterns on Analyzed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Analyzed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Analyzed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Analyzed value)  $default,){
final _that = this;
switch (_that) {
case _Analyzed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Analyzed value)?  $default,){
final _that = this;
switch (_that) {
case _Analyzed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? zh,  String? en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Analyzed() when $default != null:
return $default(_that.zh,_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? zh,  String? en)  $default,) {final _that = this;
switch (_that) {
case _Analyzed():
return $default(_that.zh,_that.en);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? zh,  String? en)?  $default,) {final _that = this;
switch (_that) {
case _Analyzed() when $default != null:
return $default(_that.zh,_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Analyzed extends Analyzed with DiagnosticableTreeMixin {
  const _Analyzed({this.zh, this.en}): super._();
  factory _Analyzed.fromJson(Map<String, dynamic> json) => _$AnalyzedFromJson(json);

@override final  String? zh;
@override final  String? en;

/// Create a copy of Analyzed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyzedCopyWith<_Analyzed> get copyWith => __$AnalyzedCopyWithImpl<_Analyzed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalyzedToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Analyzed'))
    ..add(DiagnosticsProperty('zh', zh))..add(DiagnosticsProperty('en', en));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Analyzed&&(identical(other.zh, zh) || other.zh == zh)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,zh,en);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Analyzed(zh: $zh, en: $en)';
}


}

/// @nodoc
abstract mixin class _$AnalyzedCopyWith<$Res> implements $AnalyzedCopyWith<$Res> {
  factory _$AnalyzedCopyWith(_Analyzed value, $Res Function(_Analyzed) _then) = __$AnalyzedCopyWithImpl;
@override @useResult
$Res call({
 String? zh, String? en
});




}
/// @nodoc
class __$AnalyzedCopyWithImpl<$Res>
    implements _$AnalyzedCopyWith<$Res> {
  __$AnalyzedCopyWithImpl(this._self, this._then);

  final _Analyzed _self;
  final $Res Function(_Analyzed) _then;

/// Create a copy of Analyzed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zh = freezed,Object? en = freezed,}) {
  return _then(_Analyzed(
zh: freezed == zh ? _self.zh : zh // ignore: cast_nullable_to_non_nullable
as String?,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntelChain implements DiagnosticableTreeMixin {

 String? get name; String? get id; String? get address; String? get logo; String? get slug;@JsonKey(name: 'network_id') String? get networkId;
/// Create a copy of IntelChain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntelChainCopyWith<IntelChain> get copyWith => _$IntelChainCopyWithImpl<IntelChain>(this as IntelChain, _$identity);

  /// Serializes this IntelChain to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelChain'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('address', address))..add(DiagnosticsProperty('logo', logo))..add(DiagnosticsProperty('slug', slug))..add(DiagnosticsProperty('networkId', networkId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntelChain&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.address, address) || other.address == address)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.networkId, networkId) || other.networkId == networkId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,address,logo,slug,networkId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelChain(name: $name, id: $id, address: $address, logo: $logo, slug: $slug, networkId: $networkId)';
}


}

/// @nodoc
abstract mixin class $IntelChainCopyWith<$Res>  {
  factory $IntelChainCopyWith(IntelChain value, $Res Function(IntelChain) _then) = _$IntelChainCopyWithImpl;
@useResult
$Res call({
 String? name, String? id, String? address, String? logo, String? slug,@JsonKey(name: 'network_id') String? networkId
});




}
/// @nodoc
class _$IntelChainCopyWithImpl<$Res>
    implements $IntelChainCopyWith<$Res> {
  _$IntelChainCopyWithImpl(this._self, this._then);

  final IntelChain _self;
  final $Res Function(IntelChain) _then;

/// Create a copy of IntelChain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? id = freezed,Object? address = freezed,Object? logo = freezed,Object? slug = freezed,Object? networkId = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,networkId: freezed == networkId ? _self.networkId : networkId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntelChain].
extension IntelChainPatterns on IntelChain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntelChain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntelChain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntelChain value)  $default,){
final _that = this;
switch (_that) {
case _IntelChain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntelChain value)?  $default,){
final _that = this;
switch (_that) {
case _IntelChain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? id,  String? address,  String? logo,  String? slug, @JsonKey(name: 'network_id')  String? networkId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntelChain() when $default != null:
return $default(_that.name,_that.id,_that.address,_that.logo,_that.slug,_that.networkId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? id,  String? address,  String? logo,  String? slug, @JsonKey(name: 'network_id')  String? networkId)  $default,) {final _that = this;
switch (_that) {
case _IntelChain():
return $default(_that.name,_that.id,_that.address,_that.logo,_that.slug,_that.networkId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? id,  String? address,  String? logo,  String? slug, @JsonKey(name: 'network_id')  String? networkId)?  $default,) {final _that = this;
switch (_that) {
case _IntelChain() when $default != null:
return $default(_that.name,_that.id,_that.address,_that.logo,_that.slug,_that.networkId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntelChain with DiagnosticableTreeMixin implements IntelChain {
  const _IntelChain({this.name, this.id, this.address, this.logo, this.slug, @JsonKey(name: 'network_id') this.networkId});
  factory _IntelChain.fromJson(Map<String, dynamic> json) => _$IntelChainFromJson(json);

@override final  String? name;
@override final  String? id;
@override final  String? address;
@override final  String? logo;
@override final  String? slug;
@override@JsonKey(name: 'network_id') final  String? networkId;

/// Create a copy of IntelChain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntelChainCopyWith<_IntelChain> get copyWith => __$IntelChainCopyWithImpl<_IntelChain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntelChainToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IntelChain'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('address', address))..add(DiagnosticsProperty('logo', logo))..add(DiagnosticsProperty('slug', slug))..add(DiagnosticsProperty('networkId', networkId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntelChain&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.address, address) || other.address == address)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.networkId, networkId) || other.networkId == networkId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,address,logo,slug,networkId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IntelChain(name: $name, id: $id, address: $address, logo: $logo, slug: $slug, networkId: $networkId)';
}


}

/// @nodoc
abstract mixin class _$IntelChainCopyWith<$Res> implements $IntelChainCopyWith<$Res> {
  factory _$IntelChainCopyWith(_IntelChain value, $Res Function(_IntelChain) _then) = __$IntelChainCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? id, String? address, String? logo, String? slug,@JsonKey(name: 'network_id') String? networkId
});




}
/// @nodoc
class __$IntelChainCopyWithImpl<$Res>
    implements _$IntelChainCopyWith<$Res> {
  __$IntelChainCopyWithImpl(this._self, this._then);

  final _IntelChain _self;
  final $Res Function(_IntelChain) _then;

/// Create a copy of IntelChain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? id = freezed,Object? address = freezed,Object? logo = freezed,Object? slug = freezed,Object? networkId = freezed,}) {
  return _then(_IntelChain(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,networkId: freezed == networkId ? _self.networkId : networkId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Entity implements DiagnosticableTreeMixin {

 String? get id;@JsonKey(name: 'entity_id') String? get entityId; String? get name; String? get symbol; String? get standard; int? get decimals;@JsonKey(name: 'contract_address') String? get contractAddress; String? get logo;@JsonKey(name: 'stats') IntelStats? get stats;@JsonKey(name: 'chain') IntelChain? get chain;@JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic) DateTime? get createdAt;@JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic) DateTime? get updatedAt;@DynamicDoubleConverter()@JsonKey(name: 'score') double? get score;@JsonKey(name: 'is_native') bool? get isNative;
/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityCopyWith<Entity> get copyWith => _$EntityCopyWithImpl<Entity>(this as Entity, _$identity);

  /// Serializes this Entity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Entity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('entityId', entityId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('symbol', symbol))..add(DiagnosticsProperty('standard', standard))..add(DiagnosticsProperty('decimals', decimals))..add(DiagnosticsProperty('contractAddress', contractAddress))..add(DiagnosticsProperty('logo', logo))..add(DiagnosticsProperty('stats', stats))..add(DiagnosticsProperty('chain', chain))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('score', score))..add(DiagnosticsProperty('isNative', isNative));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Entity&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.standard, standard) || other.standard == standard)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.chain, chain) || other.chain == chain)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,entityId,name,symbol,standard,decimals,contractAddress,logo,stats,chain,createdAt,updatedAt,score,isNative);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Entity(id: $id, entityId: $entityId, name: $name, symbol: $symbol, standard: $standard, decimals: $decimals, contractAddress: $contractAddress, logo: $logo, stats: $stats, chain: $chain, createdAt: $createdAt, updatedAt: $updatedAt, score: $score, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class $EntityCopyWith<$Res>  {
  factory $EntityCopyWith(Entity value, $Res Function(Entity) _then) = _$EntityCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'entity_id') String? entityId, String? name, String? symbol, String? standard, int? decimals,@JsonKey(name: 'contract_address') String? contractAddress, String? logo,@JsonKey(name: 'stats') IntelStats? stats,@JsonKey(name: 'chain') IntelChain? chain,@JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic) DateTime? createdAt,@JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic) DateTime? updatedAt,@DynamicDoubleConverter()@JsonKey(name: 'score') double? score,@JsonKey(name: 'is_native') bool? isNative
});


$IntelStatsCopyWith<$Res>? get stats;$IntelChainCopyWith<$Res>? get chain;

}
/// @nodoc
class _$EntityCopyWithImpl<$Res>
    implements $EntityCopyWith<$Res> {
  _$EntityCopyWithImpl(this._self, this._then);

  final Entity _self;
  final $Res Function(Entity) _then;

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? entityId = freezed,Object? name = freezed,Object? symbol = freezed,Object? standard = freezed,Object? decimals = freezed,Object? contractAddress = freezed,Object? logo = freezed,Object? stats = freezed,Object? chain = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? score = freezed,Object? isNative = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,standard: freezed == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as IntelStats?,chain: freezed == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as IntelChain?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $IntelStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelChainCopyWith<$Res>? get chain {
    if (_self.chain == null) {
    return null;
  }

  return $IntelChainCopyWith<$Res>(_self.chain!, (value) {
    return _then(_self.copyWith(chain: value));
  });
}
}


/// Adds pattern-matching-related methods to [Entity].
extension EntityPatterns on Entity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Entity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Entity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Entity value)  $default,){
final _that = this;
switch (_that) {
case _Entity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Entity value)?  $default,){
final _that = this;
switch (_that) {
case _Entity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'entity_id')  String? entityId,  String? name,  String? symbol,  String? standard,  int? decimals, @JsonKey(name: 'contract_address')  String? contractAddress,  String? logo, @JsonKey(name: 'stats')  IntelStats? stats, @JsonKey(name: 'chain')  IntelChain? chain, @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)  DateTime? updatedAt, @DynamicDoubleConverter()@JsonKey(name: 'score')  double? score, @JsonKey(name: 'is_native')  bool? isNative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Entity() when $default != null:
return $default(_that.id,_that.entityId,_that.name,_that.symbol,_that.standard,_that.decimals,_that.contractAddress,_that.logo,_that.stats,_that.chain,_that.createdAt,_that.updatedAt,_that.score,_that.isNative);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'entity_id')  String? entityId,  String? name,  String? symbol,  String? standard,  int? decimals, @JsonKey(name: 'contract_address')  String? contractAddress,  String? logo, @JsonKey(name: 'stats')  IntelStats? stats, @JsonKey(name: 'chain')  IntelChain? chain, @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)  DateTime? updatedAt, @DynamicDoubleConverter()@JsonKey(name: 'score')  double? score, @JsonKey(name: 'is_native')  bool? isNative)  $default,) {final _that = this;
switch (_that) {
case _Entity():
return $default(_that.id,_that.entityId,_that.name,_that.symbol,_that.standard,_that.decimals,_that.contractAddress,_that.logo,_that.stats,_that.chain,_that.createdAt,_that.updatedAt,_that.score,_that.isNative);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'entity_id')  String? entityId,  String? name,  String? symbol,  String? standard,  int? decimals, @JsonKey(name: 'contract_address')  String? contractAddress,  String? logo, @JsonKey(name: 'stats')  IntelStats? stats, @JsonKey(name: 'chain')  IntelChain? chain, @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)  DateTime? updatedAt, @DynamicDoubleConverter()@JsonKey(name: 'score')  double? score, @JsonKey(name: 'is_native')  bool? isNative)?  $default,) {final _that = this;
switch (_that) {
case _Entity() when $default != null:
return $default(_that.id,_that.entityId,_that.name,_that.symbol,_that.standard,_that.decimals,_that.contractAddress,_that.logo,_that.stats,_that.chain,_that.createdAt,_that.updatedAt,_that.score,_that.isNative);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Entity extends Entity with DiagnosticableTreeMixin {
  const _Entity({this.id, @JsonKey(name: 'entity_id') this.entityId, this.name, this.symbol, this.standard, this.decimals, @JsonKey(name: 'contract_address') this.contractAddress, this.logo, @JsonKey(name: 'stats') this.stats, @JsonKey(name: 'chain') this.chain, @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic) this.createdAt, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic) this.updatedAt, @DynamicDoubleConverter()@JsonKey(name: 'score') this.score, @JsonKey(name: 'is_native') this.isNative}): super._();
  factory _Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'entity_id') final  String? entityId;
@override final  String? name;
@override final  String? symbol;
@override final  String? standard;
@override final  int? decimals;
@override@JsonKey(name: 'contract_address') final  String? contractAddress;
@override final  String? logo;
@override@JsonKey(name: 'stats') final  IntelStats? stats;
@override@JsonKey(name: 'chain') final  IntelChain? chain;
@override@JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic) final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic) final  DateTime? updatedAt;
@override@DynamicDoubleConverter()@JsonKey(name: 'score') final  double? score;
@override@JsonKey(name: 'is_native') final  bool? isNative;

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityCopyWith<_Entity> get copyWith => __$EntityCopyWithImpl<_Entity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Entity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('entityId', entityId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('symbol', symbol))..add(DiagnosticsProperty('standard', standard))..add(DiagnosticsProperty('decimals', decimals))..add(DiagnosticsProperty('contractAddress', contractAddress))..add(DiagnosticsProperty('logo', logo))..add(DiagnosticsProperty('stats', stats))..add(DiagnosticsProperty('chain', chain))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('score', score))..add(DiagnosticsProperty('isNative', isNative));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Entity&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.standard, standard) || other.standard == standard)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.chain, chain) || other.chain == chain)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,entityId,name,symbol,standard,decimals,contractAddress,logo,stats,chain,createdAt,updatedAt,score,isNative);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Entity(id: $id, entityId: $entityId, name: $name, symbol: $symbol, standard: $standard, decimals: $decimals, contractAddress: $contractAddress, logo: $logo, stats: $stats, chain: $chain, createdAt: $createdAt, updatedAt: $updatedAt, score: $score, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class _$EntityCopyWith<$Res> implements $EntityCopyWith<$Res> {
  factory _$EntityCopyWith(_Entity value, $Res Function(_Entity) _then) = __$EntityCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'entity_id') String? entityId, String? name, String? symbol, String? standard, int? decimals,@JsonKey(name: 'contract_address') String? contractAddress, String? logo,@JsonKey(name: 'stats') IntelStats? stats,@JsonKey(name: 'chain') IntelChain? chain,@JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic) DateTime? createdAt,@JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic) DateTime? updatedAt,@DynamicDoubleConverter()@JsonKey(name: 'score') double? score,@JsonKey(name: 'is_native') bool? isNative
});


@override $IntelStatsCopyWith<$Res>? get stats;@override $IntelChainCopyWith<$Res>? get chain;

}
/// @nodoc
class __$EntityCopyWithImpl<$Res>
    implements _$EntityCopyWith<$Res> {
  __$EntityCopyWithImpl(this._self, this._then);

  final _Entity _self;
  final $Res Function(_Entity) _then;

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? entityId = freezed,Object? name = freezed,Object? symbol = freezed,Object? standard = freezed,Object? decimals = freezed,Object? contractAddress = freezed,Object? logo = freezed,Object? stats = freezed,Object? chain = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? score = freezed,Object? isNative = freezed,}) {
  return _then(_Entity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,standard: freezed == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as IntelStats?,chain: freezed == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as IntelChain?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $IntelStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntelChainCopyWith<$Res>? get chain {
    if (_self.chain == null) {
    return null;
  }

  return $IntelChainCopyWith<$Res>(_self.chain!, (value) {
    return _then(_self.copyWith(chain: value));
  });
}
}

// dart format on
