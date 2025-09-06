import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/screens/trade/widgets/swap.dart';
import 'package:flutter_aigun/screens/trade/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        context.select((UserCubit cubit) => cubit.state.isLoggedIn);

    if (!isLoggedIn) {
      return const Center(child: Text("Please login first"));
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Trade'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: TradeSwap(),
      ),
    );
  }
}
