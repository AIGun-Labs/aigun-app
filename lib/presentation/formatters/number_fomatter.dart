import 'package:flutter/widgets.dart';
import '../../core/formatting/number_format_core.dart';

class NumberFormatter {
  NumberFormatter._();

  static String thousand(num? v, BuildContext ctx, {int fractionDigits = 0}) =>
      NumberFormatCore.thousand(
        v,
        locale: Localizations.localeOf(ctx).toLanguageTag(),
        fractionDigits: fractionDigits,
      );

  static String compact(num? v, BuildContext ctx, {int? fractionDigits}) =>
      NumberFormatCore.compact(
        v,
        locale: Localizations.localeOf(ctx).toLanguageTag(),
        fractionDigits: fractionDigits,
      );
}
