// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chain _$ChainFromJson(Map<String, dynamic> json) {
  return _Chain.fromJson(json);
}

/// @nodoc
mixin _$Chain {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'symbol')
  String get symbol => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'rpc')
  String get rpc => throw _privateConstructorUsedError;
  @JsonKey(name: 'okx_chain_index')
  String get okxChainIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'chain_id')
  String get chainId => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo')
  String get logo => throw _privateConstructorUsedError;
  @JsonKey(name: 'chain_type')
  String get chainType => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'main_token')
  String get mainToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  String? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this Chain to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Chain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChainCopyWith<Chain> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChainCopyWith<$Res> {
  factory $ChainCopyWith(Chain value, $Res Function(Chain) then) =
      _$ChainCopyWithImpl<$Res, Chain>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'symbol') String symbol,
      @JsonKey(name: 'slug') String slug,
      @JsonKey(name: 'rpc') String rpc,
      @JsonKey(name: 'okx_chain_index') String okxChainIndex,
      @JsonKey(name: 'chain_id') String chainId,
      @JsonKey(name: 'logo') String logo,
      @JsonKey(name: 'chain_type') String chainType,
      @JsonKey(name: 'id') String id,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'main_token') String mainToken,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'deleted_at') String? deletedAt});
}

/// @nodoc
class _$ChainCopyWithImpl<$Res, $Val extends Chain>
    implements $ChainCopyWith<$Res> {
  _$ChainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Chain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? slug = null,
    Object? rpc = null,
    Object? okxChainIndex = null,
    Object? chainId = null,
    Object? logo = null,
    Object? chainType = null,
    Object? id = null,
    Object? isActive = null,
    Object? mainToken = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      rpc: null == rpc
          ? _value.rpc
          : rpc // ignore: cast_nullable_to_non_nullable
              as String,
      okxChainIndex: null == okxChainIndex
          ? _value.okxChainIndex
          : okxChainIndex // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      mainToken: null == mainToken
          ? _value.mainToken
          : mainToken // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChainImplCopyWith<$Res> implements $ChainCopyWith<$Res> {
  factory _$$ChainImplCopyWith(
          _$ChainImpl value, $Res Function(_$ChainImpl) then) =
      __$$ChainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'symbol') String symbol,
      @JsonKey(name: 'slug') String slug,
      @JsonKey(name: 'rpc') String rpc,
      @JsonKey(name: 'okx_chain_index') String okxChainIndex,
      @JsonKey(name: 'chain_id') String chainId,
      @JsonKey(name: 'logo') String logo,
      @JsonKey(name: 'chain_type') String chainType,
      @JsonKey(name: 'id') String id,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'main_token') String mainToken,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'deleted_at') String? deletedAt});
}

/// @nodoc
class __$$ChainImplCopyWithImpl<$Res>
    extends _$ChainCopyWithImpl<$Res, _$ChainImpl>
    implements _$$ChainImplCopyWith<$Res> {
  __$$ChainImplCopyWithImpl(
      _$ChainImpl _value, $Res Function(_$ChainImpl) _then)
      : super(_value, _then);

  /// Create a copy of Chain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? slug = null,
    Object? rpc = null,
    Object? okxChainIndex = null,
    Object? chainId = null,
    Object? logo = null,
    Object? chainType = null,
    Object? id = null,
    Object? isActive = null,
    Object? mainToken = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$ChainImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      rpc: null == rpc
          ? _value.rpc
          : rpc // ignore: cast_nullable_to_non_nullable
              as String,
      okxChainIndex: null == okxChainIndex
          ? _value.okxChainIndex
          : okxChainIndex // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      mainToken: null == mainToken
          ? _value.mainToken
          : mainToken // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChainImpl implements _Chain {
  const _$ChainImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'symbol') required this.symbol,
      @JsonKey(name: 'slug') required this.slug,
      @JsonKey(name: 'rpc') required this.rpc,
      @JsonKey(name: 'okx_chain_index') required this.okxChainIndex,
      @JsonKey(name: 'chain_id') required this.chainId,
      @JsonKey(name: 'logo') required this.logo,
      @JsonKey(name: 'chain_type') required this.chainType,
      @JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'main_token') required this.mainToken,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'deleted_at') this.deletedAt});

  factory _$ChainImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChainImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'symbol')
  final String symbol;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'rpc')
  final String rpc;
  @override
  @JsonKey(name: 'okx_chain_index')
  final String okxChainIndex;
  @override
  @JsonKey(name: 'chain_id')
  final String chainId;
  @override
  @JsonKey(name: 'logo')
  final String logo;
  @override
  @JsonKey(name: 'chain_type')
  final String chainType;
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'main_token')
  final String mainToken;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @override
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  @override
  String toString() {
    return 'Chain(name: $name, symbol: $symbol, slug: $slug, rpc: $rpc, okxChainIndex: $okxChainIndex, chainId: $chainId, logo: $logo, chainType: $chainType, id: $id, isActive: $isActive, mainToken: $mainToken, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChainImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.rpc, rpc) || other.rpc == rpc) &&
            (identical(other.okxChainIndex, okxChainIndex) ||
                other.okxChainIndex == okxChainIndex) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.chainType, chainType) ||
                other.chainType == chainType) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.mainToken, mainToken) ||
                other.mainToken == mainToken) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      slug,
      rpc,
      okxChainIndex,
      chainId,
      logo,
      chainType,
      id,
      isActive,
      mainToken,
      createdAt,
      updatedAt,
      deletedAt);

  /// Create a copy of Chain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChainImplCopyWith<_$ChainImpl> get copyWith =>
      __$$ChainImplCopyWithImpl<_$ChainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChainImplToJson(
      this,
    );
  }
}

abstract class _Chain implements Chain {
  const factory _Chain(
      {@JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'symbol') required final String symbol,
      @JsonKey(name: 'slug') required final String slug,
      @JsonKey(name: 'rpc') required final String rpc,
      @JsonKey(name: 'okx_chain_index') required final String okxChainIndex,
      @JsonKey(name: 'chain_id') required final String chainId,
      @JsonKey(name: 'logo') required final String logo,
      @JsonKey(name: 'chain_type') required final String chainType,
      @JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'is_active') required final bool isActive,
      @JsonKey(name: 'main_token') required final String mainToken,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'updated_at') required final String updatedAt,
      @JsonKey(name: 'deleted_at') final String? deletedAt}) = _$ChainImpl;

  factory _Chain.fromJson(Map<String, dynamic> json) = _$ChainImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'symbol')
  String get symbol;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'rpc')
  String get rpc;
  @override
  @JsonKey(name: 'okx_chain_index')
  String get okxChainIndex;
  @override
  @JsonKey(name: 'chain_id')
  String get chainId;
  @override
  @JsonKey(name: 'logo')
  String get logo;
  @override
  @JsonKey(name: 'chain_type')
  String get chainType;
  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'main_token')
  String get mainToken;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  @JsonKey(name: 'deleted_at')
  String? get deletedAt;

  /// Create a copy of Chain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChainImplCopyWith<_$ChainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
