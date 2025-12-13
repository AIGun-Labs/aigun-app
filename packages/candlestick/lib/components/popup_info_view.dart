import 'package:flutter/material.dart';

import '../candlestick_widget.dart' show PriceFormatter;
import '../chart_style.dart';
import '../chart_translations.dart';
import '../entity/k_line_entity.dart';
import '../utils/date_format_util.dart';
import '../utils/number_util.dart';

class PopupInfoView extends StatelessWidget {
  final KLineEntity entity;
  final double width;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final ChartTranslations chartTranslations;
  final bool materialInfoDialog;
  final List<String> timeFormat;
  final int fixedLength;
  final PriceFormatter? priceFormatter;

  const PopupInfoView({
    Key? key,
    required this.entity,
    required this.width,
    required this.chartColors,
    required this.chartStyle,
    required this.chartTranslations,
    required this.materialInfoDialog,
    required this.timeFormat,
    required this.fixedLength,
    this.priceFormatter,
  }) : super(key: key);

  String formatPrice(double price) {
    if (priceFormatter != null) {
      return priceFormatter!(price);
    }
    return price.toStringAsFixed(fixedLength);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: chartColors.selectFillColor,
        border: chartStyle.popupBorderWidth > 0
            ? Border.all(
                color: chartColors.selectBorderColor,
                width: chartStyle.popupBorderWidth,
              )
            : null,
        borderRadius: chartStyle.popupBorderRadius > 0
            ? BorderRadius.circular(chartStyle.popupBorderRadius)
            : null,
      ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: chartStyle.popupPadding,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    double upDown = entity.change ?? entity.close - entity.open;
    double upDownPercent = entity.ratio ?? (upDown / entity.open) * 100;
    final double? entityAmount = entity.amount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItem(chartTranslations.date, getDate(entity.time)),
        _buildItem(chartTranslations.open, formatPrice(entity.open)),
        _buildItem(chartTranslations.high, formatPrice(entity.high)),
        _buildItem(chartTranslations.low, formatPrice(entity.low)),
        _buildItem(chartTranslations.close, formatPrice(entity.close)),
        _buildColorItem(chartTranslations.changeAmount,
            formatPrice(upDown), upDown > 0),
        _buildColorItem(chartTranslations.change,
            '${upDownPercent.toStringAsFixed(2)}%', upDownPercent > 0),
        _buildItem(chartTranslations.vol, NumberUtil.format(entity.vol)),
        if (entityAmount != null)
          _buildItem(chartTranslations.amount, entityAmount.toInt().toString()),
      ],
    );
  }

  Widget _buildColorItem(String label, String info, bool isUp) {
    if (isUp) {
      return _buildItem(label, '+$info',
          textColor: chartColors.infoWindowUpColor);
    }
    return _buildItem(label, info, textColor: chartColors.infoWindowDnColor);
  }

  Widget _buildItem(String label, String info, {Color? textColor}) {
    final infoWidget = Padding(
      padding: EdgeInsets.only(bottom: chartStyle.popupItemSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: chartColors.infoWindowTitleColor,
              fontSize: chartStyle.popupTitleFontSize,
            ),
          ),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                  color: textColor ?? chartColors.infoWindowNormalColor,
                  fontSize: chartStyle.popupValueFontSize),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
    return materialInfoDialog
        ? Material(color: Colors.transparent, child: infoWidget)
        : infoWidget;
  }

  String getDate(int? date) => dateFormat(
        DateTime.fromMillisecondsSinceEpoch(
            date ?? DateTime.now().millisecondsSinceEpoch),
        timeFormat,
      );
}
