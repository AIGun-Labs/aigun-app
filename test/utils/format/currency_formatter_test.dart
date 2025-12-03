import 'package:aigun/utils/format/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter.abbreviateTokenPrice', () {
    group('fixedDecimals 参数测试 - 固定保留指定位数', () {
      test('fixedDecimals: 4 - 少于4位小数，应该补0', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 4),
          '123.5000',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(0.1, fixedDecimals: 4),
          '0.1000',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(99.12, fixedDecimals: 4),
          '99.1200',
        );
      });

      test('fixedDecimals: 4 - 正好4位小数，保持不变', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5678, fixedDecimals: 4),
          '123.5678',
        );
      });

      test('fixedDecimals: 4 - 多于4位小数，应该四舍五入', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, fixedDecimals: 4),
          '123.5679',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, fixedDecimals: 4),
          '123.5678',
        );
      });

      test('fixedDecimals: 2 - 保留2位小数', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 2),
          '123.50',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567, fixedDecimals: 2),
          '123.57',
        );
      });

      test('fixedDecimals: 4 - 整数应该补4个0', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(100.0, fixedDecimals: 4),
          '100.0000',
        );
      });

      test('fixedDecimals: 4 - 大于10000的价格', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.5, fixedDecimals: 4),
          '15,000.5000',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.567, fixedDecimals: 4),
          '15,000.5670',
        );
      });
    });

    group('maxDecimals 参数测试 - 最大小数位数限制', () {
      test('maxDecimals: 4 - 少于4位，去除尾部0', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, maxDecimals: 4),
          '123.5',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.50, maxDecimals: 4),
          '123.5',
        );
      });

      test('maxDecimals: 4 - 多于4位，四舍五入到4位', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, maxDecimals: 4),
          '123.5679', // 四舍五入
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, maxDecimals: 4),
          '123.5678', // 四舍五入
        );
      });

      test('maxDecimals: 2 - 限制最多2位小数', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5678, maxDecimals: 2),
          '123.57', // 四舍五入
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5628, maxDecimals: 2),
          '123.56', // 四舍五入
        );
      });

      test('maxDecimals: 4 - 整数去除小数点', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(100.0, maxDecimals: 4),
          '100',
        );
      });
    });

    group('默认行为测试 - 不传参数', () {
      test('价格 < 10000 - 默认最多4位小数，去除尾部0', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(123.5), '123.5');
        expect(CurrencyFormatter.abbreviateTokenPrice(123.5678), '123.5678');
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567891),
          '123.5679', // 四舍五入
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567841),
          '123.5678', // 四舍五入
        );
      });

      test('价格 ≥ 10000 - 默认最多2位小数，去除尾部0', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(15000.5), '15,000.5');
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.567),
          '15,000.57', // 四舍五入
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.564),
          '15,000.56', // 四舍五入
        );
      });

      test('整数价格去除小数点', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(100.0), '100');
        expect(CurrencyFormatter.abbreviateTokenPrice(15000.0), '15,000');
      });
    });

    group('极小数值测试 - 下标表示法 (< 0.0001)', () {
      test('极小数值使用下标表示法', () {
        // 0.00001234 应该显示为 0.0₄1234
        final result = CurrencyFormatter.abbreviateTokenPrice(0.00001234);
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
      });

      test('极小数值 - fixedDecimals: 4', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00001234,
          fixedDecimals: 4,
        );
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
        // 应该保留4位有效数字
        expect(result.contains('1234'), true);
      });

      test('极小数值 - fixedDecimals: 2', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00001234,
          fixedDecimals: 2,
        );
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
        // 应该只保留2位有效数字
        expect(result.contains('12'), true);
      });

      test('临界值 0.0001 不应使用下标表示法', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(0.0001);
        expect(result.contains('₄'), false);
        expect(result, '0.0001');
      });
    });

    group('symbol 参数测试', () {
      test('不传 symbol - 默认无货币符号', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 4),
          '123.5000',
        );
      });

      test('传入 symbol: \$ - 添加美元符号', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.5,
            symbol: '\$',
            fixedDecimals: 4,
          ),
          '\$123.5000',
        );
      });

      test('传入自定义 symbol', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.5,
            symbol: '¥',
            fixedDecimals: 4,
          ),
          '¥123.5000',
        );
      });
    });

    group('边界值测试', () {
      test('0 值', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(0.0, fixedDecimals: 4),
          '0.0000',
        );
      });

      test('非常小的正数', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(0.000000001);
        expect(result.contains('0.0'), true);
        // 0.000000001 有 8 个 0，应该显示下标 ₈
        expect(result.contains('₈'), true);
      });

      test('大数值 - 带千位分隔符', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(1234567.89, fixedDecimals: 2),
          '1,234,567.89',
        );
      });

      test('10000 临界值 - 价格规则切换', () {
        // 9999.99 < 10000，使用4位小数规则
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.99), '9,999.99');
        // 9999.9999 < 10000，仍使用4位小数规则
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.9999), '9,999.9999');
        // 9999.99999 会四舍五入到 10000
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.99999), '10,000');

        // 10000 >= 10000，使用2位小数规则
        expect(CurrencyFormatter.abbreviateTokenPrice(10000.0), '10,000');
        expect(CurrencyFormatter.abbreviateTokenPrice(10000.56), '10,000.56');
      });
    });

    group('组合参数测试', () {
      test('同时设置 symbol 和 fixedDecimals', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.5,
            symbol: '\$',
            fixedDecimals: 4,
          ),
          '\$123.5000',
        );
      });

      test('同时设置 symbol 和 maxDecimals', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.56789,
            symbol: '\$',
            maxDecimals: 4,
          ),
          '\$123.5679', // 四舍五入
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.56784,
            symbol: '\$',
            maxDecimals: 4,
          ),
          '\$123.5678', // 四舍五入
        );
      });

      test('极小数值 + symbol + fixedDecimals', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00001234,
          symbol: '\$',
          fixedDecimals: 4,
        );
        expect(result.startsWith('\$'), true);
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
      });
    });

    group('精度测试', () {
      test('四舍五入 - 入', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, fixedDecimals: 4),
          '123.5679',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.99999, fixedDecimals: 2),
          '124.00',
        );
      });

      test('四舍五入 - 舍', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, fixedDecimals: 4),
          '123.5678',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.12344, fixedDecimals: 2),
          '123.12',
        );
      });

      test('连续的9 - 进位测试', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(9.99999, fixedDecimals: 2),
          '10.00',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(99.99999, fixedDecimals: 2),
          '100.00',
        );
      });
    });

    group('实际场景测试 - 加密货币价格', () {
      test('比特币价格 - 大额', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(43567.89, fixedDecimals: 2),
          '43,567.89',
        );
      });

      test('以太坊价格 - 中等', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(2345.6789, fixedDecimals: 4),
          '2,345.6789',
        );
      });

      test('小币种价格 - 较小', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(0.1234, fixedDecimals: 4),
          '0.1234',
        );
      });

      test('Meme币价格 - 极小', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00000123,
          fixedDecimals: 4,
        );
        expect(result.contains('0.0'), true);
        expect(result.contains('₅'), true);
        expect(result.contains('1230'), true);
      });
    });
  });

  group('CurrencyFormatter.abbreviateTokenPriceWithSymbol', () {
    test('默认美元符号', () {
      expect(
        CurrencyFormatter.abbreviateTokenPriceWithSymbol(123.5),
        startsWith('\$'),
      );
    });

    test('自定义符号', () {
      expect(
        CurrencyFormatter.abbreviateTokenPriceWithSymbol(123.5, symbol: '¥'),
        startsWith('¥'),
      );
    });
  });
}
