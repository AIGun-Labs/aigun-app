import 'package:shared_preferences/shared_preferences.dart';

class CountdownStorage {
  Future<int> loadCountdown(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final countdownKey = _generateCountdownKey(email);
    final timestampKey = _generateTimestampKey(email);

    final savedCountdown = prefs.getInt(countdownKey) ?? 0;
    final savedTimestamp = prefs.getInt(timestampKey) ?? 0;

    final elapsed = DateTime.now().millisecondsSinceEpoch - savedTimestamp;
    final adjustedCountdown = savedCountdown - (elapsed ~/ 1000);

    // 确保倒计时在 0 到 60 秒之间
    return adjustedCountdown.clamp(0, 60);
  }

  Future<void> saveCountdown(String email, int countdown) async {
    final prefs = await SharedPreferences.getInstance();
    final countdownKey = _generateCountdownKey(email);
    final timestampKey = _generateTimestampKey(email);

    await prefs.setInt(countdownKey, countdown);
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  String _generateCountdownKey(String email) {
    return 'countdown_$email';
  }

  String _generateTimestampKey(String email) {
    return 'timestamp_$email';
  }
}
