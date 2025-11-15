import 'package:flutter/material.dart';

import '../../../../data/models/intel/intel.dart';
import 'new.dart';
import 'signal.dart';
import 'twitter.dart';

class IntelligenceClassifier extends StatelessWidget {
  const IntelligenceClassifier(
      {super.key, required this.intel, this.index = 0});

  final Intel intel;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (intel.type) {
      case 'twitter':
        return IntellgenceTwitter(intel: intel, index: index);
      case 'radar_signal':
        return IntellgenceSignal(intel: intel, index: index);
      default:
        return IntellgenceNew(intel: intel, index: index);
    }
  }
}
