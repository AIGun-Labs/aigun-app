import '../../../../core/types/result.dart';
import '../../domain/entities/option_tab_entity.dart';
import '../../domain/repositories/option_tab_repo.dart';
import '../mappers/option_tab_mapper.dart';
import '../models/option_tab_model.dart';
import '../sources/option_tab_local_source.dart';
import '../sources/option_tab_remote_source.dart';

class OptionTabRepoImpl implements OptionTabRepo {
  final OptionTabRemoteSource _remoteSource;
  final OptionTabLocalSource _localSource;
  OptionTabRepoImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<OptionTabEntity>> fetchOptionTab() async {
    OptionTabModel? data;

    try {
      data = await _localSource.getOptionTab();
    } catch (e) {
      _localSource.deleteOptionTab();
      data = await _remoteSource.getOptionTab();
      _localSource.saveOptionTab(data);
    }

    try {
      if (data == null) {
        data = await _remoteSource.getOptionTab();
        _localSource.saveOptionTab(data);
      }
    } catch (e) {
      return Result.failure(e.toString());
    }

    return Result.success(data.toEntity());
  }
}
