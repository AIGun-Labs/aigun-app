import 'package:flutter/material.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../enums/intel_type.dart';
import 'intel_item_info.dart';
import 'intel_item_radar_signal.dart';

class IntelItem extends StatelessWidget {
  const IntelItem({super.key, required this.intel, required this.index});

  final Intel intel;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (intel.type == IntelType.radarSignal.type) {
      return IntelItemRadarSignal(intel: intel, index: index);
    }

    return IntelItemInfo(intel: intel, index: index);
  }
}
