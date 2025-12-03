import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import 'select_button.dart';

class FastSelectButtons extends StatelessWidget {
  const FastSelectButtons({
    super.key,
    required this.onPressed,
    required this.fastSelectButtons,
  });

  final Function(String) onPressed;

  final List<(String, String)> fastSelectButtons;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: fastSelectButtons
          .map(
            (button) => FastSelectButton(
              text: button.$1,
              value: button.$2,
              onPressed: onPressed,
            ),
          )
          .toList(),
    );
  }
}

class FastSellButtons extends StatelessWidget {
  FastSellButtons({super.key, required this.onPressed});

  final Function(String) onPressed;
  final List<(String, String)> _sellMaps = [
    ('25%', '25'),
    ('50%', '50'),
    ('75%', '75'),
  ];

  @override
  Widget build(BuildContext context) {
    return FastSelectButtons(
      onPressed: onPressed,
      fastSelectButtons: [..._sellMaps, (S.of(context).all, 'all')],
    );
  }
}

class FastBuyButtons extends StatelessWidget {
  const FastBuyButtons({super.key, required this.onPressed});

  final Function(String) onPressed;
  static const buyMaps = [
    ('0.2', '0.2'),
    ('0.5', '0.5'),
    ('1', '1'),
    ('2', '2'),
  ];

  @override
  Widget build(BuildContext context) {
    return FastSelectButtons(onPressed: onPressed, fastSelectButtons: buyMaps);
  }
}
