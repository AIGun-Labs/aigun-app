import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pinenacl/ed25519.dart';
import 'package:web3dart/crypto.dart';

import '../config/app_config.dart';

/// signature service
class SignatureService {
  /// create signature
  static Future<String> createSignature({required String message}) async {
    try {
      // use private key
      final privateKey = _getPrivateKey();
      if (privateKey.isEmpty) {
        // if private key is empty, use hash signature as fallback
        return _createHashSignature(message);
      }

      // convert private key to Uint8Array
      final keyBytes = _hexToUint8Array(privateKey);

      // check key length
      if (keyBytes.length != 32 && keyBytes.length != 64) {
        throw Exception(
          'Invalid private key size: ${keyBytes.length} bytes. Expected 32 or 64 bytes.',
        );
      }

      // create signature
      final signature = _createDetachedSignature(
        utf8.encode(message),
        keyBytes,
      );

      return signature;
    } catch (e) {
      // if signature failed, return hash signature
      return _createHashSignature(message);
    }
  }

  /// get private key
  static String _getPrivateKey() {
    return AppConfig.privateKey;
  }

  /// create hash signature
  static String _createHashSignature(String message) {
    final bytes = utf8.encode(message);
    final hash = sha256.convert(bytes);
    return base64Encode(hash.bytes);
  }

  /// convert hex string to Uint8Array
  static Uint8List _hexToUint8Array(String hex) {
    if (hex.length % 2 != 0) {
      throw Exception('Invalid hex string length');
    }

    final bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  /// create detached signature
  static String _createDetachedSignature(
    Uint8List message,
    Uint8List secretKey,
  ) {
    final keyBytes = hexToBytes(AppConfig.privateKey);
    if (keyBytes.length < 32) {
      throw ArgumentError(
        'Private key must be at least 32 bytes (64 hex characters)',
      );
    }

    final seed = keyBytes.sublist(0, 32);
    // create private key
    final privateKey = SigningKey.fromSeed(seed);
    // sign message
    final signedMessage = privateKey.sign(message);
    // get signature
    final signatureBytes = signedMessage.signature;
    // return signature
    return base64Encode(signatureBytes);
  }
}
