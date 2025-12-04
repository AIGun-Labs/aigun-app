library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/bonus/domain/usecases/claim_token.dart';
import '../../../features/bonus/domain/usecases/unclaimed_tokens.dart';
import '../../../features/bonus/presentation/cubits/claim_token_cubit.dart';
import '../../../features/bonus/presentation/cubits/invite_cubit.dart';
import '../../../features/bonus/presentation/pages/bonus.dart';
import '../../../features/bonus/presentation/pages/claim_funds.dart';
import '../../../features/home/presentation/pages/home.dart';
import '../../../features/swap/presentation/pages/swap_page.dart';
import '../../../features/token_detail/presentation/pages/token_detail.dart';
import '../../../features/transfer/presentation/pages/send_confirm_again.dart';
import '../../../features/trending/presentation/pages/new_trending.dart';
import '../../../features/wallet/presentation/pages/wallet.dart';
import '../../../screens/add_token/add_token.dart';
import '../../../screens/auth/auth.dart';
import '../../../screens/intel/intel.dart';
import '../../../screens/query_token/query_token.dart';
import '../../../screens/receive_address/receive_address.dart';
import '../../../screens/select_network/select_network.dart';
import '../../../screens/send_select_token/send_select_token.dart';
import '../../../screens/send_token_detail/send_token_detail.dart';
import '../../../screens/send_token_state/send_token_state.dart';
import '../../../screens/switch_language/switch_language.dart';
import '../../../screens/trade_confirm/trade_confirm.dart';
import '../../../screens/trade_setting/trade_setting.dart';
import '../../../screens/webview/webview.dart';
import '../../../shared/domain/entities/token_entity.dart';
import '../../../themes/colors.dart';
import '../../../widgets/splash_screen.dart';
import '../../service_locator.dart';
import '../constants.dart';

part 'add_token_route.dart';
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
CustomTransitionPage<T> slideH<T>(
  Widget child, {
  required BuildContext context,
}) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) {
    final t = Tween(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));

    final bg = AppColors.background(c);

    return SlideTransition(
      position: a.drive(t),
      child: Container(color: bg, child: ch),
    );
  },
);

// 淡入淡出过渡(淡入淡出)
CustomTransitionPage<T> fade<T>(Widget child) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) => FadeTransition(opacity: a, child: ch),
);

// 垂直过渡(从上到下)
CustomTransitionPage<T> slideV<T>(Widget child) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) {
    final t = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));
    return SlideTransition(position: a.drive(t), child: ch);
  },
);

abstract class SlideHRouteData extends GoRouteData {
  const SlideHRouteData();

  Widget buildPageChild(BuildContext context, GoRouterState state);
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(buildPageChild(c, s), context: c);
}

// // 1. 直接跳转（替换当前页面栈）：
// const SendConfirmAgainRoute().go(context);

// // 2. 压栈（从当前页面 push 一个新页面，可以返回）：
// const SendConfirmAgainRoute().push(context);

// // 3. push 并拿返回值：
// final result = await const SendConfirmAgainRoute().push<bool>(context);
// // 根据 result 做处理...

// @TypedGoRoute<TokenDetailRoute>(
//   path: '/token/:id',
//   name: 'token-detail',
// )
// class TokenDetailRoute extends GoRouteData {
//   const TokenDetailRoute({required this.id});

//   final String id;

//   @override
//   Page<void> buildPage(BuildContext c, GoRouterState s) =>
//       slideH(TokenDetailScreen(id: id));
// }

// TokenDetailRoute(id: token.id).push(context);
