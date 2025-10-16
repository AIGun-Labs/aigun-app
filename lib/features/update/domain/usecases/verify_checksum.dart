import '../services/checksum.dart';

class VerifyChecksum {
  final ChecksumService service;
  VerifyChecksum(this.service);

  Future<bool> call(String path, String expectedHex) async {
    final actual = await service.sha256OfFile(path);
    return actual.toLowerCase() == expectedHex.toLowerCase();
  }
}
