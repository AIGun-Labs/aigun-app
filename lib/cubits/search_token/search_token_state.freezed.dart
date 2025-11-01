// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchTokenState {
  List<Token> get matchedTokens => throw _privateConstructorUsedError;
  String get searchKeyword => throw _privateConstructorUsedError;
  SearchTokenStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchTokenStateCopyWith<SearchTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchTokenStateCopyWith<$Res> {
  factory $SearchTokenStateCopyWith(
          SearchTokenState value, $Res Function(SearchTokenState) then) =
      _$SearchTokenStateCopyWithImpl<$Res, SearchTokenState>;
  @useResult
  $Res call(
      {List<Token> matchedTokens,
      String searchKeyword,
      SearchTokenStatus status});
}

/// @nodoc
class _$SearchTokenStateCopyWithImpl<$Res, $Val extends SearchTokenState>
    implements $SearchTokenStateCopyWith<$Res> {
  _$SearchTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchedTokens = null,
    Object? searchKeyword = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      matchedTokens: null == matchedTokens
          ? _value.matchedTokens
          : matchedTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchTokenStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchTokenStateImplCopyWith<$Res>
    implements $SearchTokenStateCopyWith<$Res> {
  factory _$$SearchTokenStateImplCopyWith(_$SearchTokenStateImpl value,
          $Res Function(_$SearchTokenStateImpl) then) =
      __$$SearchTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Token> matchedTokens,
      String searchKeyword,
      SearchTokenStatus status});
}

/// @nodoc
class __$$SearchTokenStateImplCopyWithImpl<$Res>
    extends _$SearchTokenStateCopyWithImpl<$Res, _$SearchTokenStateImpl>
    implements _$$SearchTokenStateImplCopyWith<$Res> {
  __$$SearchTokenStateImplCopyWithImpl(_$SearchTokenStateImpl _value,
      $Res Function(_$SearchTokenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchedTokens = null,
    Object? searchKeyword = null,
    Object? status = null,
  }) {
    return _then(_$SearchTokenStateImpl(
      matchedTokens: null == matchedTokens
          ? _value._matchedTokens
          : matchedTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchTokenStatus,
    ));
  }
}

/// @nodoc

class _$SearchTokenStateImpl implements _SearchTokenState {
  const _$SearchTokenStateImpl(
      {final List<Token> matchedTokens = const [],
      this.searchKeyword = '',
      this.status = SearchTokenStatus.initial})
      : _matchedTokens = matchedTokens;

  final List<Token> _matchedTokens;
  @override
  @JsonKey()
  List<Token> get matchedTokens {
    if (_matchedTokens is EqualUnmodifiableListView) return _matchedTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchedTokens);
  }

  @override
  @JsonKey()
  final String searchKeyword;
  @override
  @JsonKey()
  final SearchTokenStatus status;

  @override
  String toString() {
    return 'SearchTokenState(matchedTokens: $matchedTokens, searchKeyword: $searchKeyword, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTokenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._matchedTokens, _matchedTokens) &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_matchedTokens),
      searchKeyword,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTokenStateImplCopyWith<_$SearchTokenStateImpl> get copyWith =>
      __$$SearchTokenStateImplCopyWithImpl<_$SearchTokenStateImpl>(
          this, _$identity);
}

abstract class _SearchTokenState implements SearchTokenState {
  const factory _SearchTokenState(
      {final List<Token> matchedTokens,
      final String searchKeyword,
      final SearchTokenStatus status}) = _$SearchTokenStateImpl;

  @override
  List<Token> get matchedTokens;
  @override
  String get searchKeyword;
  @override
  SearchTokenStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$SearchTokenStateImplCopyWith<_$SearchTokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
