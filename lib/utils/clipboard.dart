import 'package:flutter/services.dart';

class ClipboardUtils {
  static Future<void> copy(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String> paste() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

    return data?.text ?? '';
  }
}
