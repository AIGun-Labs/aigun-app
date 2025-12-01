import 'package:flutter_aigun/core/utils/twitter_image_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TwitterImageUtils', () {
    group('getTwitterImageWithSize', () {
      test('should remove _normal suffix and return original size', () {
        final result = TwitterImageUtils.getTwitterImageWithSize(
          'https://pbs.twimg.com/profile_images/1969818970942304256/xbfhJr7A_normal.jpg',
          size: 'original',
        );

        expect(
          result,
          'https://pbs.twimg.com/profile_images/1969818970942304256/xbfhJr7A.jpg',
        );
      });

      test('should remove _normal suffix and return original size', () {
        final result = TwitterImageUtils.getTwitterImageWithSize(
          'https://pbs.twimg.com/profile_images/1833509376528945157/5AeMNn9f__normal.jpg',
          size: 'original',
        );

        expect(
          result,
          'https://pbs.twimg.com/profile_images/1833509376528945157/5AeMNn9f_.jpg',
        );
      });
    });
  });

  // group('ImageUtils', () {
  //   group('getAvatarUrl', () {
  //     test('should prepend avatar path prefix', () {
  //       final result = ImageUtils.getAvatarUrl('user123.png');
  //       expect(result, contains('/fission/images/avatar/user123.png'));
  //     });

  //     test('should handle null input', () {
  //       final result = ImageUtils.getAvatarUrl(null);
  //       expect(result, contains('/fission/images/avatar/null'));
  //     });
  //   });

  //   group('getImageUrl', () {
  //     test('should return empty string for null path', () {
  //       expect(ImageUtils.getImageUrl(null), '');
  //     });

  //     test('should return empty string for empty path', () {
  //       expect(ImageUtils.getImageUrl(''), '');
  //       expect(ImageUtils.getImageUrl('   '), '');
  //     });

  //     test('should return empty string for numeric-only path', () {
  //       expect(ImageUtils.getImageUrl('123'), '');
  //       expect(ImageUtils.getImageUrl('456789'), '');
  //       expect(ImageUtils.getImageUrl('0'), '');
  //     });

  //     test('should return OKLink URL directly', () {
  //       const okLinkUrl =
  //           'https://static.oklink.com/cdn/web3/currency/token/large/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-1/test.png';
  //       expect(ImageUtils.getImageUrl(okLinkUrl), okLinkUrl);
  //     });

  //     test('should return GitHub raw URL directly', () {
  //       const githubUrl =
  //           'https://raw.githubusercontent.com/user/repo/main/image.png';
  //       expect(ImageUtils.getImageUrl(githubUrl), githubUrl);
  //     });

  //     test('should handle relative paths', () {
  //       final result = ImageUtils.getImageUrl('/images/test.png');
  //       expect(result, isNotEmpty);
  //       expect(result, contains('images/test.png'));
  //     });

  //     test('should handle paths without leading slash', () {
  //       final result = ImageUtils.getImageUrl('images/test.png');
  //       expect(result, isNotEmpty);
  //       expect(result, contains('images/test.png'));
  //     });

  //     test('should handle absolute HTTP URLs', () {
  //       const httpUrl = 'https://example.com/image.png';
  //       final result = ImageUtils.getImageUrl(httpUrl);
  //       expect(result, httpUrl);
  //     });

  //     test('should handle absolute HTTP URLs (non-HTTPS)', () {
  //       const httpUrl = 'http://example.com/image.png';
  //       final result = ImageUtils.getImageUrl(httpUrl);
  //       expect(result, httpUrl);
  //     });
  //   });

  //   group('getImageProxyUrl', () {
  //     test('should return empty string for null path', () {
  //       expect(ImageUtils.getImageProxyUrl(null), '');
  //     });

  //     test('should return empty string for empty path', () {
  //       expect(ImageUtils.getImageProxyUrl(''), '');
  //       expect(ImageUtils.getImageProxyUrl('   '), '');
  //     });

  //     test('should return empty string for numeric-only path', () {
  //       expect(ImageUtils.getImageProxyUrl('123'), '');
  //       expect(ImageUtils.getImageProxyUrl('456789'), '');
  //     });

  //     test('should return OKLink URL directly without proxy', () {
  //       const okLinkUrl =
  //           'https://static.oklink.com/cdn/web3/currency/token/large/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-1/test.png';
  //       expect(ImageUtils.getImageProxyUrl(okLinkUrl), okLinkUrl);
  //     });

  //     test('should return GitHub raw URL directly without proxy', () {
  //       const githubUrl =
  //           'https://raw.githubusercontent.com/user/repo/main/image.png';
  //       expect(ImageUtils.getImageProxyUrl(githubUrl), githubUrl);
  //     });

  //     test('should use proxy for external HTTP URLs', () {
  //       const externalUrl = 'https://example.com/image.png';
  //       final result = ImageUtils.getImageProxyUrl(externalUrl);
  //       expect(result, contains('/api/v1/proxy?url='));
  //     });

  //     test('should handle relative paths without proxy', () {
  //       final result = ImageUtils.getImageProxyUrl('/images/test.png');
  //       expect(result, isNotEmpty);
  //       expect(result, contains('images/test.png'));
  //     });
  //   });

  //   group('isRawUrl', () {
  //     test('should return true for GitHub raw URLs', () {
  //       expect(
  //         ImageUtils.isRawUrl(
  //           'https://raw.githubusercontent.com/user/repo/main/file.png',
  //         ),
  //         true,
  //       );
  //       expect(ImageUtils.isRawUrl('https://raw.githubusercontent.com/'), true);
  //     });

  //     test('should return false for non-GitHub raw URLs', () {
  //       expect(ImageUtils.isRawUrl('https://github.com/user/repo'), false);
  //       expect(ImageUtils.isRawUrl('https://example.com/raw/file.png'), false);
  //       expect(ImageUtils.isRawUrl('http://raw.githubusercontent.com/'), false);
  //     });

  //     test('should return false for null', () {
  //       expect(ImageUtils.isRawUrl(null), false);
  //     });

  //     test('should return false for empty string', () {
  //       expect(ImageUtils.isRawUrl(''), false);
  //     });
  //   });

  //   group('Edge Cases', () {
  //     test('should handle paths with special characters', () {
  //       final result = ImageUtils.getImageUrl('/images/test image.png');
  //       expect(result, isNotEmpty);
  //     });

  //     test('should handle paths with query parameters', () {
  //       const urlWithParams =
  //           'https://example.com/image.png?size=large&format=webp';
  //       final result = ImageUtils.getImageUrl(urlWithParams);
  //       expect(result, urlWithParams);
  //     });

  //     test('should handle paths with fragments', () {
  //       const urlWithFragment = 'https://example.com/image.png#section';
  //       final result = ImageUtils.getImageUrl(urlWithFragment);
  //       expect(result, urlWithFragment);
  //     });

  //     test('should handle mixed case in protocol', () {
  //       const mixedCaseUrl = 'HTTPS://example.com/image.png';
  //       final result = ImageUtils.getImageUrl(mixedCaseUrl);
  //       // Should not match startsWith('http') due to case sensitivity
  //       expect(result, isNotEmpty);
  //     });

  //     test('should handle multiple leading slashes', () {
  //       final result = ImageUtils.getImageUrl('//images/test.png');
  //       expect(result, isNotEmpty);
  //     });

  //     test('should handle whitespace-only path', () {
  //       expect(ImageUtils.getImageUrl('   '), '');
  //       expect(ImageUtils.getImageUrl('\t\n'), '');
  //     });

  //     test('should handle numeric strings with leading zeros', () {
  //       // "0123" should not be treated as numeric-only (has leading zero)
  //       final result = ImageUtils.getImageUrl('0123');
  //       expect(result, '');
  //     });

  //     test('should handle alphanumeric paths', () {
  //       final result = ImageUtils.getImageUrl('abc123');
  //       expect(result, isNotEmpty);
  //     });
  //   });

  //   group('URL Construction', () {
  //     test('should not add triple slashes in URL construction', () {
  //       final result = ImageUtils.getImageUrl('/images/test.png');
  //       // Check for triple slashes which would indicate improper URL construction
  //       expect(result, isNot(contains('///')));
  //     });

  //     test('should handle CDN URL that already contains the path', () {
  //       // This test assumes the path starts with the CDN base URL
  //       // The actual behavior depends on EnvConfig().cdn value
  //       final result = ImageUtils.getImageUrl('test.png');
  //       expect(result, isNotEmpty);
  //     });
  //   });

  //   group('Performance', () {
  //     test('should handle large number of calls efficiently', () {
  //       final stopwatch = Stopwatch()..start();

  //       for (int i = 0; i < 1000; i++) {
  //         ImageUtils.getImageUrl('test$i.png');
  //         ImageUtils.getImageProxyUrl('proxy$i.png');
  //         ImageUtils.isRawUrl('https://example.com/$i.png');
  //       }

  //       stopwatch.stop();

  //       // Should complete 3000 operations in reasonable time (< 1 second)
  //       expect(stopwatch.elapsedMilliseconds, lessThan(1000));
  //     });

  //     test('should reuse regex instance', () {
  //       // Multiple calls with numeric strings should use the same regex
  //       ImageUtils.getImageUrl('123');
  //       ImageUtils.getImageUrl('456');
  //       ImageUtils.getImageUrl('789');

  //       // If regex is reused, this should be fast
  //       final stopwatch = Stopwatch()..start();
  //       for (int i = 0; i < 100; i++) {
  //         ImageUtils.getImageUrl('$i');
  //       }
  //       stopwatch.stop();

  //       expect(stopwatch.elapsedMilliseconds, lessThan(100));
  //     });
  //   });
  // });
}
