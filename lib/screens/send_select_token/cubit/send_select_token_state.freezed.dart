// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_select_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SendSelectTokenState {
  String get searchKeyword => throw _privateConstructorUsedError;
  List<Token> get filteredTokens => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SendSelectTokenStateCopyWith<SendSelectTokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendSelectTokenStateCopyWith<$Res> {
  factory $SendSelectTokenStateCopyWith(SendSelectTokenState value,
          $Res Function(SendSelectTokenState) then) =
      _$SendSelectTokenStateCopyWithImpl<$Res, SendSelectTokenState>;
  @useResult
  $Res call({String searchKeyword, List<Token> filteredTokens});
}

/// @nodoc
class _$SendSelectTokenStateCopyWithImpl<$Res,
        $Val extends SendSelectTokenState>
    implements $SendSelectTokenStateCopyWith<$Res> {
  _$SendSelectTokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchKeyword = null,
    Object? filteredTokens = null,
  }) {
    return _then(_value.copyWith(
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      filteredTokens: null == filteredTokens
          ? _value.filteredTokens
          : filteredTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendSelectTokenStateImplCopyWith<$Res>
    implements $SendSelectTokenStateCopyWith<$Res> {
  factory _$$SendSelectTokenStateImplCopyWith(_$SendSelectTokenStateImpl value,
          $Res Function(_$SendSelectTokenStateImpl) then) =
      __$$SendSelectTokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String searchKeyword, List<Token> filteredTokens});
}

/// @nodoc
class __$$SendSelectTokenStateImplCopyWithImpl<$Res>
    extends _$SendSelectTokenStateCopyWithImpl<$Res, _$SendSelectTokenStateImpl>
    implements _$$SendSelectTokenStateImplCopyWith<$Res> {
  __$$SendSelectTokenStateImplCopyWithImpl(_$SendSelectTokenStateImpl _value,
      $Res Function(_$SendSelectTokenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchKeyword = null,
    Object? filteredTokens = null,
  }) {
    return _then(_$SendSelectTokenStateImpl(
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      filteredTokens: null == filteredTokens
          ? _value._filteredTokens
          : filteredTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
    ));
  }
}

/// @nodoc

class _$SendSelectTokenStateImpl extends _SendSelectTokenState {
  const _$SendSelectTokenStateImpl(
      {this.searchKeyword = '', final List<Token> filteredTokens = const []})
      : _filteredTokens = filteredTokens,
        super._();

  @override
  @JsonKey()
  final String searchKeyword;
  final List<Token> _filteredTokens;
  @override
  @JsonKey()
  List<Token> get filteredTokens {
    if (_filteredTokens is EqualUnmodifiableListView) return _filteredTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTokens);
  }

  @override
  String toString() {
    return 'SendSelectTokenState(searchKeyword: $searchKeyword, filteredTokens: $filteredTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendSelectTokenStateImpl &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            const DeepCollectionEquality()
                .equals(other._filteredTokens, _filteredTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchKeyword,
      const DeepCollectionEquality().hash(_filteredTokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendSelectTokenStateImplCopyWith<_$SendSelectTokenStateImpl>
      get copyWith =>
          __$$SendSelectTokenStateImplCopyWithImpl<_$SendSelectTokenStateImpl>(
              this, _$identity);
}

abstract class _SendSelectTokenState extends SendSelectTokenState {
  const factory _SendSelectTokenState(
      {final String searchKeyword,
      final List<Token> filteredTokens}) = _$SendSelectTokenStateImpl;
  const _SendSelectTokenState._() : super._();

  @override
  String get searchKeyword;
  @override
  List<Token> get filteredTokens;
  @override
  @JsonKey(ignore: true)
  _$$SendSelectTokenStateImplCopyWith<_$SendSelectTokenStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
