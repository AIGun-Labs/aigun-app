import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/widgets/sheet/tracking_dialog.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return Center(
      child: ElevatedButton(
          onPressed: () {
            TrackingDialog().show(context);
          },
          child: const Text("正在开发中...")),
    );
  }
}
