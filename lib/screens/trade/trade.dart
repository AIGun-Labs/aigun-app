import 'package:flutter/material.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trade/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Trade'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBalanceRow(context),
            const SizedBox(height: 4),
            _buildTradeSwap(context),
            const SizedBox(height: 24),
            _buildTradeButton(context),
            const SizedBox(height: 16),
            _buildTradeDefailsRow(context),
            const SizedBox(height: 16),
            // _buildTradeTypeSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.wallet_rounded,
          color: AppColors.textSecondary(context),
          size: 20.w,
        ),
        SizedBox(
          width: 4.w,
        ),
        Text("2.88 SQL",
            style: TextStyle(
                fontSize: 16.sp, color: AppColors.textSecondary(context))),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle,
              color: AppColors.textSecondary(context),
              size: 20.w,
            )),
        Spacer(),
        IconButton(
            onPressed: () {
              context.push(Routes.tradeSetting);
            },
            icon: const Icon(Icons.settings))
      ],
    );
  }

  Widget _buildTradeSwap(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TokenSwapCard(),
            SizedBox(height: 10), // 为中间图标留出空间
            TokenSwapCard(),
          ],
        ),
        // 垂直居中的交换图标
        Positioned(
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card(context),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                // icon: Icon(
                //   // Icons.swap_vert,
                //   color: AppColors.textPrimary(context),
                //   size: 24,
                // ),
                icon: SvgPicture.asset(
                  'assets/images/icons/swap.svg',
                  height: 16.w,
                  width: 16.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTradeButton(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showSimpleToast(
            "The function has not been developed yet. Please stay tuned");
      },
      width: double.infinity,
      backgroundColor: AppColors.buttonPrimary(context),
      textColor: AppColors.backgroundWhite,
      fontSize: 16.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/icons/aim-outline.svg'),
          SizedBox(width: 4),
          Text(
            'Swap',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeDefailsRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          width: 16.w,
          height: 16.w,
          colorFilter: ColorFilter.mode(
              AppColors.textSecondary(context), BlendMode.srcIn),
          "assets/images/icons/lightning-outline.svg",
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "Lightning",
          style: TextStyle(
              fontSize: 14.sp, color: AppColors.textSecondary(context)),
        ),
        Icon(
          Icons.keyboard_arrow_right,
          size: 16.w,
          color: AppColors.textSecondary(context),
        ),
        Spacer(),
        Row(
          children: [
            Text("5%",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context))),
          ],
        ),
        SizedBox(width: 10),
        Row(
          children: [
            Text("\$0.0007",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context))),
          ],
        ),
        SizedBox(width: 10),
        Row(
          children: [
            Text("Open",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context))),
          ],
        )
      ],
    );
  }

  Widget _buildTradeTypeSelector() {
    return Container(
      child: Text('TradeTypeSelector'),
    );
  }
}
