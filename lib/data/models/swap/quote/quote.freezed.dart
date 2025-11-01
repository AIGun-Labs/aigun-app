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

SwapQuote _$SwapQuoteFromJson(Map<String, dynamic> json) {
  return _SwapQuote.fromJson(json);
}

/// @nodoc
mixin _$SwapQuote {
  @JsonKey(name: "input_mint")
  String? get inputMint => throw _privateConstructorUsedError; // 输入代币
  @JsonKey(name: "in_amount")
  String? get inAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "in_usd_value")
  double? get inUsdValue => throw _privateConstructorUsedError;
  @JsonKey(name: "output_mint")
  String? get outputMint => throw _privateConstructorUsedError;
  @JsonKey(name: "out_amount")
  String? get outAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "out_usd_value")
  double? get outUsdValue => throw _privateConstructorUsedError;
  @JsonKey(name: "gas_fee")
  String? get gasFee => throw _privateConstructorUsedError;
  @JsonKey(name: "impact_price")
  String? get impactPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapQuoteCopyWith<SwapQuote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapQuoteCopyWith<$Res> {
  factory $SwapQuoteCopyWith(SwapQuote value, $Res Function(SwapQuote) then) =
      _$SwapQuoteCopyWithImpl<$Res, SwapQuote>;
  @useResult
  $Res call(
      {@JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "in_amount") String? inAmount,
      @JsonKey(name: "in_usd_value") double? inUsdValue,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "out_amount") String? outAmount,
      @JsonKey(name: "out_usd_value") double? outUsdValue,
      @JsonKey(name: "gas_fee") String? gasFee,
      @JsonKey(name: "impact_price") String? impactPrice});
}

/// @nodoc
class _$SwapQuoteCopyWithImpl<$Res, $Val extends SwapQuote>
    implements $SwapQuoteCopyWith<$Res> {
  _$SwapQuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = freezed,
    Object? inAmount = freezed,
    Object? inUsdValue = freezed,
    Object? outputMint = freezed,
    Object? outAmount = freezed,
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
              as double?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outAmount: freezed == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      outUsdValue: freezed == outUsdValue
          ? _value.outUsdValue
          : outUsdValue // ignore: cast_nullable_to_non_nullable
              as double?,
      gasFee: freezed == gasFee
          ? _value.gasFee
          : gasFee // ignore: cast_nullable_to_non_nullable
              as String?,
      impactPrice: freezed == impactPrice
          ? _value.impactPrice
          : impactPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwapQuoteImplCopyWith<$Res>
    implements $SwapQuoteCopyWith<$Res> {
  factory _$$SwapQuoteImplCopyWith(
          _$SwapQuoteImpl value, $Res Function(_$SwapQuoteImpl) then) =
      __$$SwapQuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "input_mint") String? inputMint,
      @JsonKey(name: "in_amount") String? inAmount,
      @JsonKey(name: "in_usd_value") double? inUsdValue,
      @JsonKey(name: "output_mint") String? outputMint,
      @JsonKey(name: "out_amount") String? outAmount,
      @JsonKey(name: "out_usd_value") double? outUsdValue,
      @JsonKey(name: "gas_fee") String? gasFee,
      @JsonKey(name: "impact_price") String? impactPrice});
}

/// @nodoc
class __$$SwapQuoteImplCopyWithImpl<$Res>
    extends _$SwapQuoteCopyWithImpl<$Res, _$SwapQuoteImpl>
    implements _$$SwapQuoteImplCopyWith<$Res> {
  __$$SwapQuoteImplCopyWithImpl(
      _$SwapQuoteImpl _value, $Res Function(_$SwapQuoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = freezed,
    Object? inAmount = freezed,
    Object? inUsdValue = freezed,
    Object? outputMint = freezed,
    Object? outAmount = freezed,
    Object? outUsdValue = freezed,
    Object? gasFee = freezed,
    Object? impactPrice = freezed,
  }) {
    return _then(_$SwapQuoteImpl(
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
              as double?,
      outputMint: freezed == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String?,
      outAmount: freezed == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      outUsdValue: freezed == outUsdValue
          ? _value.outUsdValue
          : outUsdValue // ignore: cast_nullable_to_non_nullable
              as double?,
      gasFee: freezed == gasFee
          ? _value.gasFee
          : gasFee // ignore: cast_nullable_to_non_nullable
              as String?,
      impactPrice: freezed == impactPrice
          ? _value.impactPrice
          : impactPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwapQuoteImpl implements _SwapQuote {
  const _$SwapQuoteImpl(
      {@JsonKey(name: "input_mint") this.inputMint,
      @JsonKey(name: "in_amount") this.inAmount,
      @JsonKey(name: "in_usd_value") this.inUsdValue,
      @JsonKey(name: "output_mint") this.outputMint,
      @JsonKey(name: "out_amount") this.outAmount,
      @JsonKey(name: "out_usd_value") this.outUsdValue,
      @JsonKey(name: "gas_fee") this.gasFee,
      @JsonKey(name: "impact_price") this.impactPrice});

  factory _$SwapQuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwapQuoteImplFromJson(json);

  @override
  @JsonKey(name: "input_mint")
  final String? inputMint;
// 输入代币
  @override
  @JsonKey(name: "in_amount")
  final String? inAmount;
  @override
  @JsonKey(name: "in_usd_value")
  final double? inUsdValue;
  @override
  @JsonKey(name: "output_mint")
  final String? outputMint;
  @override
  @JsonKey(name: "out_amount")
  final String? outAmount;
  @override
  @JsonKey(name: "out_usd_value")
  final double? outUsdValue;
  @override
  @JsonKey(name: "gas_fee")
  final String? gasFee;
  @override
  @JsonKey(name: "impact_price")
  final String? impactPrice;

  @override
  String toString() {
    return 'SwapQuote(inputMint: $inputMint, inAmount: $inAmount, inUsdValue: $inUsdValue, outputMint: $outputMint, outAmount: $outAmount, outUsdValue: $outUsdValue, gasFee: $gasFee, impactPrice: $impactPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapQuoteImpl &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.inUsdValue, inUsdValue) ||
                other.inUsdValue == inUsdValue) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.outUsdValue, outUsdValue) ||
                other.outUsdValue == outUsdValue) &&
            (identical(other.gasFee, gasFee) || other.gasFee == gasFee) &&
            (identical(other.impactPrice, impactPrice) ||
                other.impactPrice == impactPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inputMint, inAmount, inUsdValue,
      outputMint, outAmount, outUsdValue, gasFee, impactPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapQuoteImplCopyWith<_$SwapQuoteImpl> get copyWith =>
      __$$SwapQuoteImplCopyWithImpl<_$SwapQuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapQuoteImplToJson(
      this,
    );
  }
}

abstract class _SwapQuote implements SwapQuote {
  const factory _SwapQuote(
          {@JsonKey(name: "input_mint") final String? inputMint,
          @JsonKey(name: "in_amount") final String? inAmount,
          @JsonKey(name: "in_usd_value") final double? inUsdValue,
          @JsonKey(name: "output_mint") final String? outputMint,
          @JsonKey(name: "out_amount") final String? outAmount,
          @JsonKey(name: "out_usd_value") final double? outUsdValue,
          @JsonKey(name: "gas_fee") final String? gasFee,
          @JsonKey(name: "impact_price") final String? impactPrice}) =
      _$SwapQuoteImpl;

  factory _SwapQuote.fromJson(Map<String, dynamic> json) =
      _$SwapQuoteImpl.fromJson;

  @override
  @JsonKey(name: "input_mint")
  String? get inputMint;
  @override // 输入代币
  @JsonKey(name: "in_amount")
  String? get inAmount;
  @override
  @JsonKey(name: "in_usd_value")
  double? get inUsdValue;
  @override
  @JsonKey(name: "output_mint")
  String? get outputMint;
  @override
  @JsonKey(name: "out_amount")
  String? get outAmount;
  @override
  @JsonKey(name: "out_usd_value")
  double? get outUsdValue;
  @override
  @JsonKey(name: "gas_fee")
  String? get gasFee;
  @override
  @JsonKey(name: "impact_price")
  String? get impactPrice;
  @override
  @JsonKey(ignore: true)
  _$$SwapQuoteImplCopyWith<_$SwapQuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
