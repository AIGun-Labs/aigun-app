import 'package:aigun/utils/format/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter.abbreviateTokenPrice', () {
    group('fixedDecimals  - ', () {
      test('fixedDecimals: 4 - 4，0', () {
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

      test('fixedDecimals: 4 - 4，', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5678, fixedDecimals: 4),
          '123.5678',
        );
      });

      test('fixedDecimals: 4 - 4，', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, fixedDecimals: 4),
          '123.5679',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, fixedDecimals: 4),
          '123.5678',
        );
      });

      test('fixedDecimals: 2 - 2', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 2),
          '123.50',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567, fixedDecimals: 2),
          '123.57',
        );
      });

      test('fixedDecimals: 4 - 40', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(100.0, fixedDecimals: 4),
          '100.0000',
        );
      });

      test('fixedDecimals: 4 - 10000', () {
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

    group('maxDecimals  - ', () {
      test('maxDecimals: 4 - 4，0', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, maxDecimals: 4),
          '123.5',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.50, maxDecimals: 4),
          '123.5',
        );
      });

      test('maxDecimals: 4 - 4，4', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, maxDecimals: 4),
          '123.5679', //
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, maxDecimals: 4),
          '123.5678', //
        );
      });

      test('maxDecimals: 2 - 2', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5678, maxDecimals: 2),
          '123.57', //
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5628, maxDecimals: 2),
          '123.56', //
        );
      });

      test('maxDecimals: 4 - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(100.0, maxDecimals: 4),
          '100',
        );
      });
    });

    group(' - ', () {
      test(' < 10000 - 4，0', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(123.5), '123.5');
        expect(CurrencyFormatter.abbreviateTokenPrice(123.5678), '123.5678');
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567891),
          '123.5679', //
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.567841),
          '123.5678', //
        );
      });

      test(' ≥ 10000 - 2，0', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(15000.5), '15,000.5');
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.567),
          '15,000.57', //
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(15000.564),
          '15,000.56', //
        );
      });

      test('', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(100.0), '100');
        expect(CurrencyFormatter.abbreviateTokenPrice(15000.0), '15,000');
      });
    });

    group(' -  (< 0.0001)', () {
      test('', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(0.00001234);
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
      });

      test(' - fixedDecimals: 4', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00001234,
          fixedDecimals: 4,
        );
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
        expect(result.contains('1234'), true);
      });

      test(' - fixedDecimals: 2', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(
          0.00001234,
          fixedDecimals: 2,
        );
        expect(result.contains('0.0'), true);
        expect(result.contains('₄'), true);
        expect(result.contains('12'), true);
      });

      test(' 0.0001 ', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(0.0001);
        expect(result.contains('₄'), false);
        expect(result, '0.0001');
      });
    });

    group('symbol ', () {
      test(' symbol - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.5, fixedDecimals: 4),
          '123.5000',
        );
      });

      test(' symbol: \$ - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.5,
            symbol: '\$',
            fixedDecimals: 4,
          ),
          '\$123.5000',
        );
      });

      test(' symbol', () {
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

    group('', () {
      test('0 ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(0.0, fixedDecimals: 4),
          '0.0000',
        );
      });

      test('', () {
        final result = CurrencyFormatter.abbreviateTokenPrice(0.000000001);
        expect(result.contains('0.0'), true);
        expect(result.contains('₈'), true);
      });

      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(1234567.89, fixedDecimals: 2),
          '1,234,567.89',
        );
      });

      test('10000  - ', () {
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.99), '9,999.99');
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.9999), '9,999.9999');
        expect(CurrencyFormatter.abbreviateTokenPrice(9999.99999), '10,000');
        expect(CurrencyFormatter.abbreviateTokenPrice(10000.0), '10,000');
        expect(CurrencyFormatter.abbreviateTokenPrice(10000.56), '10,000.56');
      });
    });

    group('', () {
      test(' symbol  fixedDecimals', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.5,
            symbol: '\$',
            fixedDecimals: 4,
          ),
          '\$123.5000',
        );
      });

      test(' symbol  maxDecimals', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.56789,
            symbol: '\$',
            maxDecimals: 4,
          ),
          '\$123.5679', //
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(
            123.56784,
            symbol: '\$',
            maxDecimals: 4,
          ),
          '\$123.5678', //
        );
      });

      test(' + symbol + fixedDecimals', () {
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

    group('', () {
      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56789, fixedDecimals: 4),
          '123.5679',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.99999, fixedDecimals: 2),
          '124.00',
        );
      });

      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.56784, fixedDecimals: 4),
          '123.5678',
        );
        expect(
          CurrencyFormatter.abbreviateTokenPrice(123.12344, fixedDecimals: 2),
          '123.12',
        );
      });

      test('9 - ', () {
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

    group(' - ', () {
      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(43567.89, fixedDecimals: 2),
          '43,567.89',
        );
      });

      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(2345.6789, fixedDecimals: 4),
          '2,345.6789',
        );
      });

      test(' - ', () {
        expect(
          CurrencyFormatter.abbreviateTokenPrice(0.1234, fixedDecimals: 4),
          '0.1234',
        );
      });

      test('Meme - ', () {
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
    test('', () {
      expect(
        CurrencyFormatter.abbreviateTokenPriceWithSymbol(123.5),
        startsWith('\$'),
      );
    });

    test('', () {
      expect(
        CurrencyFormatter.abbreviateTokenPriceWithSymbol(123.5, symbol: '¥'),
        startsWith('¥'),
      );
    });
  });
}
