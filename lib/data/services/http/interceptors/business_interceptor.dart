import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../core/custom_exceptions.dart';
import '../../../models/index.dart';

class BusinessInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      // if the response is string , decode it
      final responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map<String, dynamic>) {
        // if the response data is a map , check if the code is 0
        final apiResponse = ApiResponse.fromJson(responseData, (json) => json);

        if (apiResponse.code == 0) {
          response.data = apiResponse.data;

          handler.next(response);

          return;
        } else {
          final businessException =
              BusinessException(code: apiResponse.code, msg: apiResponse.msg);

          handler.reject(
              DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  type: DioExceptionType.badResponse,
                  error: businessException),
              true);

// SentryService().reportRequestError(exception, stackTrace)

          return;
        }
      }
    }
  }
}
