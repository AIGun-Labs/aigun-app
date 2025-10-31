// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'networks_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworksEntity {
  Map<String, String> get networks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworksEntityCopyWith<NetworksEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworksEntityCopyWith<$Res> {
  factory $NetworksEntityCopyWith(
          NetworksEntity value, $Res Function(NetworksEntity) then) =
      _$NetworksEntityCopyWithImpl<$Res, NetworksEntity>;
  @useResult
  $Res call({Map<String, String> networks});
}

/// @nodoc
class _$NetworksEntityCopyWithImpl<$Res, $Val extends NetworksEntity>
    implements $NetworksEntityCopyWith<$Res> {
  _$NetworksEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
  }) {
    return _then(_value.copyWith(
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworksEntityImplCopyWith<$Res>
    implements $NetworksEntityCopyWith<$Res> {
  factory _$$NetworksEntityImplCopyWith(_$NetworksEntityImpl value,
          $Res Function(_$NetworksEntityImpl) then) =
      __$$NetworksEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> networks});
}

/// @nodoc
class __$$NetworksEntityImplCopyWithImpl<$Res>
    extends _$NetworksEntityCopyWithImpl<$Res, _$NetworksEntityImpl>
    implements _$$NetworksEntityImplCopyWith<$Res> {
  __$$NetworksEntityImplCopyWithImpl(
      _$NetworksEntityImpl _value, $Res Function(_$NetworksEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
  }) {
    return _then(_$NetworksEntityImpl(
      networks: null == networks
          ? _value._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$NetworksEntityImpl extends _NetworksEntity {
  const _$NetworksEntityImpl({required final Map<String, String> networks})
      : _networks = networks,
        super._();

  final Map<String, String> _networks;
  @override
  Map<String, String> get networks {
    if (_networks is EqualUnmodifiableMapView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_networks);
  }

  @override
  String toString() {
    return 'NetworksEntity(networks: $networks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworksEntityImpl &&
            const DeepCollectionEquality().equals(other._networks, _networks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_networks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworksEntityImplCopyWith<_$NetworksEntityImpl> get copyWith =>
      __$$NetworksEntityImplCopyWithImpl<_$NetworksEntityImpl>(
          this, _$identity);
}

abstract class _NetworksEntity extends NetworksEntity {
  const factory _NetworksEntity({required final Map<String, String> networks}) =
      _$NetworksEntityImpl;
  const _NetworksEntity._() : super._();

  @override
  Map<String, String> get networks;
  @override
  @JsonKey(ignore: true)
  _$$NetworksEntityImplCopyWith<_$NetworksEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
