import 'package:web3dart/web3dart.dart';

class GasCalculator {
  /// 计算 gas 费用
  /// [gasPrice] gas 价格
  /// [decimals] token 精度
  /// [gasLimit] gas 限制
  static EtherAmount calculateGasFee({
    required String gasPrice,
    String? gasLimit,
  }) {
    // 安全的 BigInt 解析
    final gasPriceBigInt = _safeParseBigInt(gasPrice);

    // 如果解析失败，返回 0 wei
    if (gasPriceBigInt == null) {
      return EtherAmount.inWei(BigInt.zero);
    }

    return EtherAmount.inWei(gasPriceBigInt);
  }

  /// 安全的 BigInt 解析方法
  /// 处理各种边界情况和无效输入
  static BigInt? _safeParseBigInt(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // 移除空白字符
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return null;
    }

    try {
      // 尝试直接解析
      return BigInt.parse(trimmedValue);
    } catch (e) {
      // 如果直接解析失败，尝试处理科学计数法
      if (trimmedValue.contains('e') || trimmedValue.contains('E')) {
        try {
          // 将科学计数法转换为普通数字
          final doubleValue = double.parse(trimmedValue);
          // 转换为整数（以 wei 为单位）
          return BigInt.from(doubleValue * 1e18);
        } catch (e2) {
          print(
              'Failed to parse scientific notation: $trimmedValue, error: $e2');
          return null;
        }
      }

      // 如果包含小数点，尝试处理小数
      if (trimmedValue.contains('.')) {
        try {
          final doubleValue = double.parse(trimmedValue);
          // 转换为整数（以 wei 为单位）
          return BigInt.from(doubleValue * 1e18);
        } catch (e2) {
          print('Failed to parse decimal: $trimmedValue, error: $e2');
          return null;
        }
      }

      print('Failed to parse BigInt: $trimmedValue, error: $e');
      return null;
    }
  }

  /// 格式化 gas 价格显示
  /// [gasPrice] gas 价格
  /// [decimals] token 精度
  static String formatGasPrice({
    required String gasPrice,
    required int decimals,
  }) {
    final gasPriceBigInt = _safeParseBigInt(gasPrice);

    // 如果解析失败，返回默认值
    if (gasPriceBigInt == null) {
      return '0.0';
    }

    final divisor = BigInt.from(10).pow(decimals);
    final quotient = gasPriceBigInt ~/ divisor;
    final remainder = gasPriceBigInt % divisor;

    return '$quotient.${remainder.toString().padLeft(decimals, '0')}';
  }
}
