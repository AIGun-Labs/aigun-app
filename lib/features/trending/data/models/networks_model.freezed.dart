// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'networks_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NetworksModel _$NetworksModelFromJson(Map<String, dynamic> json) {
  return _NetworksModel.fromJson(json);
}

/// @nodoc
mixin _$NetworksModel {
  Map<String, String> get networks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworksModelCopyWith<NetworksModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworksModelCopyWith<$Res> {
  factory $NetworksModelCopyWith(
          NetworksModel value, $Res Function(NetworksModel) then) =
      _$NetworksModelCopyWithImpl<$Res, NetworksModel>;
  @useResult
  $Res call({Map<String, String> networks});
}

/// @nodoc
class _$NetworksModelCopyWithImpl<$Res, $Val extends NetworksModel>
    implements $NetworksModelCopyWith<$Res> {
  _$NetworksModelCopyWithImpl(this._value, this._then);

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
abstract class _$$NetworksModelImplCopyWith<$Res>
    implements $NetworksModelCopyWith<$Res> {
  factory _$$NetworksModelImplCopyWith(
          _$NetworksModelImpl value, $Res Function(_$NetworksModelImpl) then) =
      __$$NetworksModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> networks});
}

/// @nodoc
class __$$NetworksModelImplCopyWithImpl<$Res>
    extends _$NetworksModelCopyWithImpl<$Res, _$NetworksModelImpl>
    implements _$$NetworksModelImplCopyWith<$Res> {
  __$$NetworksModelImplCopyWithImpl(
      _$NetworksModelImpl _value, $Res Function(_$NetworksModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
  }) {
    return _then(_$NetworksModelImpl(
      networks: null == networks
          ? _value._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworksModelImpl extends _NetworksModel {
  const _$NetworksModelImpl({final Map<String, String> networks = const {}})
      : _networks = networks,
        super._();

  factory _$NetworksModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworksModelImplFromJson(json);

  final Map<String, String> _networks;
  @override
  @JsonKey()
  Map<String, String> get networks {
    if (_networks is EqualUnmodifiableMapView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_networks);
  }

  @override
  String toString() {
    return 'NetworksModel(networks: $networks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworksModelImpl &&
            const DeepCollectionEquality().equals(other._networks, _networks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_networks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworksModelImplCopyWith<_$NetworksModelImpl> get copyWith =>
      __$$NetworksModelImplCopyWithImpl<_$NetworksModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworksModelImplToJson(
      this,
    );
  }
}

abstract class _NetworksModel extends NetworksModel {
  const factory _NetworksModel({final Map<String, String> networks}) =
      _$NetworksModelImpl;
  const _NetworksModel._() : super._();

  factory _NetworksModel.fromJson(Map<String, dynamic> json) =
      _$NetworksModelImpl.fromJson;

  @override
  Map<String, String> get networks;
  @override
  @JsonKey(ignore: true)
  _$$NetworksModelImplCopyWith<_$NetworksModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
