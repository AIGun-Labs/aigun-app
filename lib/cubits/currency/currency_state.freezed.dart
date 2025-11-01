// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrencyState {
  Currency get selectedCurrency => throw _privateConstructorUsedError;
  Map<String, double> get exchangeRates => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrencyStateCopyWith<CurrencyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyStateCopyWith<$Res> {
  factory $CurrencyStateCopyWith(
          CurrencyState value, $Res Function(CurrencyState) then) =
      _$CurrencyStateCopyWithImpl<$Res, CurrencyState>;
  @useResult
  $Res call(
      {Currency selectedCurrency,
      Map<String, double> exchangeRates,
      bool isLoading,
      String? error});
}

/// @nodoc
class _$CurrencyStateCopyWithImpl<$Res, $Val extends CurrencyState>
    implements $CurrencyStateCopyWith<$Res> {
  _$CurrencyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCurrency = null,
    Object? exchangeRates = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      selectedCurrency: null == selectedCurrency
          ? _value.selectedCurrency
          : selectedCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      exchangeRates: null == exchangeRates
          ? _value.exchangeRates
          : exchangeRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrencyStateImplCopyWith<$Res>
    implements $CurrencyStateCopyWith<$Res> {
  factory _$$CurrencyStateImplCopyWith(
          _$CurrencyStateImpl value, $Res Function(_$CurrencyStateImpl) then) =
      __$$CurrencyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Currency selectedCurrency,
      Map<String, double> exchangeRates,
      bool isLoading,
      String? error});
}

/// @nodoc
class __$$CurrencyStateImplCopyWithImpl<$Res>
    extends _$CurrencyStateCopyWithImpl<$Res, _$CurrencyStateImpl>
    implements _$$CurrencyStateImplCopyWith<$Res> {
  __$$CurrencyStateImplCopyWithImpl(
      _$CurrencyStateImpl _value, $Res Function(_$CurrencyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCurrency = null,
    Object? exchangeRates = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$CurrencyStateImpl(
      selectedCurrency: null == selectedCurrency
          ? _value.selectedCurrency
          : selectedCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      exchangeRates: null == exchangeRates
          ? _value._exchangeRates
          : exchangeRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CurrencyStateImpl implements _CurrencyState {
  const _$CurrencyStateImpl(
      {this.selectedCurrency = CommonCurrencies,
      final Map<String, double> exchangeRates = const {},
      this.isLoading = false,
      this.error})
      : _exchangeRates = exchangeRates;

  @override
  @JsonKey()
  final Currency selectedCurrency;
  final Map<String, double> _exchangeRates;
  @override
  @JsonKey()
  Map<String, double> get exchangeRates {
    if (_exchangeRates is EqualUnmodifiableMapView) return _exchangeRates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exchangeRates);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'CurrencyState(selectedCurrency: $selectedCurrency, exchangeRates: $exchangeRates, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyStateImpl &&
            (identical(other.selectedCurrency, selectedCurrency) ||
                other.selectedCurrency == selectedCurrency) &&
            const DeepCollectionEquality()
                .equals(other._exchangeRates, _exchangeRates) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedCurrency,
      const DeepCollectionEquality().hash(_exchangeRates), isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyStateImplCopyWith<_$CurrencyStateImpl> get copyWith =>
      __$$CurrencyStateImplCopyWithImpl<_$CurrencyStateImpl>(this, _$identity);
}

abstract class _CurrencyState implements CurrencyState {
  const factory _CurrencyState(
      {final Currency selectedCurrency,
      final Map<String, double> exchangeRates,
      final bool isLoading,
      final String? error}) = _$CurrencyStateImpl;

  @override
  Currency get selectedCurrency;
  @override
  Map<String, double> get exchangeRates;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$CurrencyStateImplCopyWith<_$CurrencyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
