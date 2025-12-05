import 'dart:convert';

import 'package:crypto/crypto.dart';

sealed class FingerprintGenerator {
  String generate(Map<String, String> headers);
}

class StableHeadersFingerprintGenerator implements FingerprintGenerator {
  static const _stableHeaders = [
    'user-agent',
    'accept-language',
    'accept',
    'accept-encoding',
  ];

  @override
  String generate(Map<String, String> headers) {
    // 将 headers 转换为小写
    final lower = <String, String>{};

    headers.forEach((key, value) {
      lower[key.toLowerCase()] = value;
    });

    // 构建指纹字符串
    final parts = <String>[];

    for (final header in _stableHeaders) {
      final v = lower[header];
      if (v != null && v.isNotEmpty) {
        parts.add('$header:$v');
      }
    }

    // 排序
    parts.sort();

    // 拼接字符串
    final s = parts.join('|');

    // 计算 MD5 值
    return s.isEmpty ? '' : md5.convert(utf8.encode(s)).toString();
  }
}
