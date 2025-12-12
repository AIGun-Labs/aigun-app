import '../../../../core/types/result.dart';
import '../entities/option_tab_entity.dart';

abstract interface class OptionTabRepo {
  Future<Result<OptionTabEntity>> fetchOptionTab();
}
