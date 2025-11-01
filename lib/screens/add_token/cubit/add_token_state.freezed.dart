// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTokenState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get addressError => throw _privateConstructorUsedError;
  bool get chainError => throw _privateConstructorUsedError;
  String get tokenAddress =>
      throw _privateConstructorUsedError; // @Default('') String tokenSymbol,
// @Default('') String tokenName,
// @Default(0) int decimals,
// @Default('') String tokenType,
  String get chainId => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddTokenStateCopyWith<AddTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTokenStateCopyWith<$Res> {
  factory $AddTokenStateCopyWith(
          AddTokenState value, $Res Function(AddTokenState) then) =
      _$AddTokenStateCopyWithImpl<$Res, AddTokenState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool addressError,
      bool chainError,
      String tokenAddress,
      String chainId,
      bool isSuccess,
      bool isError});
}

/// @nodoc
class _$AddTokenStateCopyWithImpl<$Res, $Val extends AddTokenState>
    implements $AddTokenStateCopyWith<$Res> {
  _$AddTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addressError = null,
    Object? chainError = null,
    Object? tokenAddress = null,
    Object? chainId = null,
    Object? isSuccess = null,
    Object? isError = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addressError: null == addressError
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as bool,
      chainError: null == chainError
          ? _value.chainError
          : chainError // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTokenStateImplCopyWith<$Res>
    implements $AddTokenStateCopyWith<$Res> {
  factory _$$AddTokenStateImplCopyWith(
          _$AddTokenStateImpl value, $Res Function(_$AddTokenStateImpl) then) =
      __$$AddTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool addressError,
      bool chainError,
      String tokenAddress,
      String chainId,
      bool isSuccess,
      bool isError});
}

/// @nodoc
class __$$AddTokenStateImplCopyWithImpl<$Res>
    extends _$AddTokenStateCopyWithImpl<$Res, _$AddTokenStateImpl>
    implements _$$AddTokenStateImplCopyWith<$Res> {
  __$$AddTokenStateImplCopyWithImpl(
      _$AddTokenStateImpl _value, $Res Function(_$AddTokenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addressError = null,
    Object? chainError = null,
    Object? tokenAddress = null,
    Object? chainId = null,
    Object? isSuccess = null,
    Object? isError = null,
  }) {
    return _then(_$AddTokenStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addressError: null == addressError
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as bool,
      chainError: null == chainError
          ? _value.chainError
          : chainError // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddTokenStateImpl implements _AddTokenState {
  const _$AddTokenStateImpl(
      {this.isLoading = false,
      this.addressError = false,
      this.chainError = false,
      this.tokenAddress = '',
      this.chainId = '1',
      this.isSuccess = false,
      this.isError = false});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool addressError;
  @override
  @JsonKey()
  final bool chainError;
  @override
  @JsonKey()
  final String tokenAddress;
// @Default('') String tokenSymbol,
// @Default('') String tokenName,
// @Default(0) int decimals,
// @Default('') String tokenType,
  @override
  @JsonKey()
  final String chainId;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'AddTokenState(isLoading: $isLoading, addressError: $addressError, chainError: $chainError, tokenAddress: $tokenAddress, chainId: $chainId, isSuccess: $isSuccess, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTokenStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.addressError, addressError) ||
                other.addressError == addressError) &&
            (identical(other.chainError, chainError) ||
                other.chainError == chainError) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, addressError,
      chainError, tokenAddress, chainId, isSuccess, isError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTokenStateImplCopyWith<_$AddTokenStateImpl> get copyWith =>
      __$$AddTokenStateImplCopyWithImpl<_$AddTokenStateImpl>(this, _$identity);
}

abstract class _AddTokenState implements AddTokenState {
  const factory _AddTokenState(
      {final bool isLoading,
      final bool addressError,
      final bool chainError,
      final String tokenAddress,
      final String chainId,
      final bool isSuccess,
      final bool isError}) = _$AddTokenStateImpl;

  @override
  bool get isLoading;
  @override
  bool get addressError;
  @override
  bool get chainError;
  @override
  String get tokenAddress;
  @override // @Default('') String tokenSymbol,
// @Default('') String tokenName,
// @Default(0) int decimals,
// @Default('') String tokenType,
  String get chainId;
  @override
  bool get isSuccess;
  @override
  bool get isError;
  @override
  @JsonKey(ignore: true)
  _$$AddTokenStateImplCopyWith<_$AddTokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
