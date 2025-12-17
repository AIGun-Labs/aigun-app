import 'dart:convert';

import 'package:dio/dio.dart';

String dedupKey(RequestOptions o) {
  final override = o.extra['gk_dedup_key'];
  if (override is String && override.isNotEmpty) return override;

  final method = o.method.toUpperCase();
  final uri = o.uri;

  // canonical query（保证不同 map 顺序不会导致 key 不同）
  final qpAll = uri.queryParametersAll; // Map<String, List<String>>
  final keys = qpAll.keys.toList()..sort();
  final queryBuf = StringBuffer();
  for (final k in keys) {
    final vals = (qpAll[k] ?? <String>[]).toList()..sort();
    for (final v in vals) {
      queryBuf.write('$k=$v&');
    }
  }
  final base = uri.replace(queryParameters: const {}).toString();
  final bodySig = _bodySignature(o.data);

  return '$method|$base|q:${queryBuf.toString()}|b:$bodySig';
  // 如果你希望 headers 也参与去重，可在这里拼接需要的 header
}

String _bodySignature(dynamic data) {
  if (data == null) return '';
  try {
    if (data is FormData) {
      final fields = data.fields.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      final files =
          data.files.map((e) => '${e.key}:${e.value.filename ?? ''}').toList()
            ..sort();
      return jsonEncode({
        'form': true,
        'fields': fields.map((e) => {'k': e.key, 'v': e.value}).toList(),
        'files': files,
      });
    }

    if (data is Map || data is List) {
      return jsonEncode(_normalizeJson(data));
    }

    // 兜底（避免因为对象不可 JSON 而崩）
    return data.toString();
  } catch (_) {
    return data.toString();
  }
}

dynamic _normalizeJson(dynamic v) {
  if (v is List) {
    return v.map(_normalizeJson).toList();
  }
  if (v is Map) {
    final keys = v.keys.map((e) => e.toString()).toList()..sort();
    final out = <String, dynamic>{};
    for (final k in keys) {
      out[k] = _normalizeJson(v[k]);
    }
    return out;
  }
  return v;
}
