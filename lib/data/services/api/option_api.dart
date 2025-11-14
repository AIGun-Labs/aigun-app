import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/models/options/single_type/single_type.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';

class OptionsApi {
  final DioClient _dioClient = getIt<DioClient>();
  final String _basePath = "/api/v1/option";

  Future<List<SingleTypeOptions>> getSingleTypeOptions() async {
    final response = await _dioClient.get('$_basePath/signal-type');

    return (response as List<dynamic>)
        .map((e) => SingleTypeOptions.fromJson(e))
        .toList();
  }
}
