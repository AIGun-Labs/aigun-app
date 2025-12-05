import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';
import '../../utils/logger.dart';

class MediaToken extends StatefulWidget {
  const MediaToken({
    super.key,
    required this.tokenName,
    required this.tokenSymbol,
    this.tokenLogo,
    this.chainLogo,
    this.onTap,
    this.showChain = true,
    this.onSegmentChanged,
    this.initialSegment = 0,
  });

  final String tokenName;
  final String tokenSymbol;
  final String? tokenLogo;
  final String? chainLogo;
  final VoidCallback? onTap;
  final bool showChain;
  final Function(int)? onSegmentChanged;
  final int initialSegment;

  @override
  State<MediaToken> createState() => _MediaTokenState();
}

class _MediaTokenState extends State<MediaToken> {
  late int selectedSegment;
  @override
  void initState() {
    super.initState();
    selectedSegment = widget.initialSegment;
  }

  _onTap() {
    Logger.info(widget.tokenName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 8.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 28.w,
                foregroundImage:
                    widget.tokenLogo != null && widget.tokenLogo!.isNotEmpty
                    ? NetworkImage(widget.tokenLogo!)
                    : null,
                backgroundImage: const AssetImage(
                  "assets/images/icons/ai-agent.png",
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: CircleAvatar(
                  radius: 12.w,
                  foregroundImage:
                      widget.chainLogo != null && widget.chainLogo!.isNotEmpty
                      ? NetworkImage(widget.chainLogo!)
                      : null,
                  backgroundImage: const AssetImage(
                    "assets/images/icons/ai-agent.png",
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.tokenName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  widget.tokenSymbol,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textTertiary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
