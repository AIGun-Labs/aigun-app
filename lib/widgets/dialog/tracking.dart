import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class TrackingDialog {
  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const TrackingDialogContent();
      },
    );
  }
}

class TrackingDialogContent extends StatelessWidget {
  const TrackingDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoAlertDialog(
        title: const Text("Thinks Your Support"),
        content: const Text(
          "This allows us to measure the effectiveness of our ads and understand how you found us, helping us improve your experience.",
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Don't Allow",
              style: TextStyle(color: AppColors.textPrimary(context)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              "Allow",
              style: TextStyle(color: AppColors.textPrimary(context)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text("Thinks Your Support"),
        content: const Text(
          "This allows us to measure the effectiveness of our ads and understand how you found us, helping us improve your experience.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Don't Allow"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Allow"),
          ),
        ],
      );
    }
  }
}
