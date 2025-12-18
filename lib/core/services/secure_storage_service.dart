import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  SecureStorageService(this.storage);
  final FlutterSecureStorage storage;

  Future<bool> reset();
}
