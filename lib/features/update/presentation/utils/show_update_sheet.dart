import 'package:flutter/material.dart';

import '../../domain/entities/config_entity.dart';
import '../widgets/update_sheet.dart';

Future<void> showUpdateSheet(
  BuildContext context, {
  required ConfigEntity info,
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
    builder: (context) => UpdateSheet(info: info, force: force),
  );
}
