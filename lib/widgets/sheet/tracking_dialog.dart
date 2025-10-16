import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';

class TrackingDialog {
  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          // if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Text("Thinks Your Support"),
            content: const Text(
                "This allows us to measure the effectiveness of our ads and understand how you found us, helping us improve your experience."),
            actions: [
              CupertinoDialogAction(
                  child: Text(
                    "Don't Allow",
                    style: TextStyle(color: AppColors.textPrimary(context)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CupertinoDialogAction(
                  child: Text(
                    "Allow",
                    style: TextStyle(color: AppColors.textPrimary(context)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
          // } else {
          //   return AlertDialog(
          //     title: const Text("Thinks Your Support"),
          //     content: const Text(
          //         "This allows us to measure the effectiveness of our ads and understand how you found us, helping us improve your experience."),
          //     actions: [
          //       TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: const Text("Don't Allow")),
          //       TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: const Text("Allow")),
          //     ],
          //   );
          // }
        });
  }
}
