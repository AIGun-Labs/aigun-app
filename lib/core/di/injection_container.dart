import 'package:flutter_aigun/core/di/modules/network_module.dart';

import '../service_locator.dart';
import 'modules/ai_agent_module.dart';
import 'modules/invite_module.dart';
import 'modules/trending_module.dart';
import 'modules/update_module.dart';

/// TODO: 待重构，先使用 service_locator.dart 中的 getIt
// final getIt = GetIt.instance;

Future<void> init() async {
  UpdateModule(getIt).init();
  AiAgentModule(getIt).init();
  TrendingModule(getIt).init();
  NetworkModule(getIt).init();
  InviteModule(getIt).init();
}

Future reset() async {
  getIt.reset();
}
