import 'package:flutter_aigun/config/env.dart';

String? getImageUrl(String? path) {
  String baseUrl = Env.config.cdn!;
  String relativePath = path ?? "";
  if (path == null) {
    return null;
  }

  if (path.startsWith(baseUrl)) {
    return path;
  }

  if (baseUrl.endsWith("/")) {
    baseUrl = baseUrl.substring(0, baseUrl.length - 1);
  }

  if (relativePath.startsWith("/")) {
    relativePath = relativePath.substring(1);
  }

// 如果路径不以http开头，则拼接baseUrl
  if (!path.startsWith("http")) {
    return "$baseUrl/$relativePath";
  }

  final url = "${Env.config.baseUrl}/api/v1/proxy?url=$relativePath";
  return url;
}
