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
    this.uniquePrefix = 'intelligence_',
  });

  final IntelligenceEntity item;
  final int index;
  final String uniquePrefix;

  @override
  Widget build(BuildContext context) {
    // Convert entity to legacy model for rendering
    final intel = item.toLegacyModel();

    switch (item.type.value) {
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
