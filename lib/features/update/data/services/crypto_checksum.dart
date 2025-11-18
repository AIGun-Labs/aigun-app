import 'dart:io';

import 'package:crypto/crypto.dart';

import '../../domain/services/checksum.dart';

class CryptoChecksumService implements ChecksumService {
  @override
  Future<String> sha256OfFile(String path) async {
    final digest = await sha256.bind(File(path).openRead()).first;
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
