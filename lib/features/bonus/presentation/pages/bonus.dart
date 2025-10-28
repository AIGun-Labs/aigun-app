import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bind_invite_card.dart';
import '../widgets/bouns_details.dart';
import '../widgets/get_funds_card.dart';
import '../widgets/get_gold_card.dart';
import '../widgets/invite_card.dart';
import '../widgets/invite_header.dart';
import '../widgets/invitee_card.dart';
import '../widgets/invitee_trade_card.dart';
import '../widgets/my_bonus_card.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: SafeArea(
          child: Column(
            children: [
              const InviteHeader(),
              30.verticalSpace,
              const InviteCard(),
              14.verticalSpace,
              const BindInviteCard(),
              14.verticalSpace,
              const MyBonusCard(),
              12.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 80.h, child: const GetGoldCard())),
                      10.horizontalSpace,
                      Expanded(
                          child: SizedBox(
                              height: 80.h, child: const GetFundsCard()))
                    ],
                  ),
                  14.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 80.h, child: const InviteeCard())),
                      10.horizontalSpace,
                      Expanded(
                          child: SizedBox(
                              height: 80.h, child: const InviteeTradeCard()))
                    ],
                  )
                ],
              ),
              35.verticalSpace,
              const BounsDetails()
            ],
          ),
        ),
      ),
    );
  }
}
