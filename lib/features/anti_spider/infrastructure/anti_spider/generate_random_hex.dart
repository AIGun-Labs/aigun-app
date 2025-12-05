import 'dart:math';

sealed class GenerateRandomHex {
  String generate(int length);
}

class CharsGenerateRandomHex implements GenerateRandomHex {
  @override
  String generate(int length) {
    const chars = '0123456789abcdef';
    final random = Random.secure();
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      buffer.write(chars[random.nextInt(chars.length)]);
    }

    return buffer.toString();
  }
}
