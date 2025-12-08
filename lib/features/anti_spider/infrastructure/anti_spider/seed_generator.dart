import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../infrastructure/extensions/int.dart';

sealed class SeedGenerator {
  String currentSeed();
}

class MD5HourSeedGenerator implements SeedGenerator {
  @override
  String currentSeed() {
    final now = DateTime.now().toUtc();

    final stepMinutes = 1;

    final normalizedMinute = (now.minute ~/ stepMinutes) * stepMinutes;

    final normalized = DateTime.utc(
      now.year,
      now.month,
      now.day,
      now.hour,
      normalizedMinute,
    );

    final timeStr =
        '${normalized.year}-${normalized.month.two()}-${normalized.day.two()}'
        'T${normalized.hour.two()}';

    final md5Hash = md5
        .convert(utf8.encode('seed_fixed_salt_$timeStr'))
        .toString();
    return md5Hash.substring(0, 16);
  }
}
