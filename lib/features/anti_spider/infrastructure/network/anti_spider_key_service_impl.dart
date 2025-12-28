import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../domain/anti_spider/anti_spider_key.dart';
import '../../domain/anti_spider/anti_spider_service.dart';
import '../anti_spider/fingerprint_generator.dart';
import '../anti_spider/key_obfuscator.dart';
import '../anti_spider/seed_generator.dart';
import '../anti_spider/time_window_calculator.dart';

final userAgents = {
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
  'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
};

class AntiSpiderKeyServiceImpl implements AntiSpiderKeyService {
  AntiSpiderKeyServiceImpl({
    TimeWindowCalculator? timeWindow,
    SeedGenerator? seedGenerator,
    FingerprintGenerator? fingerprintGenerator,
    KeyObfuscator? obfuscator,
  }) : _timeWindow = timeWindow ?? UtcFiveMinuteWindowCalculator(),
       _seedGenerator = seedGenerator ?? MD5HourSeedGenerator(),
       _fingerprintGenerator =
           fingerprintGenerator ?? StableHeadersFingerprintGenerator(),
       _obfuscator = obfuscator ?? DefaultKeyObfuscator();
  final TimeWindowCalculator _timeWindow;
  final SeedGenerator _seedGenerator;
  final FingerprintGenerator _fingerprintGenerator;
  final KeyObfuscator _obfuscator;

  @override
  Future<AntiSpiderKey> generateKey({
    required String interfacePath,
    required Map<String, String> headers,
    // required String clientIp,
    Map<String, dynamic>? additionalParams,
  }) async {
    final timeUnit = _timeWindow.currentUnit();
    final seed = _seedGenerator.currentSeed();
    final fingerprint = _fingerprintGenerator.generate(userAgents);

    final baseKeyInput = _buildBaseKeyInput(
      seed: seed,
      timeUnit: timeUnit,
      fingerprint: fingerprint,
      // clientIp: clientIp,
      additionalParams: additionalParams,
    );

    final baseKey = md5.convert(utf8.encode(baseKeyInput)).toString();
    final finalKey = _obfuscator.obfuscate(baseKey);

    return AntiSpiderKey(finalKey);
  }

  String _buildBaseKeyInput({
    required String seed,
    required String timeUnit,
    required String fingerprint,
    // required String clientIp,
    Map<String, dynamic>? additionalParams,
  }) {
    final components = <String>[seed, timeUnit, fingerprint];
    if (additionalParams != null && additionalParams.isNotEmpty) {
      final sortedKeys = additionalParams.keys.toList()..sort();

      final sortedMap = <String, dynamic>{};

      for (final k in sortedKeys) {
        sortedMap[k] = additionalParams[k];
      }

      final paramsStr = jsonEncode(sortedMap);
      components.add(paramsStr);
    }

    return components.join('|');
  }
}
