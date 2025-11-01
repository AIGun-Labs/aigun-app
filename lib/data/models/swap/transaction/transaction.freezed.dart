// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SwapTransaction _$SwapTransactionFromJson(Map<String, dynamic> json) {
  return _SwapTransaction.fromJson(json);
}

/// @nodoc
mixin _$SwapTransaction {
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "tx_hash")
  String? get txHash => throw _privateConstructorUsedError;
  @JsonKey(name: "tx_url")
  String? get txUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapTransactionCopyWith<SwapTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapTransactionCopyWith<$Res> {
  factory $SwapTransactionCopyWith(
          SwapTransaction value, $Res Function(SwapTransaction) then) =
      _$SwapTransactionCopyWithImpl<$Res, SwapTransaction>;
  @useResult
  $Res call(
      {@JsonKey(name: "type") String? type,
      @JsonKey(name: "tx_hash") String? txHash,
      @JsonKey(name: "tx_url") String? txUrl,
      @JsonKey(name: "status") String? status});
}

/// @nodoc
class _$SwapTransactionCopyWithImpl<$Res, $Val extends SwapTransaction>
    implements $SwapTransactionCopyWith<$Res> {
  _$SwapTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? txHash = freezed,
    Object? txUrl = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      txUrl: freezed == txUrl
          ? _value.txUrl
          : txUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwapTransactionImplCopyWith<$Res>
    implements $SwapTransactionCopyWith<$Res> {
  factory _$$SwapTransactionImplCopyWith(_$SwapTransactionImpl value,
          $Res Function(_$SwapTransactionImpl) then) =
      __$$SwapTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "type") String? type,
      @JsonKey(name: "tx_hash") String? txHash,
      @JsonKey(name: "tx_url") String? txUrl,
      @JsonKey(name: "status") String? status});
}

/// @nodoc
class __$$SwapTransactionImplCopyWithImpl<$Res>
    extends _$SwapTransactionCopyWithImpl<$Res, _$SwapTransactionImpl>
    implements _$$SwapTransactionImplCopyWith<$Res> {
  __$$SwapTransactionImplCopyWithImpl(
      _$SwapTransactionImpl _value, $Res Function(_$SwapTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? txHash = freezed,
    Object? txUrl = freezed,
    Object? status = freezed,
  }) {
    return _then(_$SwapTransactionImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      txUrl: freezed == txUrl
          ? _value.txUrl
          : txUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwapTransactionImpl implements _SwapTransaction {
  const _$SwapTransactionImpl(
      {@JsonKey(name: "type") this.type,
      @JsonKey(name: "tx_hash") this.txHash,
      @JsonKey(name: "tx_url") this.txUrl,
      @JsonKey(name: "status") this.status});

  factory _$SwapTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwapTransactionImplFromJson(json);

  @override
  @JsonKey(name: "type")
  final String? type;
  @override
  @JsonKey(name: "tx_hash")
  final String? txHash;
  @override
  @JsonKey(name: "tx_url")
  final String? txUrl;
  @override
  @JsonKey(name: "status")
  final String? status;

  @override
  String toString() {
    return 'SwapTransaction(type: $type, txHash: $txHash, txUrl: $txUrl, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapTransactionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.txUrl, txUrl) || other.txUrl == txUrl) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, txHash, txUrl, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapTransactionImplCopyWith<_$SwapTransactionImpl> get copyWith =>
      __$$SwapTransactionImplCopyWithImpl<_$SwapTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapTransactionImplToJson(
      this,
    );
  }
}

abstract class _SwapTransaction implements SwapTransaction {
  const factory _SwapTransaction(
      {@JsonKey(name: "type") final String? type,
      @JsonKey(name: "tx_hash") final String? txHash,
      @JsonKey(name: "tx_url") final String? txUrl,
      @JsonKey(name: "status") final String? status}) = _$SwapTransactionImpl;

  factory _SwapTransaction.fromJson(Map<String, dynamic> json) =
      _$SwapTransactionImpl.fromJson;

  @override
  @JsonKey(name: "type")
  String? get type;
  @override
  @JsonKey(name: "tx_hash")
  String? get txHash;
  @override
  @JsonKey(name: "tx_url")
  String? get txUrl;
  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$SwapTransactionImplCopyWith<_$SwapTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
