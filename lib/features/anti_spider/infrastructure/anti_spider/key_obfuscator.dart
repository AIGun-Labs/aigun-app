import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

sealed class KeyObfuscator {
  String obfuscate(String baseKey);
}

class DefaultKeyObfuscator implements KeyObfuscator {
  @override
  String obfuscate(String baseKey) {
    if (baseKey.length != 32) {
      baseKey = md5.convert(utf8.encode(baseKey)).toString();
    }

    final randomPart = _generateRandomHex(32);
    final obfuscated = _xorHexStrings(baseKey, randomPart);

    return obfuscated + randomPart;
  }

  String _generateRandomHex(int length) {
    const chars = '0123456789abcdef';
    final random = Random.secure();
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      buffer.write(chars[random.nextInt(chars.length)]);
    }

    return buffer.toString();
  }

  String _xorHexStrings(String a, String b) {
    if (a.length != b.length || a.length % 2 != 0) {
      throw ArgumentError('hex  ');
    }

    final byteCount = a.length ~/ 2;

    final buffer = StringBuffer();

    for (var i = 0; i < byteCount; i++) {
      final start = i * 2;

      final byteA = int.parse(a.substring(start, start + 2), radix: 16);
      final byteB = int.parse(b.substring(start, start + 2), radix: 16);

      final xorByte = byteA ^ byteB;

      buffer.write(xorByte.toRadixString(16).padLeft(2, '0'));
    }

    return buffer.toString();
  }
}
