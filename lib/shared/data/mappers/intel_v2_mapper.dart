import '../../domain/entities/intel_v2_entity.dart';
import '../models/intel_v2_model.dart';

extension IntelV2Mapper on IntelV2Model {
  IntelV2Entity toEntity() {
    return IntelV2Entity(
      id: id,
      isValuable: isValuable,
      analyzedTime: analyzedTime,
      analyzed: analyzed,
      createdAt: createdAt,
      updatedAt: updatedAt,
      type: type,
      title: title,
      content: content,
      abstractText: abstractText,
      sourceUrl: sourceUrl,
      tags: tags,
      publishedAt: publishedAt,
    );
  }
}
