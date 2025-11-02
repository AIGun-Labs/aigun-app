# 统计分析管理器使用指南

## 📖 概述

统计分析管理器提供了统一的统计接口，根据用户地区自动选择使用 **Firebase Analytics**（国际版）或**友盟统计**（国内版）。

## 🏗️ 架构设计

采用适配器模式（Adapter Pattern）设计：

```
AnalyticsManager (单例)
    ↓
AnalyticsAdapter (接口)
    ↓
├── FirebaseAnalyticsAdapter (Firebase 实现)
└── UmengAnalyticsAdapter (友盟实现)
```

## 📝 初始化

已在 `main.dart` 中自动初始化，根据系统地区自动选择统计平台：

```dart
// 中国大陆地区 (zh_CN) → 使用友盟统计
// 其他地区 → 使用 Firebase Analytics
final bool isInChina = await RegionUtils.isUserInMainlandChina();
await AnalyticsManager().init(isInChina: isInChina);
```

## 🎯 基础使用

### 1. 记录事件

```dart
import 'package:flutter_aigun/services/analytics/analytics_manager.dart';

// 简单事件
await AnalyticsManager().logEvent('button_click');

// 带参数的事件
await AnalyticsManager().logEvent('purchase', parameters: {
  'item_id': 'SKU_123',
  'item_name': '商品名称',
  'price': 99.99,
  'currency': 'USD',
});
```

### 2. 设置用户 ID

```dart
// 用户登录后设置
await AnalyticsManager().setUserId('user_12345');

// 用户退出登录后清除
await AnalyticsManager().clearUserId();
```

### 3. 设置用户属性

```dart
await AnalyticsManager().setUserProperty('vip_level', 'gold');
await AnalyticsManager().setUserProperty('age_group', '25-34');
```

### 4. 记录页面浏览

```dart
await AnalyticsManager().logScreenView(
  screenName: 'home_page',
  screenClass: 'HomePage',
);
```

## 🚀 便捷方法

提供了常用事件的便捷方法：

```dart
// 登录事件
await AnalyticsManager().logLogin(method: 'google');

// 注册事件
await AnalyticsManager().logSignUp(method: 'email');

// 购买事件
await AnalyticsManager().logPurchase(
  currency: 'USD',
  value: 99.99,
  items: {'item_id': 'SKU_123'},
);

// 分享事件
await AnalyticsManager().logShare(
  contentType: 'article',
  itemId: 'article_123',
);

// 搜索事件
await AnalyticsManager().logSearch(searchTerm: 'Flutter');
```

## 📱 页面追踪示例

在页面中集成统计：

```dart
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    // 页面进入时记录
    AnalyticsManager().logScreenView(
      screenName: 'my_page',
      screenClass: 'MyPage',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          // 按钮点击事件
          AnalyticsManager().logEvent('button_clicked', parameters: {
            'button_name': 'submit',
            'page': 'my_page',
          });
        },
        child: Text('提交'),
      ),
    );
  }
}
```

## 🔧 配置说明

### Firebase Analytics 配置

1. 在 Firebase 控制台创建项目
2. 下载 `google-services.json` (Android) 和 `GoogleService-Info.plist` (iOS)
3. 将配置文件放到对应目录：
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### 友盟统计配置

在 `umeng_analytics_adapter.dart` 中配置 AppKey：

```dart
static const String _androidAppKey = 'YOUR_ANDROID_APPKEY';
static const String _iosAppKey = 'YOUR_IOS_APPKEY';
```

获取 AppKey：登录[友盟后台](https://www.umeng.com/)创建应用获取。

## 🌍 地区判断

使用 `RegionUtils` 工具类判断用户地区：

```dart
// 判断是否在中国大陆
bool isInChina = await RegionUtils.isUserInMainlandChina();

// 获取语言代码 (zh, en, ja...)
String lang = RegionUtils.getUserLanguageCode();

// 获取国家代码 (CN, US, JP...)
String country = RegionUtils.getUserCountryCode();

// 判断是否为中文环境（包括大陆、台湾、香港）
bool isChinese = RegionUtils.isChineseEnvironment();
```

## 📊 常用事件参考

### 电商类事件

```dart
// 查看商品
AnalyticsManager().logEvent('view_item', parameters: {
  'item_id': 'SKU_123',
  'item_name': '商品名称',
  'item_category': '分类',
});

// 加入购物车
AnalyticsManager().logEvent('add_to_cart', parameters: {
  'item_id': 'SKU_123',
  'quantity': 1,
});

// 开始结账
AnalyticsManager().logEvent('begin_checkout', parameters: {
  'value': 99.99,
  'currency': 'USD',
});

// 完成购买
AnalyticsManager().logPurchase(
  currency: 'USD',
  value: 99.99,
  items: {
    'item_id': 'SKU_123',
    'quantity': 1,
  },
);
```

### 社交类事件

```dart
// 点赞
AnalyticsManager().logEvent('like', parameters: {
  'content_type': 'post',
  'content_id': 'post_123',
});

// 评论
AnalyticsManager().logEvent('comment', parameters: {
  'content_type': 'post',
  'content_id': 'post_123',
});

// 分享
AnalyticsManager().logShare(
  contentType: 'post',
  itemId: 'post_123',
);
```

## ⚠️ 注意事项

1. **事件命名规范**：
   - 使用小写字母和下划线（snake_case）
   - 避免使用空格和特殊字符
   - 事件名称不超过 40 个字符

2. **参数限制**：
   - Firebase：每个事件最多 25 个参数
   - 友盟：无明确限制，但建议控制在合理范围内

3. **隐私合规**：
   - 不要记录敏感信息（密码、信用卡号等）
   - 遵守 GDPR、CCPA 等隐私法规
   - 在隐私政策中说明统计收集的数据

4. **性能优化**：
   - 避免在循环中频繁调用
   - 批量事件建议间隔发送
   - 统计初始化失败不会影响应用运行

## 🔍 调试

开启日志查看统计事件：

```dart
// 在 UmengAnalyticsAdapter.init() 中：
UmengCommonSdk.setLogEnabled(true);  // 开发环境开启

// Firebase Analytics 自动记录到控制台
// 在 Android Studio 的 Logcat 中搜索 "FA" 查看日志
```

## 📚 参考文档

- [Firebase Analytics 文档](https://firebase.google.com/docs/analytics)
- [友盟统计文档](https://developer.umeng.com/docs/119267/detail/118584)
- [Flutter 最佳实践](https://flutter.dev/docs/development/data-and-backend/firebase)


