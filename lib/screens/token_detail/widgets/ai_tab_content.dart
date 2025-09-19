import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AITabContent extends StatelessWidget {
  const AITabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAIFeedCard(context),
        ],
      ),
    );
  }

  Widget _buildAIFeedCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeedHeader(context),
          _buildFeedContent(context),
          _buildTokenCards(context),
          _buildFeedImage(context),
          _buildTimeInfo(context),
          _buildSourceInfo(context),
        ],
      ),
    );
  }

  Widget _buildFeedHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/images/ai-avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '事件猎人',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                '21:02 8-14',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF565656),
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.more_horiz,
            size: 24.w,
            color: const Color(0xFF909090),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Text(
        '马斯克刚修改了头像，同时修改了名字为Kekius Maximus，为您发现到投资机会，可买入对应的meme币',
        style: TextStyle(
          fontSize: 16.sp,
          height: 1.5,
          color: AppColors.textPrimary(context),
        ),
      ),
    );
  }

  Widget _buildTokenCards(BuildContext context) {
    return Column(
      children: [
        _buildSingleTokenCard(context, 'KEKIUS', 'FThr...cs42', hasProfit: true),
        SizedBox(height: 12.h),
        _buildSingleTokenCard(context, 'KEKIUS', 'FThr...cs42', hasProfit: false),
      ],
    );
  }

  Widget _buildSingleTokenCard(
    BuildContext context,
    String tokenName,
    String tokenAddress,
    {bool hasProfit = false}
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13.w),
      height: hasProfit ? 145.h : 113.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0077FF), Color(0xFF6EB8FE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16.w,
            top: 15.h,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/token-placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/solana-logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tokenName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      tokenAddress,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.w,
            top: 13.h,
            child: Container(
              width: 95.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF000),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/lightning.svg',
                    width: 17.w,
                    height: 19.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '买入',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 134.w,
            top: 19.h,
            child: Image.asset(
              'assets/images/pumpfun-logo.png',
              width: 12.w,
              height: 10.h,
            ),
          ),
          if (hasProfit)
            Positioned(
              left: 17.w,
              bottom: 8.h,
              child: Text(
                '恭喜你盈利 \$3000.12',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFFFF000),
                ),
              ),
            ),
          Positioned(
            bottom: hasProfit ? 48.h : 45.h,
            left: 152.w,
            child: Column(
              children: [
                Text(
                  'MC at Alert',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '\$223.2K',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: hasProfit ? 49.h : 46.h,
            right: 15.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '当前市值',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '\$212.3K',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: hasProfit ? 46.h : 46.h,
            left: 14.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '预警后最高涨幅',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  '123x',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFF000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      height: 137.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        image: const DecorationImage(
          image: AssetImage('assets/images/feed-image-placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTimeInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/icons/clock.svg',
            width: 16.w,
            height: 16.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFF909090),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            'Event monitor : 3s',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF909090),
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            'AI analysis: 3.5s',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF909090),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13.w),
      padding: EdgeInsets.all(9.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE2FDFE),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/images/elon-avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Elon Musk',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(
                      'assets/images/icons/x-logo.svg',
                      width: 14.w,
                      height: 14.h,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF565656),
                        BlendMode.srcIn,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '21:02',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  'posted a status on X, triggering investment opportunities.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF565656),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 24.w,
            color: const Color(0xFF565656),
          ),
        ],
      ),
    );
  }
}