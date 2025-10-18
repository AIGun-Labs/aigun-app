import 'package:get_it/get_it.dart';

import '../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../module_repo.dart';

class AiAgentModule implements InjectionModule {
  final GetIt _sl;

  AiAgentModule(this._sl);

  @override
  Future<void> init() async {
    _sl.registerLazySingleton(() => AiAgentCubit());
  }
}
