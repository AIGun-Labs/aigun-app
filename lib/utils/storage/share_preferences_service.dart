import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences 的综合封装类，提供异步和缓存两种实现方式以获得最佳性能
///
/// 此服务提供三种与持久化存储交互的方式：
/// 1. 纯异步方法（后缀：Async）- 适用于一次性操作或大数据操作
/// 2. 缓存方法（后缀：Cached）- 适用于频繁访问的数据，具有内存缓存功能
/// 3. 便捷方法 - 根据 useCache 参数自动选择异步或缓存方式
///
/// 使用示例：
/// ```dart
/// final prefs = await SharePreferencesService.getInstance();
///
/// // 缓存方式（读取快速，适合频繁访问的数据）
/// await prefs.setString('username', 'john');
/// String? username = await prefs.getString('username');
///
/// // 纯异步方式（适合大数据或不频繁访问）
/// await prefs.setStringAsync('large_json', jsonString);
/// String? data = await prefs.getStringAsync('large_json');
/// ```
class SharePreferencesService {
  /// 用于性能关键操作的纯异步 SharedPreferences 实例
  late final SharedPreferencesAsync _asyncPrefs;

  /// 用于频繁访问数据的缓存 SharedPreferences 实例
  late final SharedPreferencesWithCache _cachedPrefs;

  /// 单例模式的私有构造函数
  SharePreferencesService._();

  /// 单例实例
  static SharePreferencesService? _instance;

  /// 获取 SharePreferencesService 的单例实例
  static Future<SharePreferencesService> getInstance() async {
    _instance ??= SharePreferencesService._();
    await _instance!._initialize();
    return _instance!;
  }

  /// 初始化异步和缓存的 SharedPreferences 实例
  Future<void> _initialize() async {
    _asyncPrefs = SharedPreferencesAsync();
    _cachedPrefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  // ===============================
  // 异步方法 (SharedPreferencesAsync)
  // ===============================
  // 适用于一次性操作、大数据或需要保证异步行为且不使用内存缓存的场景

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

  Future<List<String>?> getStringListAsync(String key,
      {List<String>? defaultValue}) async {
    final value = await _asyncPrefs.getStringList(key);
    return value ?? defaultValue;
  }

  // ===============================
  // 缓存方法 (SharedPreferencesWithCache)
  // ===============================
  // 使用这些方法来处理频繁访问的数据，具有内存缓存功能
  // 读取操作是同步的，性能更好

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
  // 工具方法 - 异步和缓存版本
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
  // 便捷方法 - 自动选择异步或缓存
  // ===============================
  // 这些方法提供统一的接口，可以根据 useCache 参数自动选择使用缓存或异步版本,默认为不使用缓存

  Future<void> setString(String key, String value,
      {bool useCache = false}) async {
    if (useCache) {
      await setStringCached(key, value);
    } else {
      await setStringAsync(key, value);
    }
  }

  Future<String?> getString(String key,
      {String? defaultValue, bool useCache = false}) async {
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

  Future<int?> getInt(String key,
      {int? defaultValue, bool useCache = false}) async {
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

  Future<bool?> getBool(String key,
      {bool? defaultValue, bool useCache = false}) async {
    if (useCache) {
      return getBoolCached(key, defaultValue: defaultValue);
    } else {
      return await getBoolAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setDouble(String key, double value,
      {bool useCache = false}) async {
    if (useCache) {
      await setDoubleCached(key, value);
    } else {
      await setDoubleAsync(key, value);
    }
  }

  Future<double?> getDouble(String key,
      {double? defaultValue, bool useCache = false}) async {
    if (useCache) {
      return getDoubleCached(key, defaultValue: defaultValue);
    } else {
      return await getDoubleAsync(key, defaultValue: defaultValue);
    }
  }

  Future<void> setStringList(String key, List<String> value,
      {bool useCache = false}) async {
    if (useCache) {
      await setStringListCached(key, value);
    } else {
      await setStringListAsync(key, value);
    }
  }

  Future<List<String>?> getStringList(String key,
      {List<String>? defaultValue, bool useCache = false}) async {
    if (useCache) {
      return getStringListCached(key, defaultValue: defaultValue);
    } else {
      return await getStringListAsync(key, defaultValue: defaultValue);
    }
  }
}
