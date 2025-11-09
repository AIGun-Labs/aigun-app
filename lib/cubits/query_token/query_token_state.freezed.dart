// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QueryTokenState {
  QueryTokenStatus get status => throw _privateConstructorUsedError;
  List<QueryToken> get tokens => throw _privateConstructorUsedError;
  String? get keyword => throw _privateConstructorUsedError;
  QueryToken? get queryToken => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get noData => throw _privateConstructorUsedError;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryTokenStateCopyWith<QueryTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryTokenStateCopyWith<$Res> {
  factory $QueryTokenStateCopyWith(
          QueryTokenState value, $Res Function(QueryTokenState) then) =
      _$QueryTokenStateCopyWithImpl<$Res, QueryTokenState>;
  @useResult
  $Res call(
      {QueryTokenStatus status,
      List<QueryToken> tokens,
      String? keyword,
      QueryToken? queryToken,
      bool isLoading,
      bool noData});

  $QueryTokenCopyWith<$Res>? get queryToken;
}

/// @nodoc
class _$QueryTokenStateCopyWithImpl<$Res, $Val extends QueryTokenState>
    implements $QueryTokenStateCopyWith<$Res> {
  _$QueryTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tokens = null,
    Object? keyword = freezed,
    Object? queryToken = freezed,
    Object? isLoading = null,
    Object? noData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueryTokenStatus,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<QueryToken>,
      keyword: freezed == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String?,
      queryToken: freezed == queryToken
          ? _value.queryToken
          : queryToken // ignore: cast_nullable_to_non_nullable
              as QueryToken?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      noData: null == noData
          ? _value.noData
          : noData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueryTokenCopyWith<$Res>? get queryToken {
    if (_value.queryToken == null) {
      return null;
    }

    return $QueryTokenCopyWith<$Res>(_value.queryToken!, (value) {
      return _then(_value.copyWith(queryToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueryTokenStateImplCopyWith<$Res>
    implements $QueryTokenStateCopyWith<$Res> {
  factory _$$QueryTokenStateImplCopyWith(_$QueryTokenStateImpl value,
          $Res Function(_$QueryTokenStateImpl) then) =
      __$$QueryTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QueryTokenStatus status,
      List<QueryToken> tokens,
      String? keyword,
      QueryToken? queryToken,
      bool isLoading,
      bool noData});

  @override
  $QueryTokenCopyWith<$Res>? get queryToken;
}

/// @nodoc
class __$$QueryTokenStateImplCopyWithImpl<$Res>
    extends _$QueryTokenStateCopyWithImpl<$Res, _$QueryTokenStateImpl>
    implements _$$QueryTokenStateImplCopyWith<$Res> {
  __$$QueryTokenStateImplCopyWithImpl(
      _$QueryTokenStateImpl _value, $Res Function(_$QueryTokenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tokens = null,
    Object? keyword = freezed,
    Object? queryToken = freezed,
    Object? isLoading = null,
    Object? noData = null,
  }) {
    return _then(_$QueryTokenStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueryTokenStatus,
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<QueryToken>,
      keyword: freezed == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String?,
      queryToken: freezed == queryToken
          ? _value.queryToken
          : queryToken // ignore: cast_nullable_to_non_nullable
              as QueryToken?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      noData: null == noData
          ? _value.noData
          : noData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$QueryTokenStateImpl implements _QueryTokenState {
  const _$QueryTokenStateImpl(
      {this.status = QueryTokenStatus.initial,
      final List<QueryToken> tokens = const [],
      this.keyword = null,
      this.queryToken = null,
      this.isLoading = false,
      this.noData = false})
      : _tokens = tokens;

  @override
  @JsonKey()
  final QueryTokenStatus status;
  final List<QueryToken> _tokens;
  @override
  @JsonKey()
  List<QueryToken> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  @JsonKey()
  final String? keyword;
  @override
  @JsonKey()
  final QueryToken? queryToken;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool noData;

  @override
  String toString() {
    return 'QueryTokenState(status: $status, tokens: $tokens, keyword: $keyword, queryToken: $queryToken, isLoading: $isLoading, noData: $noData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryTokenStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.queryToken, queryToken) ||
                other.queryToken == queryToken) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.noData, noData) || other.noData == noData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_tokens),
      keyword,
      queryToken,
      isLoading,
      noData);

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryTokenStateImplCopyWith<_$QueryTokenStateImpl> get copyWith =>
      __$$QueryTokenStateImplCopyWithImpl<_$QueryTokenStateImpl>(
          this, _$identity);
}

abstract class _QueryTokenState implements QueryTokenState {
  const factory _QueryTokenState(
      {final QueryTokenStatus status,
      final List<QueryToken> tokens,
      final String? keyword,
      final QueryToken? queryToken,
      final bool isLoading,
      final bool noData}) = _$QueryTokenStateImpl;

  @override
  QueryTokenStatus get status;
  @override
  List<QueryToken> get tokens;
  @override
  String? get keyword;
  @override
  QueryToken? get queryToken;
  @override
  bool get isLoading;
  @override
  bool get noData;

  /// Create a copy of QueryTokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryTokenStateImplCopyWith<_$QueryTokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
