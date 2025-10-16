import 'package:flutter/material.dart';

import '../widget/installer_dialog.dart';

Future<void> showInstallerDialog(BuildContext context,
    {VoidCallback? onCancel, required VoidCallback onSetting}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        InstallerDialog(onCancel: onCancel, onSetting: onSetting),
  );
}
