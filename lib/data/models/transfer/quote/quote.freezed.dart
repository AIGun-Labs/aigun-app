// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferQuote _$TransferQuoteFromJson(Map<String, dynamic> json) {
  return _TransferQuote.fromJson(json);
}

/// @nodoc
mixin _$TransferQuote {
  @JsonKey(name: "input_mint")
  String? get inputMint => throw _privateConstructorUsedError;
  @JsonKey(name: "in_amount")
  String? get inAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "in_usd_value")
  String? get inUsdValue => throw _privateConstructorUsedError;
  @JsonKey(name: "output_mint")
  String? get outputMint => throw _privateConstructorUsedError;
  @JsonKey(name: "out_usd_value")
  int? get outUsdValue => throw _privateConstructorUsedError;
  @JsonKey(name: "gas_fee")
  int? get gasFee => throw _privateConstructorUsedError;
  @JsonKey(name: "impact_price")
  int? get impactPrice => throw _privateConstructorUsedError;

  /// Serializes this TransferQuote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferQuoteCopyWith<TransferQuote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferQuoteCopyWith<$Res> {
  factory $TransferQuoteCopyWith(
          TransferQuote value, $Res Function(TransferQuote) then) =
      _$TransferQuoteCopyWithImpl<$Res, TransferQuote>;
  @useResult
  $Res call(
      {@JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "in_amount") String? inAmount,
      @JsonKey(name: "in_usd_value") String? inUsdValue,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "out_usd_value") int? outUsdValue,
      @JsonKey(name: "gas_fee") int? gasFee,
      @JsonKey(name: "impact_price") int? impactPrice});
}

/// @nodoc
class _$TransferQuoteCopyWithImpl<$Res, $Val extends TransferQuote>
    implements $TransferQuoteCopyWith<$Res> {
  _$TransferQuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = freezed,
    Object? inAmount = freezed,
    Object? inUsdValue = freezed,
    Object? outputMint = freezed,
    Object? outUsdValue = freezed,
    Object? gasFee = freezed,
    Object? impactPrice = freezed,
  }) {
    return _then(_value.copyWith(
      inputMint: freezed == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      inAmount: freezed == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      inUsdValue: freezed == inUsdValue
          ? _value.inUsdValue
          : inUsdValue // ignore: cast_nullable_to_non_nullable
              as String?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outUsdValue: freezed == outUsdValue
          ? _value.outUsdValue
          : outUsdValue // ignore: cast_nullable_to_non_nullable
              as int?,
      gasFee: freezed == gasFee
          ? _value.gasFee
          : gasFee // ignore: cast_nullable_to_non_nullable
              as int?,
      impactPrice: freezed == impactPrice
          ? _value.impactPrice
          : impactPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferQuoteImplCopyWith<$Res>
    implements $TransferQuoteCopyWith<$Res> {
  factory _$$TransferQuoteImplCopyWith(
          _$TransferQuoteImpl value, $Res Function(_$TransferQuoteImpl) then) =
      __$$TransferQuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "in_amount") String? inAmount,
      @JsonKey(name: "in_usd_value") String? inUsdValue,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "out_usd_value") int? outUsdValue,
      @JsonKey(name: "gas_fee") int? gasFee,
      @JsonKey(name: "impact_price") int? impactPrice});
}

/// @nodoc
class __$$TransferQuoteImplCopyWithImpl<$Res>
    extends _$TransferQuoteCopyWithImpl<$Res, _$TransferQuoteImpl>
    implements _$$TransferQuoteImplCopyWith<$Res> {
  __$$TransferQuoteImplCopyWithImpl(
      _$TransferQuoteImpl _value, $Res Function(_$TransferQuoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = freezed,
    Object? inAmount = freezed,
    Object? inUsdValue = freezed,
    Object? outputMint = freezed,
    Object? outUsdValue = freezed,
    Object? gasFee = freezed,
    Object? impactPrice = freezed,
  }) {
    return _then(_$TransferQuoteImpl(
      inputMint: freezed == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      inAmount: freezed == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      inUsdValue: freezed == inUsdValue
          ? _value.inUsdValue
          : inUsdValue // ignore: cast_nullable_to_non_nullable
              as String?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outUsdValue: freezed == outUsdValue
          ? _value.outUsdValue
          : outUsdValue // ignore: cast_nullable_to_non_nullable
              as int?,
      gasFee: freezed == gasFee
          ? _value.gasFee
          : gasFee // ignore: cast_nullable_to_non_nullable
              as int?,
      impactPrice: freezed == impactPrice
          ? _value.impactPrice
          : impactPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferQuoteImpl implements _TransferQuote {
  const _$TransferQuoteImpl(
      {@JsonKey(name: "input_mint") this.inputMint,
      @JsonKey(name: "in_amount") this.inAmount,
      @JsonKey(name: "in_usd_value") this.inUsdValue,
      @JsonKey(name: "output_mint") this.outputMint,
      @JsonKey(name: "out_usd_value") this.outUsdValue,
      @JsonKey(name: "gas_fee") this.gasFee,
      @JsonKey(name: "impact_price") this.impactPrice});

  factory _$TransferQuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferQuoteImplFromJson(json);

  @override
  @JsonKey(name: "input_mint")
  final String? inputMint;
  @override
  @JsonKey(name: "in_amount")
  final String? inAmount;
  @override
  @JsonKey(name: "in_usd_value")
  final String? inUsdValue;
  @override
  @JsonKey(name: "output_mint")
  final String? outputMint;
  @override
  @JsonKey(name: "out_usd_value")
  final int? outUsdValue;
  @override
  @JsonKey(name: "gas_fee")
  final int? gasFee;
  @override
  @JsonKey(name: "impact_price")
  final int? impactPrice;

  @override
  String toString() {
    return 'TransferQuote(inputMint: $inputMint, inAmount: $inAmount, inUsdValue: $inUsdValue, outputMint: $outputMint, outUsdValue: $outUsdValue, gasFee: $gasFee, impactPrice: $impactPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferQuoteImpl &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.inUsdValue, inUsdValue) ||
                other.inUsdValue == inUsdValue) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.outUsdValue, outUsdValue) ||
                other.outUsdValue == outUsdValue) &&
            (identical(other.gasFee, gasFee) || other.gasFee == gasFee) &&
            (identical(other.impactPrice, impactPrice) ||
                other.impactPrice == impactPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inputMint, inAmount, inUsdValue,
      outputMint, outUsdValue, gasFee, impactPrice);

  /// Create a copy of TransferQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferQuoteImplCopyWith<_$TransferQuoteImpl> get copyWith =>
      __$$TransferQuoteImplCopyWithImpl<_$TransferQuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferQuoteImplToJson(
      this,
    );
  }
}

abstract class _TransferQuote implements TransferQuote {
  const factory _TransferQuote(
          {@JsonKey(name: "input_mint") final String? inputMint,
          @JsonKey(name: "in_amount") final String? inAmount,
          @JsonKey(name: "in_usd_value") final String? inUsdValue,
          @JsonKey(name: "output_mint") final String? outputMint,
          @JsonKey(name: "out_usd_value") final int? outUsdValue,
          @JsonKey(name: "gas_fee") final int? gasFee,
          @JsonKey(name: "impact_price") final int? impactPrice}) =
      _$TransferQuoteImpl;

  factory _TransferQuote.fromJson(Map<String, dynamic> json) =
      _$TransferQuoteImpl.fromJson;

  @override
  @JsonKey(name: "input_mint")
  String? get inputMint;
  @override
  @JsonKey(name: "in_amount")
  String? get inAmount;
  @override
  @JsonKey(name: "in_usd_value")
  String? get inUsdValue;
  @override
  @JsonKey(name: "output_mint")
  String? get outputMint;
  @override
  @JsonKey(name: "out_usd_value")
  int? get outUsdValue;
  @override
  @JsonKey(name: "gas_fee")
  int? get gasFee;
  @override
  @JsonKey(name: "impact_price")
  int? get impactPrice;

  /// Create a copy of TransferQuote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferQuoteImplCopyWith<_$TransferQuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
