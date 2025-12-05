import 'package:flutter/material.dart';

import 'toast.dart';

void showFeatureDisabledToast(BuildContext context, {String? featureName}) {
  final message = featureName != null ? '$featureName ' : '';
  ToastUtils.showCenterToast(context, message);
}
