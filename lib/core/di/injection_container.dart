import 'package:get_it/get_it.dart';

import 'modules/ai_agent_module.dart';
import 'modules/update_module.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await UpdateModule(getIt).init();

  await AiAgentModule(getIt).init();
}

Future reset() async {
  await getIt.reset();
}
