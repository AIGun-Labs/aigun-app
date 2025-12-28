
- `currency_formatter_test.dart` - `CurrencyFormatter.abbreviateTokenPrice` 

```bash
flutter test test/utils/format/
flutter test test/utils/format/currency_formatter_test.dart
```

```bash
flutter test test/utils/format/currency_formatter_test.dart --name "fixedDecimals"
flutter test test/utils/format/currency_formatter_test.dart --name "maxDecimals"
flutter test test/utils/format/currency_formatter_test.dart --name ""
flutter test test/utils/format/currency_formatter_test.dart --name ""
flutter test test/utils/format/currency_formatter_test.dart --name ""
```

```bash
flutter test test/utils/format/currency_formatter_test.dart --name ""
```
：
- ✅ 0
- ✅ 
- ✅ 
- ✅ （2、4）
- ✅ 0
- ✅ 10000
：
- ✅ ，0
- ✅ ，
- ✅ （2、4）
- ✅ 
：
- ✅  < 10000：4
- ✅  ≥ 10000：2
- ✅ 
（< 0.0001）：
- ✅ 
- ✅  + fixedDecimals
- ✅  + 
- ✅  0.0001 
：
- ✅ 
- ✅ 
- ✅ 
：
- ✅ 
- ✅ 
- ✅ 
- ✅ 10000 
：
- ✅ symbol + fixedDecimals
- ✅ symbol + maxDecimals
- ✅  + symbol + fixedDecimals
：
- ✅  - （）
- ✅  - （）
- ✅ 9
：
- ✅ （）
- ✅ （）
- ✅ （）
- ✅ Meme（）
- ✅ 
- ✅ 

- ****: 36
- ****: 10
- ****: 100% ✅
```dart
CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 4)
```
```dart
CurrencyFormatter.abbreviateTokenPrice(123.56789, maxDecimals: 4)
```
```dart
CurrencyFormatter.abbreviateTokenPrice(0.00001234, fixedDecimals: 4)
```
```dart
CurrencyFormatter.abbreviateTokenPrice(123.5, symbol: '\$', fixedDecimals: 4)
```

- : `lib/utils/format/currency.dart`
- : `test/utils/format/currency_formatter_test.dart`
- : `lib/shared/widgets/candlestick.dart` (K)
