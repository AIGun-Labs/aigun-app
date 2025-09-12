import 'package:flutter/material.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/add_token/add_token.dart';
import 'package:flutter_aigun/screens/add_x_monitor/add_x_monitor.dart';
import 'package:flutter_aigun/screens/auth/auth.dart';
import 'package:flutter_aigun/screens/chat/index.dart';
import 'package:flutter_aigun/screens/check_your_email/check_your_email.dart';
import 'package:flutter_aigun/screens/forgot_password/forget_password.dart';
import 'package:flutter_aigun/screens/switch_lanuguage/switch_lanuguage.dart';
import 'package:flutter_aigun/screens/tabbar/tabbar.dart';
import 'package:flutter_aigun/screens/intel_ai_agents/intel_ai_agents.dart';
import 'package:flutter_aigun/screens/intel_x/intel_x.dart';
import 'package:flutter_aigun/screens/intel_x_group/intel_x_group.dart';
import 'package:flutter_aigun/screens/management_wallet/management_wallet.dart';
import 'package:flutter_aigun/screens/receive_address/receive_address.dart';
import 'package:flutter_aigun/screens/select_network/select_network.dart';
import 'package:flutter_aigun/screens/send_confirm_again/send_confirm_again.dart';
import 'package:flutter_aigun/screens/send_select_token/send_select_token.dart';
import 'package:flutter_aigun/screens/send_token_detail/send_token_detail.dart';
import 'package:flutter_aigun/screens/send_token_state/send_token_state.dart';
import 'package:flutter_aigun/screens/sign_in/widgets/create_new_account.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trade_confirm/trade_confirm.dart';
import 'package:flutter_aigun/screens/trade_setting/trade_setting.dart';
import 'package:flutter_aigun/screens/update_your_password/update_your_password.dart';
import 'package:flutter_aigun/screens/user/index.dart';
import 'package:flutter_aigun/widgets/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum TransitionType {
  rightToLeft,
  bottomToTop,
  fade,
}

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: _buildRoutes(),
  );

  static List<GoRoute> _buildRoutes() {
    return [
      _buildRoute(Routes.splash, const SplashScreen(),
          transitionType: TransitionType.fade),
      _buildRoute(Routes.home, const TabbarScreen(),
          transitionType: TransitionType.fade),
      // _buildRoute(Routes.login, SignInScreen()),
      _buildRoute(Routes.forgetPassword, const ForgetPasswordScreen()),
      // _buildRoute(Routes.login, SignUpScreen(), subRoutes: [
      //   _buildRoute(Routes.profile, const UploadPictureScreen())
      // ]),
      _buildRoute(Routes.checkYourEmail, const CheckYourEmailScreen()),
      _buildRoute(Routes.updateYourPassword, const UpdateYourPasswordScreen()),
      _buildRoute(Routes.createNewAccount, const CreateNewAccount()),
      _buildRoute(Routes.selectNetwork, const SelectNetworkScreen()),
      _buildRoute(Routes.receiveAddress, const ReceiveAddressScreen()),
      _buildRoute(Routes.sendSelectToken, const SendSelectTokenScreen()),
      _buildRoute(Routes.sendTokenDetail, const SendTokenDetailScreen()),
      _buildRoute(Routes.sendConfirmAgain, const SendConfirmAgainScreen()),
      _buildRoute(Routes.sendToken, const SendTokenStateScreen()),
      _buildRoute(Routes.addToken, const AddTokenScreen()),
      _buildRoute(Routes.intelAIAgents, const IntelAIAgentsScreen()),
      _buildRoute(Routes.intelXGroup, const IntelXGroupScreen()),
      _buildRoute(Routes.intelX, const IntelXScreen()),
      _buildRoute(Routes.addXMonitor, const AddXMonitorScreen()),
      _buildRoute(Routes.managementWallet, const ManagementWalletScreen()),
      _buildRoute(Routes.chat, const ChatScreen()),
      _buildRoute(Routes.user, const UserScreen()),
      _buildRoute(Routes.login, const LoginScreen()),
      _buildRoute(Routes.tradeConfirm, const TradeConfirmScreen()),
      _buildRoute(Routes.trade, const TradeScreen()),
      _buildRoute(Routes.tradeSetting, const TradeSettingScreen()),
      _buildRoute(Routes.switchLanguage, const SwitchLanguageScreen()),
    ];
  }

  static GoRoute _buildRoute(String path, Widget screen,
      {List<GoRoute>? subRoutes,
      TransitionType transitionType = TransitionType.rightToLeft}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.rightToLeft:
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.bottomToTop:
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
      },
      routes: subRoutes ?? [],
    );
  }
}
