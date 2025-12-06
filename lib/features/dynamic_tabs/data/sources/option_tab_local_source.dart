import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constant/storage_keys.dart';
import '../models/option_tab_model.dart';

class OptionTabLocalSource {
  final FlutterSecureStorage _storage;

  OptionTabLocalSource(this._storage);

  final String _optionTabKey = StorageKeys.optionTab;

  OptionTabModel? _optionTab;

  Future<void> saveOptionTab(OptionTabModel optionTab) async {
    _optionTab = optionTab;
    await _storage.write(
      key: _optionTabKey,
      value: jsonEncode(optionTab.toJson()),
    );
  }

  Future<OptionTabModel?> getOptionTab() async {
    if (_optionTab != null) {
      return _optionTab;
    }
    final optionTab = await _storage.read(key: _optionTabKey);
    if (optionTab != null) {
      _optionTab = OptionTabModel.fromJson(jsonDecode(optionTab));
    }
    return _optionTab;
  }

  Future<void> deleteOptionTab() async {
    _optionTab = null;
    await _storage.delete(key: _optionTabKey);
  }
}
