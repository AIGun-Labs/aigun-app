import 'package:shared_preferences/shared_preferences.dart';

///

///

/// ```dart
/// final prefs = await SharePreferencesService.getInstance();
///

/// await prefs.setString('username', 'john');
/// String? username = await prefs.getString('username');
///

/// await prefs.setStringAsync('large_json', jsonString);
/// String? data = await prefs.getStringAsync('large_json');
/// ```
class SharePreferencesService {
  late final SharedPreferencesAsync _asyncPrefs;

  late final SharedPreferencesWithCache _cachedPrefs;

  SharePreferencesService._();

  static SharePreferencesService? _instance;

  static Future<SharePreferencesService> getInstance() async {
    _instance ??= SharePreferencesService._();
    await _instance!._initialize();
    return _instance!;
  }

  Future<void> _initialize() async {
    _asyncPrefs = SharedPreferencesAsync();
    _cachedPrefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  // ===============================

  // ===============================

  Future<void> setStringAsync(String key, String value) async {
    await _asyncPrefs.setString(key, value);
  }

  Future<String?> getStringAsync(String key, {String? defaultValue}) async {
    final value = await _asyncPrefs.getString(key);
    return value ?? defaultValue;
  }

  Future<void> setIntAsync(String key, int value) async {
    await _asyncPrefs.setInt(key, value);
  }

  Future<int?> getIntAsync(String key, {int? defaultValue}) async {
    final value = await _asyncPrefs.getInt(key);
    return value ?? defaultValue;
  }

  Future<void> setBoolAsync(String key, bool value) async {
    await _asyncPrefs.setBool(key, value);
  }

  Future<bool?> getBoolAsync(String key, {bool? defaultValue}) async {
    final value = await _asyncPrefs.getBool(key);
    return value ?? defaultValue;
  }

  Future<void> setDoubleAsync(String key, double value) async {
    await _asyncPrefs.setDouble(key, value);
  }

  Future<double?> getDoubleAsync(String key, {double? defaultValue}) async {
    final value = await _asyncPrefs.getDouble(key);
    return value ?? defaultValue;
  }

  Future<void> setStringListAsync(String key, List<String> value) async {
    await _asyncPrefs.setStringList(key, value);
  }

  Future<List<String>?> getStringListAsync(
    String key, {
    List<String>? defaultValue,
  }) async {
    final value = await _asyncPrefs.getStringList(key);
    return value ?? defaultValue;
  }

  // ===============================

  // ===============================

  Future<void> setStringCached(String key, String value) async {
    await _cachedPrefs.setString(key, value);
  }

  String? getStringCached(String key, {String? defaultValue}) {
    return _cachedPrefs.getString(key) ?? defaultValue;
  }

  Future<void> setIntCached(String key, int value) async {
    await _cachedPrefs.setInt(key, value);
  }

  int? getIntCached(String key, {int? defaultValue}) {
    return _cachedPrefs.getInt(key) ?? defaultValue;
  }

  Future<void> setBoolCached(String key, bool value) async {
    await _cachedPrefs.setBool(key, value);
  }

  bool? getBoolCached(String key, {bool? defaultValue}) {
    return _cachedPrefs.getBool(key) ?? defaultValue;
  }

  Future<void> setDoubleCached(String key, double value) async {
    await _cachedPrefs.setDouble(key, value);
  }

  double? getDoubleCached(String key, {double? defaultValue}) {
    return _cachedPrefs.getDouble(key) ?? defaultValue;
  }

  Future<void> setStringListCached(String key, List<String> value) async {
    await _cachedPrefs.setStringList(key, value);
  }

  List<String>? getStringListCached(String key, {List<String>? defaultValue}) {
    return _cachedPrefs.getStringList(key) ?? defaultValue;
  }

  // ===============================

  // ===============================

  Future<void> removeAsync(String key) async {
    await _asyncPrefs.remove(key);
  }

  Future<void> removeCached(String key) async {
    await _cachedPrefs.remove(key);
  }

  Future<void> clearAsync({Set<String>? allowList}) async {
    await _asyncPrefs.clear(allowList: allowList);
  }

  Future<void> clearCached() async {
    await _cachedPrefs.clear();
  }

  Future<bool> containsKeyAsync(String key) async {
    return await _asyncPrefs.containsKey(key);
  }

  bool containsKeyCached(String key) {
    return _cachedPrefs.containsKey(key);
  }

  Future<Set<String>> getKeysAsync({Set<String>? allowList}) async {
    return await _asyncPrefs.getKeys(allowList: allowList);
  }

  Set<String> getKeysCached() {
    return _cachedPrefs.keys;
  }

  // ===============================

  // ===============================

  Future<void> setString(
    String key,
    String value, {
    bool useCache = false,
  }) async {
    if (useCache) {
      await setStringCached(key, value);
    } else {
      await setStringAsync(key, value);
    }
  }

  Future<String?> getString(
    String key, {
    String? defaultValue,
    bool useCache = false,
  }) async {
    if (useCache) {
      return getStringCached(key, defaultValue: defaultValue);
    } else {
      return await getStringAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setInt(String key, int value, {bool useCache = false}) async {
    if (useCache) {
      await setIntCached(key, value);
    } else {
      await setIntAsync(key, value);
    }
  }

  Future<int?> getInt(
    String key, {
    int? defaultValue,
    bool useCache = false,
  }) async {
    if (useCache) {
      return getIntCached(key, defaultValue: defaultValue);
    } else {
      return await getIntAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setBool(String key, bool value, {bool useCache = false}) async {
    if (useCache) {
      await setBoolCached(key, value);
    } else {
      await setBoolAsync(key, value);
    }
  }

  Future<bool?> getBool(
    String key, {
    bool? defaultValue,
    bool useCache = false,
  }) async {
    if (useCache) {
      return getBoolCached(key, defaultValue: defaultValue);
    } else {
      return await getBoolAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setDouble(
    String key,
    double value, {
    bool useCache = false,
  }) async {
    if (useCache) {
      await setDoubleCached(key, value);
    } else {
      await setDoubleAsync(key, value);
    }
  }

  Future<double?> getDouble(
    String key, {
    double? defaultValue,
    bool useCache = false,
  }) async {
    if (useCache) {
      return getDoubleCached(key, defaultValue: defaultValue);
    } else {
      return await getDoubleAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setStringList(
    String key,
    List<String> value, {
    bool useCache = false,
  }) async {
    if (useCache) {
      await setStringListCached(key, value);
    } else {
      await setStringListAsync(key, value);
    }
  }

  Future<List<String>?> getStringList(
    String key, {
    List<String>? defaultValue,
    bool useCache = false,
  }) async {
    if (useCache) {
      return getStringListCached(key, defaultValue: defaultValue);
    } else {
      return await getStringListAsync(key, defaultValue: defaultValue);
    }
  }
}
