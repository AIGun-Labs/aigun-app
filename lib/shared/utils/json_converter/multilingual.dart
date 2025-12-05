import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/language/language.dart';

class MultilingualListConverter
    implements JsonConverter<List<Multilingual>?, dynamic> {
  const MultilingualListConverter();

  @override
  List<Multilingual>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is! List) return null;

    return json.map((item) {
      if (item is Map<String, dynamic>) {
        return Multilingual.fromJson(item);
      }
      if (item is String) {
        return Multilingual(zh: item, en: item);
      }
      return const Multilingual(zh: '', en: '');
    }).toList();
  }

  @override
  dynamic toJson(List<Multilingual>? object) {
    return object?.map((e) => e.toJson()).toList();
  }
}

// Helper function to convert signal_tags using MultilingualListConverter
List<Multilingual>? multilingualListFromJson(dynamic json) {
  return const MultilingualListConverter().fromJson(json);
}

// Helper function for toJson
dynamic multilingualListToJson(List<Multilingual>? object) {
  return const MultilingualListConverter().toJson(object);
}

class MultilingualStringConverter
    implements JsonConverter<Multilingual?, dynamic> {
  const MultilingualStringConverter();

  @override
  Multilingual? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Map<String, dynamic>) {
      return Multilingual.fromJson(json);
    }
    if (json is String) {
      return Multilingual(zh: json, en: json);
    }
    return null;
  }

  @override
  dynamic toJson(Multilingual? object) {
    return object;
  }
}

// Helper function to convert signal_tags using MultilingualListConverter
Multilingual? multilingualStringFromJson(dynamic json) {
  return const MultilingualStringConverter().fromJson(json);
}

// Helper function for toJson
dynamic multilingualStringToJson(Multilingual? object) {
  return const MultilingualStringConverter().toJson(object);
}
