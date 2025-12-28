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
    final lower = <String, String>{};

    headers.forEach((key, value) {
      lower[key.toLowerCase()] = value;
    });
    final parts = <String>[];

    for (final header in _stableHeaders) {
      final v = lower[header];
      if (v != null && v.isNotEmpty) {
        parts.add('$header:$v');
      }
    }
    parts.sort();
    final s = parts.join('|');
    return s.isEmpty ? '' : md5.convert(utf8.encode(s)).toString();
  }
}
