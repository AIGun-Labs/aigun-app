import 'package:flutter/material.dart';

class ChartTheme {
  final Color backgroundColor;
  final Color textColor;
  final Color gridColor;
  final Color borderColor;
  final Color bullColor;
  final Color bearColor;
  final Color crosshairColor;
  final Color tooltipBackground;
  final Color tooltipBorder;
  final Color cardBackground;
  final Color secondaryTextColor;
  final Color chipBackground;
  final Color chipSelectedBackground;
  final Color dividerColor;

  const ChartTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.gridColor,
    required this.borderColor,
    required this.bullColor,
    required this.bearColor,
    required this.crosshairColor,
    required this.tooltipBackground,
    required this.tooltipBorder,
    required this.cardBackground,
    required this.secondaryTextColor,
    required this.chipBackground,
    required this.chipSelectedBackground,
    required this.dividerColor,
  });

  static const ChartTheme dark = ChartTheme(
    backgroundColor: Color(0xFF0D0D0D),
    textColor: Colors.white,
    gridColor: Color(0x1AFFFFFF),
    borderColor: Color(0x33FFFFFF),
    bullColor: Color(0xFF26A69A),
    bearColor: Color(0xFFEF5350),
    crosshairColor: Color(0xCCFFFFFF),
    tooltipBackground: Color(0xFF1E1E1E),
    tooltipBorder: Colors.grey,
    cardBackground: Color(0xFF1A1A1A),
    secondaryTextColor: Colors.grey,
    chipBackground: Color(0xFF2A2A2A),
    chipSelectedBackground: Color(0xFF26A69A),
    dividerColor: Color(0x33FFFFFF),
  );

  static const ChartTheme light = ChartTheme(
    backgroundColor: Colors.white,
    textColor: Color(0xFF1A1A1A),
    gridColor: Color(0x1A000000),
    borderColor: Color(0x33000000),
    bullColor: Color(0xFF26A69A),
    bearColor: Color(0xFFEF5350),
    crosshairColor: Color(0x33000000),
    tooltipBackground: Color(0xFFF5F5F5),
    tooltipBorder: Color(0xFF666666),
    cardBackground: Color(0xFFFAFAFA),
    secondaryTextColor: Color(0xFF666666),
    chipBackground: Color(0xFFE0E0E0),
    chipSelectedBackground: Color(0xFF26A69A),
    dividerColor: Color(0x33000000),
  );

  static ChartTheme fromBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}
