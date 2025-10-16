import 'package:flutter/material.dart';

import '../../domain/entities/update_info.dart';
import '../widget/update_sheet.dart';

Future<void> showUpdateSheet(
  BuildContext context, {
  required UpdateInfo info,
  required bool force,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: !force,
    enableDrag: !force,
    backgroundColor: Colors.transparent,
    constraints: const BoxConstraints(
      minWidth: double.infinity,
      maxWidth: double.infinity,
    ),
    builder: (context) => Update(info: info, force: force),
  );
}
