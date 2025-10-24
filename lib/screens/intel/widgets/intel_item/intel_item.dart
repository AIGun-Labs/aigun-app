import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/enums/intel_type.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_item_info.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_item_radar_signal.dart';

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
