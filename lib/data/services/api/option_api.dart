import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/models/options/single_type/single_type.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';

class OptionsApi {
  final DioClient _dioClient = getIt<DioClient>();

  Future<List<SingleTypeOptions>> getSingleTypeOptions() async {
    final response = await _dioClient.get('/api/v1/options/single-type');

    return (response as List<dynamic>)
        .map((e) => SingleTypeOptions.fromJson(e))
        .toList();
  }
}
