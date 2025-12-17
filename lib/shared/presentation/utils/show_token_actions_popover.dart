import 'package:flutter/material.dart';

import '../../../core/router/routes/token_action_route.dart';
import '../widgets/token_action_widget.dart';

Future<void> showTokenActionsPopover(
  BuildContext itemContext, {
  VoidCallback? onTransfer,
  VoidCallback? onCollect,
  bool isCollected = false,
}) async {
  if (onTransfer == null && onCollect == null) return;

  final renderBox = itemContext.findRenderObject() as RenderBox?;
  if (renderBox == null) return;
  final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);

  final tokenActionWidget = TokenActionWidget(
    isCollected: isCollected,
    onTransfer: onTransfer != null
        ? () {
            Navigator.of(itemContext).pop();
            onTransfer.call();
          }
        : null,
    onCollect: onCollect != null
        ? () {
            Navigator.of(itemContext).pop();
            onCollect.call();
          }
        : null,
  );

  final route = TokenActionRoute(
    itemRect: offset & renderBox.paintBounds.size,
    child: tokenActionWidget,
  );

  await Navigator.of(itemContext).push(route);
}
