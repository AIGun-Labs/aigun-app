import 'package:flutter/material.dart';

import '../widget/installer_diglog.dart';

Future<void> showInstallerDiglog(BuildContext context,
    {VoidCallback? onCancel, required VoidCallback onSetting}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        InstallerDiglog(onCancel: onCancel, onSetting: onSetting),
  );
}
