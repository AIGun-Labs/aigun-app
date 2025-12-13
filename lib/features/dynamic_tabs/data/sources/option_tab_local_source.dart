import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constant/storage_keys.dart';
import '../models/option_tab_model.dart';

class OptionTabLocalSource {
  final FlutterSecureStorage _storage;

  OptionTabLocalSource(this._storage);

  final String _optionTabKey = StorageKeys.optionTab;

  final String _optionTabTimestampKey = '${StorageKeys.optionTab}_timestamp';

  static const Duration _expirationDuration = Duration(hours: 12);

  OptionTabModel? _optionTab;
  DateTime? _optionTabSavedAt;

  Future<void> saveOptionTab(OptionTabModel optionTab) async {
    _optionTab = optionTab;
    final now = DateTime.now();
    _optionTabSavedAt = now;

    await Future.wait([
      _storage.write(key: _optionTabKey, value: jsonEncode(optionTab.toJson())),
      _storage.write(
        key: _optionTabTimestampKey,
        value: now.millisecondsSinceEpoch.toString(),
      ),
    ]);
  }

  Future<OptionTabModel?> getOptionTab() async {
    if (_optionTab != null && _optionTabSavedAt != null) {
      if (_isExpired(_optionTabSavedAt!)) {
        await deleteOptionTab();
        return null;
      }
      return _optionTab;
    }

    final timestampStr = await _storage.read(key: _optionTabTimestampKey);

    if (timestampStr == null) {
      await deleteOptionTab();
      return null;
    }

    final savedAt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(timestampStr),
    );

    if (_isExpired(savedAt)) {
      await deleteOptionTab();
      return null;
    }

    final optionTabStr = await _storage.read(key: _optionTabKey);

    if (optionTabStr == null) return null;
    _optionTab = OptionTabModel.fromJson(jsonDecode(optionTabStr));
    _optionTabSavedAt = savedAt;
    return _optionTab;
  }

  Future<void> deleteOptionTab() async {
    _optionTab = null;
    _optionTabSavedAt = null;

    await Future.wait([
      _storage.delete(key: _optionTabKey),
      _storage.delete(key: _optionTabTimestampKey),
    ]);
  }

  bool _isExpired(DateTime savedAt) {
    final now = DateTime.now();
    return now.difference(savedAt) > _expirationDuration;
  }
}
