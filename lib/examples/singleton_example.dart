///

// ============================================================================

// ============================================================================

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();

  factory DatabaseManager() => _instance;

  DatabaseManager._internal() {
    print('DatabaseManager ');
  }

  void connect() {
    print('');
  }

  void disconnect() {
    print('');
  }
}

// ============================================================================

// ============================================================================

class CacheManager {
  static CacheManager? _instance;

  CacheManager._internal() {
    print('CacheManager （）');
  }

  factory CacheManager() {
    _instance ??= CacheManager._internal();
    return _instance!;
  }

  final Map<String, dynamic> _cache = {};

  void set(String key, dynamic value) {
    _cache[key] = value;
  }

  dynamic get(String key) {
    return _cache[key];
  }
}

// ============================================================================

// ============================================================================

class Logger {
  static Logger? _instance;

  Logger._internal();

  static Logger get instance {
    _instance ??= Logger._internal();
    return _instance!;
  }

  void log(String message) {
    print('[Logger] $message');
  }
}

// ============================================================================

// ============================================================================

class ApiClient {
  static ApiClient? _instance;
  final String baseUrl;

  ApiClient._internal(this.baseUrl) {
    print('ApiClient ，baseUrl: $baseUrl');
  }

  factory ApiClient.init(String baseUrl) {
    _instance ??= ApiClient._internal(baseUrl);
    return _instance!;
  }

  factory ApiClient() {
    if (_instance == null) {
      throw Exception('ApiClient ， ApiClient.init()');
    }
    return _instance!;
  }

  void request(String endpoint) {
    print(': ${baseUrl}/$endpoint');
  }
}

// ============================================================================

// ============================================================================

void main() {
  print('=' * 50);
  print('');
  print('=' * 50);

  print('\n【1】DatabaseManager - ');
  final db1 = DatabaseManager();
  final db2 = DatabaseManager();
  print('db1  db2 : ${identical(db1, db2)}'); // true
  db1.connect();
  db2.disconnect();

  print('\n【2】CacheManager - ');
  final cache1 = CacheManager();
  cache1.set('name', 'Flutter');
  final cache2 = CacheManager();
  print('cache1  cache2 : ${identical(cache1, cache2)}'); // true
  print(' cache2 : ${cache2.get('name')}'); // Flutter

  print('\n【3】Logger - getter ');
  Logger.instance.log('');
  Logger.instance.log('');
  print('');

  print('\n【4】ApiClient - ');
  final api1 = ApiClient.init('https://api.example.com');
  final api2 = ApiClient();
  print('api1  api2 : ${identical(api1, api2)}'); // true
  api1.request('users');
  api2.request('posts');

  print('\n' + '=' * 50);
}

// ============================================================================

// ============================================================================
/*
1.  - 
2.  - 
3.  - 
4.  - 
5. API  - 
6.  - （）
*/

// ============================================================================

// ============================================================================
/*
1. ： Dart ，
2. ：，
3. ：，
4. ：
5. ：，
*/
