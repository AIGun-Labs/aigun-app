// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_chains.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletChains _$WalletChainsFromJson(Map<String, dynamic> json) {
  return _WalletChains.fromJson(json);
}

/// @nodoc
mixin _$WalletChains {
  @JsonKey(name: "chain_id")
  int get chainId => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_type")
  String get chainType => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_name")
  String get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "logo_url")
  String get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "explorer")
  String get explorer => throw _privateConstructorUsedError;

  /// Serializes this WalletChains to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletChains
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletChainsCopyWith<WalletChains> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletChainsCopyWith<$Res> {
  factory $WalletChainsCopyWith(
          WalletChains value, $Res Function(WalletChains) then) =
      _$WalletChainsCopyWithImpl<$Res, WalletChains>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "logo_url") String logoUrl,
      @JsonKey(name: "explorer") String explorer});
}

/// @nodoc
class _$WalletChainsCopyWithImpl<$Res, $Val extends WalletChains>
    implements $WalletChainsCopyWith<$Res> {
  _$WalletChainsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletChains
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainType = null,
    Object? chainName = null,
    Object? logoUrl = null,
    Object? explorer = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      explorer: null == explorer
          ? _value.explorer
          : explorer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletChainsImplCopyWith<$Res>
    implements $WalletChainsCopyWith<$Res> {
  factory _$$WalletChainsImplCopyWith(
          _$WalletChainsImpl value, $Res Function(_$WalletChainsImpl) then) =
      __$$WalletChainsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") int chainId,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "logo_url") String logoUrl,
      @JsonKey(name: "explorer") String explorer});
}

/// @nodoc
class __$$WalletChainsImplCopyWithImpl<$Res>
    extends _$WalletChainsCopyWithImpl<$Res, _$WalletChainsImpl>
    implements _$$WalletChainsImplCopyWith<$Res> {
  __$$WalletChainsImplCopyWithImpl(
      _$WalletChainsImpl _value, $Res Function(_$WalletChainsImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletChains
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? chainType = null,
    Object? chainName = null,
    Object? logoUrl = null,
    Object? explorer = null,
  }) {
    return _then(_$WalletChainsImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      explorer: null == explorer
          ? _value.explorer
          : explorer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletChainsImpl implements _WalletChains {
  const _$WalletChainsImpl(
      {@JsonKey(name: "chain_id") required this.chainId,
      @JsonKey(name: "chain_type") required this.chainType,
      @JsonKey(name: "chain_name") required this.chainName,
      @JsonKey(name: "logo_url") required this.logoUrl,
      @JsonKey(name: "explorer") required this.explorer});

  factory _$WalletChainsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletChainsImplFromJson(json);

  @override
  @JsonKey(name: "chain_id")
  final int chainId;
  @override
  @JsonKey(name: "chain_type")
  final String chainType;
  @override
  @JsonKey(name: "chain_name")
  final String chainName;
  @override
  @JsonKey(name: "logo_url")
  final String logoUrl;
  @override
  @JsonKey(name: "explorer")
  final String explorer;

  @override
  String toString() {
    return 'WalletChains(chainId: $chainId, chainType: $chainType, chainName: $chainName, logoUrl: $logoUrl, explorer: $explorer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletChainsImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.chainType, chainType) ||
                other.chainType == chainType) &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.explorer, explorer) ||
                other.explorer == explorer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chainId, chainType, chainName, logoUrl, explorer);

  /// Create a copy of WalletChains
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletChainsImplCopyWith<_$WalletChainsImpl> get copyWith =>
      __$$WalletChainsImplCopyWithImpl<_$WalletChainsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletChainsImplToJson(
      this,
    );
  }
}

abstract class _WalletChains implements WalletChains {
  const factory _WalletChains(
          {@JsonKey(name: "chain_id") required final int chainId,
          @JsonKey(name: "chain_type") required final String chainType,
          @JsonKey(name: "chain_name") required final String chainName,
          @JsonKey(name: "logo_url") required final String logoUrl,
          @JsonKey(name: "explorer") required final String explorer}) =
      _$WalletChainsImpl;

  factory _WalletChains.fromJson(Map<String, dynamic> json) =
      _$WalletChainsImpl.fromJson;

  @override
  @JsonKey(name: "chain_id")
  int get chainId;
  @override
  @JsonKey(name: "chain_type")
  String get chainType;
  @override
  @JsonKey(name: "chain_name")
  String get chainName;
  @override
  @JsonKey(name: "logo_url")
  String get logoUrl;
  @override
  @JsonKey(name: "explorer")
  String get explorer;

  /// Create a copy of WalletChains
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletChainsImplCopyWith<_$WalletChainsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
