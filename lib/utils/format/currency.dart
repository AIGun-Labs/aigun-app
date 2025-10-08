import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class CurrencyFormatter {
  /// 格式化数字，规则如下：
  /// 1. 如果数字小于0.0001，显示科学计数法（如：0.0000123 => 0.0{4}123）
  /// 2. 个位数保留4位小数
  /// 3. 十位及以上保留2位小数
  /// 4. 去除尾部多余的0
  static String format(
    double amount, {
    bool showCurrency = false,
    String? currencyCode,
  }) {
    // 处理极小数值
    if (amount > 0 && amount < 0.0001) {
      return _formatSmallNumber(amount);
    }

    // 确定小数位数
    final decimalPlaces = _getDecimalPlaces(amount);

    if (currencyCode != null) {
      String pattern =
          '${showCurrency ? 'S' : ''}#,###.${List.filled(decimalPlaces, '#').join()}';

      final currency = Currency.create(
        currencyCode,
        decimalPlaces,
        pattern: pattern,
      );

      String formatted;

      formatted = Money.fromNum(
        amount,
        isoCode: currency.isoCode,
        decimalDigits: decimalPlaces,
      ).format(pattern);

      // 去除尾部多余的0
      return _removeTrailingZeros(formatted);
    }

    // 无货币格式化，去除尾部多余的0
    final formattedNumber = amount.toStringAsFixed(decimalPlaces);
    return _removeTrailingZeros(formattedNumber);
  }

  /// 去除尾部多余的0
  static String _removeTrailingZeros(String number) {
    if (!number.contains('.')) return number;

    // 移除整数后的.0
    // 移除小数后的0
    return number
        .replaceAll(RegExp(r'\.?0+$'), '')
        .replaceAll(RegExp(r'(\.\d*?)0+$'), '\$1');
  }

  /// 处理极小数值的格式化
  static String _formatSmallNumber(double number) {
    final scientificStr = number.toStringAsFixed(10);
    final parts = scientificStr.split('');

    int leadingZeros = 0;
    bool startCounting = false;

    for (var char in parts) {
      if (char == '0' && !startCounting) {
        continue;
      } else if (char == '.') {
        startCounting = true;
      } else if (startCounting) {
        if (char == '0') {
          leadingZeros++;
        } else {
          break;
        }
      }
    }

    if (leadingZeros >= 4) {
      // 移除尾部的0
      final significantDigits = scientificStr
          .replaceFirst('0.', '')
          .replaceAll(RegExp('^0+'), '')
          .replaceAll(RegExp('0+\$'), '');

      return '0.0{$leadingZeros}$significantDigits';
    }

    return _removeTrailingZeros(scientificStr);
  }

  /// 根据数值大小确定小数位数
  static int _getDecimalPlaces(double amount) {
    final absAmount = amount.abs();
    if (absAmount >= 0.0001 && absAmount < 10) {
      return 4;
    } else if (absAmount >= 10) {
      return 2;
    }
    return 10; // 对于小于0.0001的数字，使用10位小数以保留精度
  }

  /// 带货币符号的格式化
  static String formatWithSymbol(double amount, String currencyCode) {
    return format(amount, showCurrency: true, currencyCode: currencyCode);
  }

  static String formatWithFourDecimals(double amount) {
    //  创建自定义货币，精度为 4
    final pseudoCurrency = Currency.create('XXX', 4);

    // 2. 使用该货币从数字创建 Money 实例
    final money = Money.fromNumWithCurrency(amount, pseudoCurrency);

    return money.format('#.####');
  }

  static String formatPriceWithSymbol(String amount) {
    return "\$${formatPrice(amount)}";
  }

  static String formatPrice(String amount) {
    return _formatSmallNumber(double.tryParse(amount) ?? 0);
  }

  /// 根据特定规则格式化并缩写代币价格。
  ///
  /// 此函数的核心功能是当价格足够小时（小数点后有4个或更多连续的零），
  /// 会将其格式化为带有下标的缩写形式 (例如, $0.0₅1234)。
  /// 对于其他数值，则应用标准的价格格式化规则。
  ///
  /// [price] 需要格式化的原始代币价格
  /// 返回格式化或缩写后的价格字符串
  static String abbreviateTokenPrice(double price, {int decimals = 4}) {
    // (1) 缩写判断：当价格大于0且小于0.0001时，检查是否需要缩写
    if (price > 0 && price < 0.0001) {
      // 使用足够高的精度来转换为字符串，以精确计算小数点后的零
      String priceStr = price.toStringAsFixed(20);

      // 找到小数点后第一个非零数字的索引
      int firstNonZeroIndex = priceStr.indexOf(RegExp(r'[1-9]'));

      if (firstNonZeroIndex != -1) {
        // "0." 占了两位，所以连续零的数量是索引减2
        int consecutiveZeros = firstNonZeroIndex - 2;

        // 当小数点后连续零 ≥ 4 时，使用下标缩写
        if (consecutiveZeros >= 4) {
          // 获取下标后的有效数字部分
          String significantPart = priceStr.substring(firstNonZeroIndex);

          // 处理四舍五入，最多保留4位有效数字
          String finalDigits;
          if (significantPart.length > decimals) {
            int roundingDigit = int.parse(significantPart[decimals]);
            if (roundingDigit >= 5) {
              // 需要进位
              int digitsToRound =
                  int.parse(significantPart.substring(0, decimals));
              finalDigits =
                  (digitsToRound + 1).toString().padLeft(decimals, '0');
            } else {
              finalDigits = significantPart.substring(0, decimals);
            }
          } else {
            finalDigits = significantPart;
          }

          // 移除末尾多余的零 (例如 0.0₈9990 -> 0.0₈999)
          while (finalDigits.endsWith('0') && finalDigits.length > 1) {
            finalDigits = finalDigits.substring(0, finalDigits.length - 1);
          }

          return '0.0${_numberToSubscript(consecutiveZeros)}$finalDigits';
        }
      }
    }

    // (2) 常规价格显示规则 (对于非缩写数值)
    final NumberFormat formatter;

    // 规则 B：价格 ≥ $10,000，保留2位小数并使用千分位
    if (price >= 10000) {
      formatter = NumberFormat('#,##0.00', 'en_US');
    }
    // 规则 A：价格 < $10,000，最多保留4位小数
    else {
      formatter = NumberFormat('0.####', 'en_US');
    }

    return formatter.format(price);
  }

  /// 辅助函数，将整数转换为下标格式的字符串。
  static String _numberToSubscript(int number) {
    const Map<String, String> subscripts = {
      '0': '₀',
      '1': '₁',
      '2': '₂',
      '3': '₃',
      '4': '₄',
      '5': '₅',
      '6': '₆',
      '7': '₇',
      '8': '₈',
      '9': '₉'
    };
    return number
        .toString()
        .split('')
        .map((char) => subscripts[char]!)
        .join('');
  }

  static String abbreviateTokenPriceWithSymbol(double price,
      {int decimals = 4}) {
    return "\$${abbreviateTokenPrice(price, decimals: decimals)}";
  }
}
