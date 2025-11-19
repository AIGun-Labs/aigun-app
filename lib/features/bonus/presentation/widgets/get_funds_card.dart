import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/logger.dart';
import 'card_widget.dart';

class GetFundsCard extends StatefulWidget {
  final double unclaimedDollarValue;
  final Future<double> Function() realtimeFundsUpdate;
  const GetFundsCard(
      {super.key,
      required this.unclaimedDollarValue,
      required this.realtimeFundsUpdate});

  @override
  State<GetFundsCard> createState() => _GetFundsCardState();
}

class _GetFundsCardState extends State<GetFundsCard> {
  late double _currentValue;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.unclaimedDollarValue;
    _startPolling();
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }

  void _startPolling() {
    if (_timer?.isActive ?? false) return;
    Logger.info('start polling');
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (!mounted) return;
      final newValue = await widget.realtimeFundsUpdate();
      setState(() {
        _currentValue = newValue;
      });
    });
  }

  void _stopPolling() {
    Logger.info('stop polling');
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('get_funds_card'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0) {
          _startPolling();
        } else {
          _stopPolling();
        }
      },
      child: InkWell(
        onTap: () {
          context.pushNamed(RouteNames.claimFunds);
        },
        child: CardWidget(
            paddingValue: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).unclaimedFunds,
                  style: TextStyle(
                      fontSize: 12.sp, color: AppColors.textSecondary(context)),
                ),
                Row(
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                        child: Text(
                      _currentValue.comma(context, fractionDigits: 1),
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    )),
                    Icon(Icons.arrow_forward,
                        size: 24.w, color: AppColors.quaternary)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
