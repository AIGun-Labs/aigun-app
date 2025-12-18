import 'package:flutter/cupertino.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'data_scrubber.dart';

class SentryService {
  SentryService(this._dataScrubber);

  final DataScrubber _dataScrubber;
  final bool _isInitialized = false;

  Future<void> initialize({
    required String dsn,
    required String environment,
    required bool isDebugMode,
  }) async {
    if (_isInitialized) {
      debugPrint('Sentry already initialized');
      return;
    }


    try {
      await SentryFlutter.init((options) {

      });
    } catch (e) {
      
    }
  }
}
