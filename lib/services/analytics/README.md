
， **Firebase Analytics**（）****（）。

（Adapter Pattern）：

```
AnalyticsManager ()
    ↓
AnalyticsAdapter ()
    ↓
├── FirebaseAnalyticsAdapter (Firebase )
└── UmengAnalyticsAdapter ()
```

 `main.dart` ，：

```dart
final bool isInChina = await RegionUtils.isUserInMainlandChina();
await AnalyticsManager().init(isInChina: isInChina);
```

```dart
import 'package:flutter_aigun/services/analytics/analytics_manager.dart';
await AnalyticsManager().logEvent('button_click');
await AnalyticsManager().logEvent('purchase', parameters: {
  'item_id': 'SKU_123',
  'item_name': '',
  'price': 99.99,
  'currency': 'USD',
});
```

```dart
await AnalyticsManager().setUserId('user_12345');
await AnalyticsManager().clearUserId();
```

```dart
await AnalyticsManager().setUserProperty('vip_level', 'gold');
await AnalyticsManager().setUserProperty('age_group', '25-34');
```

```dart
await AnalyticsManager().logScreenView(
  screenName: 'home_page',
  screenClass: 'HomePage',
);
```

：

```dart
await AnalyticsManager().logLogin(method: 'google');
await AnalyticsManager().logSignUp(method: 'email');
await AnalyticsManager().logPurchase(
  currency: 'USD',
  value: 99.99,
  items: {'item_id': 'SKU_123'},
);
await AnalyticsManager().logShare(
  contentType: 'article',
  itemId: 'article_123',
);
await AnalyticsManager().logSearch(searchTerm: 'Flutter');
```

：

```dart
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
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
          AnalyticsManager().logEvent('button_clicked', parameters: {
            'button_name': 'submit',
            'page': 'my_page',
          });
        },
        child: Text(''),
      ),
    );
  }
}
```

1.  Firebase 
2.  `google-services.json` (Android)  `GoogleService-Info.plist` (iOS)
3. ：
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

 `umeng_analytics_adapter.dart`  AppKey：

```dart
static const String _androidAppKey = 'YOUR_ANDROID_APPKEY';
static const String _iosAppKey = 'YOUR_IOS_APPKEY';
```

 AppKey：[](https://www.umeng.com/)。

 `RegionUtils` ：

```dart
bool isInChina = await RegionUtils.isUserInMainlandChina();
String lang = RegionUtils.getUserLanguageCode();
String country = RegionUtils.getUserCountryCode();
bool isChinese = RegionUtils.isChineseEnvironment();
```

```dart
AnalyticsManager().logEvent('view_item', parameters: {
  'item_id': 'SKU_123',
  'item_name': '',
  'item_category': '',
});
AnalyticsManager().logEvent('add_to_cart', parameters: {
  'item_id': 'SKU_123',
  'quantity': 1,
});
AnalyticsManager().logEvent('begin_checkout', parameters: {
  'value': 99.99,
  'currency': 'USD',
});
AnalyticsManager().logPurchase(
  currency: 'USD',
  value: 99.99,
  items: {
    'item_id': 'SKU_123',
    'quantity': 1,
  },
);
```

```dart
AnalyticsManager().logEvent('like', parameters: {
  'content_type': 'post',
  'content_id': 'post_123',
});
AnalyticsManager().logEvent('comment', parameters: {
  'content_type': 'post',
  'content_id': 'post_123',
});
AnalyticsManager().logShare(
  contentType: 'post',
  itemId: 'post_123',
);
```

1. ****：
   - （snake_case）
   - 
   -  40 

2. ****：
   - Firebase： 25 
   - ：，

3. ****：
   - （、）
   -  GDPR、CCPA 
   - 

4. ****：
   - 
   - 
   - 

：

```dart
UmengCommonSdk.setLogEnabled(true);  // 
```

- [Firebase Analytics ](https://firebase.google.com/docs/analytics)
- [](https://developer.umeng.com/docs/119267/detail/118584)
- [Flutter ](https://flutter.dev/docs/development/data-and-backend/firebase)


