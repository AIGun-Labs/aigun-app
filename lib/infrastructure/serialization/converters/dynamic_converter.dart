import 'dart:convert';

import 'package:aigun_app/utils/extensions/string.dart';
import 'package:aigun_app/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DynamicStringConverter extends JsonConverter<String?, dynamic> {
  const DynamicStringConverter();

  @override
  String? fromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;

    if (value is num || value is bool) return value.toString();

    if (value is List || value is Map) return jsonEncode(value);

    if (kDebugMode) {
      Logger.info(
        '[Intel] _stringFromDynamic unexpected type: ${value.runtimeType}, value: $value',
      );
    }

    return '';
  }

  @override
  dynamic toJson(String? value) => value;
}

class DynamicDoubleConverter extends JsonConverter<double?, dynamic> {
  const DynamicDoubleConverter();

  @override
  double? fromJson(value) {
    if (value == null) return 0;
    if (value is double) return value;

    if (value is int) return value.toDouble();

    if (value is String) {
      if (value.isEmpty) return 0;
      return value.toDouble();
    }
    return 0;
  }

  @override
  dynamic toJson(double? value) => value;
}
