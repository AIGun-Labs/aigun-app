import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/multilingual_model.dart';

class MultilingualListConverter
    implements JsonConverter<List<MultilingualModel>?, dynamic> {
  const MultilingualListConverter();

  @override
  List<MultilingualModel>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is! List) return null;

    return json.map((item) {
      if (item is Map<String, dynamic>) {
        return MultilingualModel.fromJson(item);
      }
      if (item is String) {
        return MultilingualModel(zh: item, en: item);
      }
      return const MultilingualModel(zh: '', en: '');
    }).toList();
  }

  @override
  dynamic toJson(List<MultilingualModel>? object) {
    return object?.map((e) => e.toJson()).toList();
  }
}

// Helper function to convert signal_tags using MultilingualListConverter
List<MultilingualModel>? multilingualListFromJson(dynamic json) {
  return const MultilingualListConverter().fromJson(json);
}

// Helper function for toJson
dynamic multilingualListToJson(List<MultilingualModel>? object) {
  return const MultilingualListConverter().toJson(object);
}

class MultilingualStringConverter
    implements JsonConverter<MultilingualModel?, dynamic> {
  const MultilingualStringConverter();

  @override
  MultilingualModel? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Map<String, dynamic>) {
      return MultilingualModel.fromJson(json);
    }
    if (json is String) {
      return MultilingualModel(zh: json, en: json);
    }
    return null;
  }

  @override
  dynamic toJson(MultilingualModel? object) {
    return object;
  }
}

// Helper function to convert signal_tags using MultilingualListConverter
MultilingualModel? multilingualStringFromJson(dynamic json) {
  return const MultilingualStringConverter().fromJson(json);
}

// Helper function for toJson
dynamic multilingualStringToJson(MultilingualModel? object) {
  return const MultilingualStringConverter().toJson(object);
}
