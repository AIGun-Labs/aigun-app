import 'package:shared_preferences/shared_preferences.dart';

class CountdownStorage {
  final SharedPreferences _prefs;
  CountdownStorage(this._prefs);

  Future<int> loadCountdown(String email) async {
    final countdownKey = _generateCountdownKey(email);
    final timestampKey = _generateTimestampKey(email);

    final savedCountdown = _prefs.getInt(countdownKey) ?? 0;
    final savedTimestamp = _prefs.getInt(timestampKey) ?? 0;

    final elapsed = DateTime.now().millisecondsSinceEpoch - savedTimestamp;
    final adjustedCountdown = savedCountdown - (elapsed ~/ 1000);

    return adjustedCountdown.clamp(0, 60);
  }

  Future<void> saveCountdown(String email, int countdown) async {
    final countdownKey = _generateCountdownKey(email);
    final timestampKey = _generateTimestampKey(email);

    await _prefs.setInt(countdownKey, countdown);
    await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  String _generateCountdownKey(String email) {
    return 'countdown_$email';
  }

  String _generateTimestampKey(String email) {
    return 'timestamp_$email';
  }
}
