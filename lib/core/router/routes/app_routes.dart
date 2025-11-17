library app_routes;

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../features/ai_agent/presentation/pages/ai_agent.dart';
import '../../../features/bonus/domain/usecases/claim_token.dart';
import '../../../features/bonus/domain/usecases/fetch_active_code.dart';
import '../../../features/bonus/domain/usecases/fetch_claim_gold.dart';
import '../../../features/bonus/domain/usecases/fetch_invite_info.dart';
import '../../../features/bonus/domain/usecases/fetch_realtime_funds.dart';
import '../../../features/bonus/domain/usecases/unclaimed_tokens.dart';
import '../../../features/bonus/presentation/cubits/claim_token_cubit.dart';
import '../../../features/bonus/presentation/cubits/invite_cubit.dart';
import '../../../features/bonus/presentation/pages/bonus.dart';
import '../../../features/bonus/presentation/pages/claim_funds.dart';
import '../../../features/home/presentation/pages/home.dart';
import '../../../features/trending/presentation/pages/trending.dart';
import '../../../screens/add_token/add_token.dart';
import '../../../screens/auth/auth.dart';
import '../../../screens/intel/intel.dart';
import '../../../screens/query_token/query_token.dart';
import '../../../screens/receive_address/receive_address.dart';
import '../../../screens/select_network/select_network.dart';
import '../../../screens/send_confirm_again/send_confirm_again.dart';
import '../../../screens/send_select_token/send_select_token.dart';
import '../../../screens/send_token_detail/send_token_detail.dart';
import '../../../screens/send_token_state/send_token_state.dart';
import '../../../screens/switch_language/switch_language.dart';
import '../../../screens/token_detail/token_detail.dart';
import '../../../screens/trade/trade.dart';
import '../../../screens/trade_confirm/trade_confirm.dart';
import '../../../screens/trade_setting/trade_setting.dart';
import '../../../screens/wallet/wallet.dart';
import '../../../screens/webview/webview.dart';
import '../../../widgets/splash_screen.dart';
import '../../service_locator.dart';
import '../constants.dart';

part 'add_token_route.dart';
part 'ai_agent_route.dart';
part 'app_routes.g.dart';
part 'claim_funds_route.dart';
part 'home_route.dart';
part 'login_route.dart';
part 'query_token_route.dart';
part 'receive_address_route.dart';
part 'select_network_route.dart';
part 'send_confirm_again_route.dart';
part 'send_select_token_route.dart';
part 'send_token_detail_route.dart';
part 'send_token_route.dart';
part 'splash_route.dart';
part 'switch_language_route.dart';
part 'token_detail_route.dart';
part 'trade_confirm_route.dart';
part 'trade_setting_route.dart';
part 'webview_preview_route.dart';

// 水平过渡(从右到左)
CustomTransitionPage<T> slideH<T>(Widget child) => CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (c, a, _, ch) {
      final t = Tween(begin: const Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: a.drive(t), child: ch);
    });

// 淡入淡出过渡(淡入淡出)
CustomTransitionPage<T> fade<T>(Widget child) => CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (c, a, _, ch) => FadeTransition(opacity: a, child: ch));

// 垂直过渡(从上到下)
CustomTransitionPage<T> slideV<T>(Widget child) => CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (c, a, _, ch) {
      final t = Tween(begin: const Offset(0, 1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: a.drive(t), child: ch);
    });
