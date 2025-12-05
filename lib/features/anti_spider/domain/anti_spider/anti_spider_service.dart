import 'anti_spider_key.dart';

abstract class AntiSpiderKeyService {
  Future<AntiSpiderKey> generateKey({
    required String interfacePath,
    required Map<String, String> headers,
    // required String clientIp,
    Map<String, dynamic>? additionalParams,
  });
}
