// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferSwap _$TransferSwapFromJson(Map<String, dynamic> json) {
  return _TransferSwap.fromJson(json);
}

/// @nodoc
mixin _$TransferSwap {
  @JsonKey(name: "from_chain_id")
  int? get fromChainId => throw _privateConstructorUsedError;
  @JsonKey(name: "to_chain_id")
  int? get toChainId => throw _privateConstructorUsedError;
  @JsonKey(name: "input_mint")
  String? get inputMint => throw _privateConstructorUsedError;
  @JsonKey(name: "output_mint")
  String? get outputMint => throw _privateConstructorUsedError;
  @JsonKey(name: "amount")
  String? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: "wallet_id")
  String? get walletId => throw _privateConstructorUsedError;
  @JsonKey(name: "organization_id")
  String? get organizationId => throw _privateConstructorUsedError;
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId => throw _privateConstructorUsedError;

  /// Serializes this TransferSwap to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferSwap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferSwapCopyWith<TransferSwap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferSwapCopyWith<$Res> {
  factory $TransferSwapCopyWith(
          TransferSwap value, $Res Function(TransferSwap) then) =
      _$TransferSwapCopyWithImpl<$Res, TransferSwap>;
  @useResult
  $Res call(
      {@JsonKey(name: "from_chain_id") int? fromChainId,
      @JsonKey(name: "to_chain_id") int? toChainId,
      @JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "amount") String? amount,
      @JsonKey(name: "wallet_id") String? walletId,
      @JsonKey(name: "organization_id") String? organizationId,
      @JsonKey(name: "wallet_user_id") String? walletUserId});
}

/// @nodoc
class _$TransferSwapCopyWithImpl<$Res, $Val extends TransferSwap>
    implements $TransferSwapCopyWith<$Res> {
  _$TransferSwapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferSwap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromChainId = freezed,
    Object? toChainId = freezed,
    Object? inputMint = freezed,
    Object? outputMint = freezed,
    Object? amount = freezed,
    Object? walletId = freezed,
    Object? organizationId = freezed,
    Object? walletUserId = freezed,
  }) {
    return _then(_value.copyWith(
      fromChainId: freezed == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int?,
      toChainId: freezed == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as int?,
      inputMint: freezed == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUserId: freezed == walletUserId
          ? _value.walletUserId
          : walletUserId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferSwapImplCopyWith<$Res>
    implements $TransferSwapCopyWith<$Res> {
  factory _$$TransferSwapImplCopyWith(
          _$TransferSwapImpl value, $Res Function(_$TransferSwapImpl) then) =
      __$$TransferSwapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "from_chain_id") int? fromChainId,
      @JsonKey(name: "to_chain_id") int? toChainId,
      @JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "amount") String? amount,
      @JsonKey(name: "wallet_id") String? walletId,
      @JsonKey(name: "organization_id") String? organizationId,
      @JsonKey(name: "wallet_user_id") String? walletUserId});
}

/// @nodoc
class __$$TransferSwapImplCopyWithImpl<$Res>
    extends _$TransferSwapCopyWithImpl<$Res, _$TransferSwapImpl>
    implements _$$TransferSwapImplCopyWith<$Res> {
  __$$TransferSwapImplCopyWithImpl(
      _$TransferSwapImpl _value, $Res Function(_$TransferSwapImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferSwap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromChainId = freezed,
    Object? toChainId = freezed,
    Object? inputMint = freezed,
    Object? outputMint = freezed,
    Object? amount = freezed,
    Object? walletId = freezed,
    Object? organizationId = freezed,
    Object? walletUserId = freezed,
  }) {
    return _then(_$TransferSwapImpl(
      fromChainId: freezed == fromChainId
          ? _value.fromChainId
          : fromChainId // ignore: cast_nullable_to_non_nullable
              as int?,
      toChainId: freezed == toChainId
          ? _value.toChainId
          : toChainId // ignore: cast_nullable_to_non_nullable
              as int?,
      inputMint: freezed == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUserId: freezed == walletUserId
          ? _value.walletUserId
          : walletUserId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferSwapImpl implements _TransferSwap {
  const _$TransferSwapImpl(
      {@JsonKey(name: "from_chain_id") this.fromChainId,
      @JsonKey(name: "to_chain_id") this.toChainId,
      @JsonKey(name: "input_mint") this.inputMint,
      @JsonKey(name: "output_mint") this.outputMint,
      @JsonKey(name: "amount") this.amount,
      @JsonKey(name: "wallet_id") this.walletId,
      @JsonKey(name: "organization_id") this.organizationId,
      @JsonKey(name: "wallet_user_id") this.walletUserId});

  factory _$TransferSwapImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferSwapImplFromJson(json);

  @override
  @JsonKey(name: "from_chain_id")
  final int? fromChainId;
  @override
  @JsonKey(name: "to_chain_id")
  final int? toChainId;
  @override
  @JsonKey(name: "input_mint")
  final String? inputMint;
  @override
  @JsonKey(name: "output_mint")
  final String? outputMint;
  @override
  @JsonKey(name: "amount")
  final String? amount;
  @override
  @JsonKey(name: "wallet_id")
  final String? walletId;
  @override
  @JsonKey(name: "organization_id")
  final String? organizationId;
  @override
  @JsonKey(name: "wallet_user_id")
  final String? walletUserId;

  @override
  String toString() {
    return 'TransferSwap(fromChainId: $fromChainId, toChainId: $toChainId, inputMint: $inputMint, outputMint: $outputMint, amount: $amount, walletId: $walletId, organizationId: $organizationId, walletUserId: $walletUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferSwapImpl &&
            (identical(other.fromChainId, fromChainId) ||
                other.fromChainId == fromChainId) &&
            (identical(other.toChainId, toChainId) ||
                other.toChainId == toChainId) &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.walletUserId, walletUserId) ||
                other.walletUserId == walletUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fromChainId, toChainId,
      inputMint, outputMint, amount, walletId, organizationId, walletUserId);

  /// Create a copy of TransferSwap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferSwapImplCopyWith<_$TransferSwapImpl> get copyWith =>
      __$$TransferSwapImplCopyWithImpl<_$TransferSwapImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferSwapImplToJson(
      this,
    );
  }
}

abstract class _TransferSwap implements TransferSwap {
  const factory _TransferSwap(
          {@JsonKey(name: "from_chain_id") final int? fromChainId,
          @JsonKey(name: "to_chain_id") final int? toChainId,
          @JsonKey(name: "input_mint") final String? inputMint,
          @JsonKey(name: "output_mint") final String? outputMint,
          @JsonKey(name: "amount") final String? amount,
          @JsonKey(name: "wallet_id") final String? walletId,
          @JsonKey(name: "organization_id") final String? organizationId,
          @JsonKey(name: "wallet_user_id") final String? walletUserId}) =
      _$TransferSwapImpl;

  factory _TransferSwap.fromJson(Map<String, dynamic> json) =
      _$TransferSwapImpl.fromJson;

  @override
  @JsonKey(name: "from_chain_id")
  int? get fromChainId;
  @override
  @JsonKey(name: "to_chain_id")
  int? get toChainId;
  @override
  @JsonKey(name: "input_mint")
  String? get inputMint;
  @override
  @JsonKey(name: "output_mint")
  String? get outputMint;
  @override
  @JsonKey(name: "amount")
  String? get amount;
  @override
  @JsonKey(name: "wallet_id")
  String? get walletId;
  @override
  @JsonKey(name: "organization_id")
  String? get organizationId;
  @override
  @JsonKey(name: "wallet_user_id")
  String? get walletUserId;

  /// Create a copy of TransferSwap
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferSwapImplCopyWith<_$TransferSwapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
