import 'package:flutter/material.dart';

import '../../../../screens/intel/widgets/intelligence_type/new.dart';
import '../../../../screens/intel/widgets/intelligence_type/signal.dart';
import '../../../../screens/intel/widgets/intelligence_type/twitter.dart';
import '../../domain/entities/intelligence_entity.dart';
import '../../infrastructure/mappers/intelligence_mapper.dart';

/// Intelligence Item Classifier Widget
///
/// Routes intelligence items to their appropriate display widgets
/// based on the item type.
///
/// Note: This is a bridge widget during migration that converts
/// domain entities to legacy models for rendering.
class IntelligenceItemClassifier extends StatelessWidget {
  const IntelligenceItemClassifier({
    super.key,
    required this.item,
    this.index = 0,
  });

  final IntelligenceEntity item;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Convert entity to legacy model for rendering
    // TODO: Migrate individual type widgets to use entities directly
    final intel = item.toLegacyModel();

    switch (item.type.value) {
      case 'twitter':
        return IntellgenceTwitter(intel: intel, index: index);
      case 'radar_signal':
        return IntellgenceSignal(intel: intel, index: index);
      default:
        return IntellgenceNew(intel: intel, index: index);
    }
  }
}
