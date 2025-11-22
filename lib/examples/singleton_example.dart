/// 单例模式示例
/// 
/// 单例模式确保一个类只有一个实例，并提供全局访问点。
/// 在 Flutter/Dart 中，有几种常见的单例实现方式。

// ============================================================================
// 方式1: 工厂构造函数 + 静态实例（推荐）
// ============================================================================

class DatabaseManager {
  // 私有静态实例
  static final DatabaseManager _instance = DatabaseManager._internal();

  // 工厂构造函数，总是返回同一个实例
  factory DatabaseManager() => _instance;

  // 私有命名构造函数，防止外部创建实例
  DatabaseManager._internal() {
    print('DatabaseManager 实例已创建');
  }

  // 实例方法
  void connect() {
    print('数据库已连接');
  }

  void disconnect() {
    print('数据库已断开');
  }
}

// ============================================================================
// 方式2: 延迟初始化单例（懒加载）
// ============================================================================

class CacheManager {
  static CacheManager? _instance;

  // 私有构造函数
  CacheManager._internal() {
    print('CacheManager 实例已创建（延迟初始化）');
  }

  // 工厂构造函数，延迟创建实例
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
// 方式3: 使用 getter 的单例（简洁方式）
// ============================================================================

class Logger {
  static Logger? _instance;

  // 私有构造函数
  Logger._internal();

  // 使用 getter 获取单例
  static Logger get instance {
    _instance ??= Logger._internal();
    return _instance!;
  }

  void log(String message) {
    print('[Logger] $message');
  }
}

// ============================================================================
// 方式4: 带初始化参数的单例
// ============================================================================

class ApiClient {
  static ApiClient? _instance;
  final String baseUrl;

  // 私有构造函数，接受参数
  ApiClient._internal(this.baseUrl) {
    print('ApiClient 实例已创建，baseUrl: $baseUrl');
  }

  // 工厂构造函数，带初始化方法
  factory ApiClient.init(String baseUrl) {
    _instance ??= ApiClient._internal(baseUrl);
    return _instance!;
  }

  // 获取已初始化的实例（如果未初始化会抛出异常）
  factory ApiClient() {
    if (_instance == null) {
      throw Exception('ApiClient 未初始化，请先调用 ApiClient.init()');
    }
    return _instance!;
  }

  void request(String endpoint) {
    print('请求: ${baseUrl}/$endpoint');
  }
}

// ============================================================================
// 使用示例
// ============================================================================

void main() {
  print('=' * 50);
  print('单例模式示例');
  print('=' * 50);

  // 示例1: DatabaseManager - 工厂构造函数方式
  print('\n【示例1】DatabaseManager - 工厂构造函数方式');
  final db1 = DatabaseManager();
  final db2 = DatabaseManager();
  print('db1 和 db2 是同一个实例: ${identical(db1, db2)}'); // true
  db1.connect();
  db2.disconnect();

  // 示例2: CacheManager - 延迟初始化方式
  print('\n【示例2】CacheManager - 延迟初始化方式');
  final cache1 = CacheManager();
  cache1.set('name', 'Flutter');
  final cache2 = CacheManager();
  print('cache1 和 cache2 是同一个实例: ${identical(cache1, cache2)}'); // true
  print('从 cache2 获取缓存: ${cache2.get('name')}'); // Flutter

  // 示例3: Logger - getter 方式
  print('\n【示例3】Logger - getter 方式');
  Logger.instance.log('第一条日志');
  Logger.instance.log('第二条日志');
  print('两次调用使用同一个实例');

  // 示例4: ApiClient - 带初始化的单例
  print('\n【示例4】ApiClient - 带初始化的单例');
  final api1 = ApiClient.init('https://api.example.com');
  final api2 = ApiClient(); // 使用已创建的实例
  print('api1 和 api2 是同一个实例: ${identical(api1, api2)}'); // true
  api1.request('users');
  api2.request('posts');

  print('\n' + '=' * 50);
}

// ============================================================================
// 单例模式的使用场景
// ============================================================================
/*
1. 数据库连接管理器 - 确保整个应用只有一个数据库连接
2. 日志记录器 - 全局统一管理日志输出
3. 配置管理器 - 全局共享配置信息
4. 缓存管理器 - 全局共享缓存数据
5. API 客户端 - 统一管理网络请求
6. 状态管理器 - 全局状态管理（如用户信息）
*/

// ============================================================================
// 注意事项
// ============================================================================
/*
1. 线程安全：在 Dart 中，单线程执行模型使得单例模式天然线程安全
2. 内存管理：单例实例在整个应用生命周期内存在，注意内存占用
3. 测试困难：单例模式可能使单元测试变得困难，考虑依赖注入
4. 初始化顺序：确保在使用前正确初始化单例实例
5. 不可变性：考虑将单例的数据设为不可变，避免意外的状态修改
*/

