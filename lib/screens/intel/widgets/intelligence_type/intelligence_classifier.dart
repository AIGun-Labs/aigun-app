import 'package:flutter/material.dart';

import '../../../../data/models/intel/intel.dart';
import 'new.dart';
import 'signal.dart';
import 'twitter.dart';

class IntelligenceClassifier extends StatelessWidget {
  const IntelligenceClassifier({
    super.key,
    required this.intel,
    this.index = 0,
    this.uniquePrefix = 'intelligence_',
  });

  final Intel intel;
  final int index;
  final String uniquePrefix;
  @override
  Widget build(BuildContext context) {
    switch (intel.type) {
      case 'twitter':
        return IntelligenceTwitter(
          intel: intel,
          index: index,
          uniquePrefix: uniquePrefix,
        );
      case 'radar_signal':
        return IntelligenceSignal(
          intel: intel,
          index: index,
          uniquePrefix: uniquePrefix,
        );
      default:
        return IntelligenceNew(
          intel: intel,
          index: index,
          uniquePrefix: uniquePrefix,
        );
    }
  }
}
