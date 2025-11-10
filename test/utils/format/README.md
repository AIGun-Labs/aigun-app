# CurrencyFormatter 单元测试

## 测试文件

- `currency_formatter_test.dart` - `CurrencyFormatter.abbreviateTokenPrice` 方法的全面单元测试

## 运行测试

### 运行所有测试

```bash
# 运行所有格式化测试
flutter test test/utils/format/

# 只运行 CurrencyFormatter 测试
flutter test test/utils/format/currency_formatter_test.dart
```

### 运行特定测试组

```bash
# 运行 fixedDecimals 参数测试
flutter test test/utils/format/currency_formatter_test.dart --name "fixedDecimals"

# 运行 maxDecimals 参数测试
flutter test test/utils/format/currency_formatter_test.dart --name "maxDecimals"

# 运行默认行为测试
flutter test test/utils/format/currency_formatter_test.dart --name "默认行为"

# 运行极小数值测试
flutter test test/utils/format/currency_formatter_test.dart --name "极小数值"

# 运行边界值测试
flutter test test/utils/format/currency_formatter_test.dart --name "边界值"
```

### 运行特定测试用例

```bash
# 示例：运行四舍五入测试
flutter test test/utils/format/currency_formatter_test.dart --name "四舍五入"
```

## 测试覆盖范围

### 1. fixedDecimals 参数测试（6个测试）
测试固定保留指定位数的功能：
- ✅ 少于指定位数自动补0
- ✅ 正好指定位数保持不变
- ✅ 多于指定位数四舍五入
- ✅ 不同的固定位数（2位、4位）
- ✅ 整数补0
- ✅ 大于10000的价格

### 2. maxDecimals 参数测试（4个测试）
测试最大小数位数限制功能：
- ✅ 少于最大位数，去除尾部0
- ✅ 多于最大位数，四舍五入到最大位数
- ✅ 不同的最大位数（2位、4位）
- ✅ 整数去除小数点

### 3. 默认行为测试（3个测试）
测试不传参数时的默认规则：
- ✅ 价格 < 10000：默认最多4位小数
- ✅ 价格 ≥ 10000：默认最多2位小数
- ✅ 整数价格去除小数点

### 4. 极小数值测试（4个测试）
测试下标表示法（< 0.0001）：
- ✅ 极小数值使用下标表示法
- ✅ 极小数值 + fixedDecimals
- ✅ 极小数值 + 不同的固定位数
- ✅ 临界值 0.0001 不使用下标

### 5. symbol 参数测试（3个测试）
测试货币符号功能：
- ✅ 默认无货币符号
- ✅ 添加美元符号
- ✅ 添加自定义符号

### 6. 边界值测试（4个测试）
测试边界情况：
- ✅ 零值处理
- ✅ 非常小的正数
- ✅ 大数值带千位分隔符
- ✅ 10000 临界值规则切换

### 7. 组合参数测试（3个测试）
测试多个参数组合：
- ✅ symbol + fixedDecimals
- ✅ symbol + maxDecimals
- ✅ 极小数值 + symbol + fixedDecimals

### 8. 精度测试（3个测试）
测试四舍五入精度：
- ✅ 四舍五入 - 入（向上）
- ✅ 四舍五入 - 舍（向下）
- ✅ 连续的9进位测试

### 9. 实际场景测试（4个测试）
测试加密货币价格场景：
- ✅ 比特币价格（大额）
- ✅ 以太坊价格（中等）
- ✅ 小币种价格（较小）
- ✅ Meme币价格（极小）

### 10. abbreviateTokenPriceWithSymbol 测试（2个测试）
- ✅ 默认美元符号
- ✅ 自定义符号

## 测试统计

- **总测试数**: 36
- **测试组数**: 10
- **通过率**: 100% ✅

## 测试示例

### 固定保留4位小数
```dart
CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 4)
// 结果: "123.5000"
```

### 最多保留4位小数
```dart
CurrencyFormatter.abbreviateTokenPrice(123.56789, maxDecimals: 4)
// 结果: "123.5679" (四舍五入)
```

### 极小数值
```dart
CurrencyFormatter.abbreviateTokenPrice(0.00001234, fixedDecimals: 4)
// 结果: "0.0₄1234"
```

### 带货币符号
```dart
CurrencyFormatter.abbreviateTokenPrice(123.5, symbol: '\$', fixedDecimals: 4)
// 结果: "$123.5000"
```

## 相关文件

- 源代码: `lib/utils/format/currency.dart`
- 测试代码: `test/utils/format/currency_formatter_test.dart`
- 使用示例: `lib/shared/widgets/candlestick.dart` (K线图工具提示)
