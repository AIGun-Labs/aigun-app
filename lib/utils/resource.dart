import 'package:flutter_aigun/config/env/env.dart';

String? getImageUrl(String? path) {
  // 如果路径为空或只包含数字，直接返回null
  if (path == null || path.trim().isEmpty || RegExp(r'^\d+$').hasMatch(path)) {
    return null;
  }

  String baseUrl = EnvConfig().cdn;
  String relativePath = path;

  if (isRawUrl(path) ?? false) {
    return path;
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

  final url = "${EnvConfig().cdn}/api/v1/proxy?url=$relativePath";
  return url;
}

bool? isRawUrl(String? url) {
  if (url == null) {
    return false;
  }
  if (url.startsWith("https://raw.githubusercontent.com")) {
    return true;
  }
  return false;
}
