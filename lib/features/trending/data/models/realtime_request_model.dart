import 'package:json_annotation/json_annotation.dart';

part 'realtime_request_model.g.dart';

@JsonSerializable()
class RealtimeRequestModel {
  final String network;
  final String address;

  const RealtimeRequestModel({required this.network, required this.address});

  factory RealtimeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RealtimeRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RealtimeRequestModelToJson(this);
}
