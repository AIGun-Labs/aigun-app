// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TargetToken _$TargetTokenFromJson(Map<String, dynamic> json) {
  return _TargetToken.fromJson(json);
}

/// @nodoc
mixin _$TargetToken {
  @JsonKey(name: "chain_id")
  String? get chainId => throw _privateConstructorUsedError;
  @JsonKey(name: "token_name")
  String? get tokenName => throw _privateConstructorUsedError;
  @JsonKey(name: "token_address")
  String? get tokenAddress => throw _privateConstructorUsedError;
  @JsonKey(name: "token_avatar")
  String? get tokenAvatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TargetTokenCopyWith<TargetToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetTokenCopyWith<$Res> {
  factory $TargetTokenCopyWith(
          TargetToken value, $Res Function(TargetToken) then) =
      _$TargetTokenCopyWithImpl<$Res, TargetToken>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String? chainId,
      @JsonKey(name: "token_name") String? tokenName,
      @JsonKey(name: "token_address") String? tokenAddress,
      @JsonKey(name: "token_avatar") String? tokenAvatar});
}

/// @nodoc
class _$TargetTokenCopyWithImpl<$Res, $Val extends TargetToken>
    implements $TargetTokenCopyWith<$Res> {
  _$TargetTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = freezed,
    Object? tokenName = freezed,
    Object? tokenAddress = freezed,
    Object? tokenAvatar = freezed,
  }) {
    return _then(_value.copyWith(
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenName: freezed == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAvatar: freezed == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetTokenImplCopyWith<$Res>
    implements $TargetTokenCopyWith<$Res> {
  factory _$$TargetTokenImplCopyWith(
          _$TargetTokenImpl value, $Res Function(_$TargetTokenImpl) then) =
      __$$TargetTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String? chainId,
      @JsonKey(name: "token_name") String? tokenName,
      @JsonKey(name: "token_address") String? tokenAddress,
      @JsonKey(name: "token_avatar") String? tokenAvatar});
}

/// @nodoc
class __$$TargetTokenImplCopyWithImpl<$Res>
    extends _$TargetTokenCopyWithImpl<$Res, _$TargetTokenImpl>
    implements _$$TargetTokenImplCopyWith<$Res> {
  __$$TargetTokenImplCopyWithImpl(
      _$TargetTokenImpl _value, $Res Function(_$TargetTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = freezed,
    Object? tokenName = freezed,
    Object? tokenAddress = freezed,
    Object? tokenAvatar = freezed,
  }) {
    return _then(_$TargetTokenImpl(
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenName: freezed == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAvatar: freezed == tokenAvatar
          ? _value.tokenAvatar
          : tokenAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetTokenImpl implements _TargetToken {
  const _$TargetTokenImpl(
      {@JsonKey(name: "chain_id") required this.chainId,
      @JsonKey(name: "token_name") required this.tokenName,
      @JsonKey(name: "token_address") required this.tokenAddress,
      @JsonKey(name: "token_avatar") required this.tokenAvatar});

  factory _$TargetTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetTokenImplFromJson(json);

  @override
  @JsonKey(name: "chain_id")
  final String? chainId;
  @override
  @JsonKey(name: "token_name")
  final String? tokenName;
  @override
  @JsonKey(name: "token_address")
  final String? tokenAddress;
  @override
  @JsonKey(name: "token_avatar")
  final String? tokenAvatar;

  @override
  String toString() {
    return 'TargetToken(chainId: $chainId, tokenName: $tokenName, tokenAddress: $tokenAddress, tokenAvatar: $tokenAvatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetTokenImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.tokenAvatar, tokenAvatar) ||
                other.tokenAvatar == tokenAvatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, chainId, tokenName, tokenAddress, tokenAvatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetTokenImplCopyWith<_$TargetTokenImpl> get copyWith =>
      __$$TargetTokenImplCopyWithImpl<_$TargetTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetTokenImplToJson(
      this,
    );
  }
}

abstract class _TargetToken implements TargetToken {
  const factory _TargetToken(
          {@JsonKey(name: "chain_id") required final String? chainId,
          @JsonKey(name: "token_name") required final String? tokenName,
          @JsonKey(name: "token_address") required final String? tokenAddress,
          @JsonKey(name: "token_avatar") required final String? tokenAvatar}) =
      _$TargetTokenImpl;

  factory _TargetToken.fromJson(Map<String, dynamic> json) =
      _$TargetTokenImpl.fromJson;

  @override
  @JsonKey(name: "chain_id")
  String? get chainId;
  @override
  @JsonKey(name: "token_name")
  String? get tokenName;
  @override
  @JsonKey(name: "token_address")
  String? get tokenAddress;
  @override
  @JsonKey(name: "token_avatar")
  String? get tokenAvatar;
  @override
  @JsonKey(ignore: true)
  _$$TargetTokenImplCopyWith<_$TargetTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
