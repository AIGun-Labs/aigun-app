import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/widgets/user/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/token/token_item.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'widgets/trending_tab_bar.dart';
import 'widgets/ai_agent_card.dart';
import 'widgets/trending_section_header.dart';
import 'widgets/token_list_tabs.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int selectedTabIndex = 0; // AI特工标签选中
  int selectedTokenTabIndex = 0; // 收藏标签选中

  // 模拟AI特工数据
  final List<Map<String, dynamic>> aiAgents = [
    {
      'name': 'Solana侦查官',
      'avatar': 'assets/images/trending/solana_agent_avatar.png',
      'isFollowed': false,
    },
    {
      'name': 'BSC侦查官',
      'avatar': 'assets/images/trending/bsc_agent_avatar.png',
      'isFollowed': true,
    },
    {
      'name': 'X Layer侦查官',
      'avatar': 'assets/images/trending/xlayer_agent_avatar.png',
      'isFollowed': false,
    },
  ];

  // 模拟代币数据
  final List<Token> mockTokens = [
    const Token(
      chainId: 1,
      tokenName: 'Bitcoin',
      symbol: 'BTC',
      tokenAvatar: 'assets/images/chain/bitcoin.png',
      chainLogo: 'assets/images/chain/ethereum.png',
      chainName: 'Ethereum',
      address: '0x123...',
      rawBalance: '1.2345',
      tokenPrice: '45000.00',
      balance: '1.2345',
      decimals: 18,
    ),
    const Token(
      chainId: 1,
      tokenName: 'Ethereum',
      symbol: 'ETH',
      tokenAvatar: 'assets/images/chain/ethereum.png',
      chainLogo: 'assets/images/chain/ethereum.png',
      chainName: 'Ethereum',
      address: '0x456...',
      rawBalance: '5.6789',
      tokenPrice: '3200.00',
      balance: '5.6789',
      decimals: 18,
    ),
  ];

  Widget _buildContent() {
    switch (selectedTabIndex) {
      case 0: // 热门
        return _buildHotContent();
      case 1: // AI特工
        return _buildAIAgentContent();
      case 2: // 趋势
        return _buildTrendContent();
      default:
        return _buildAIAgentContent();
    }
  }

  Widget _buildHotContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                Text(
                  'AI 特工',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 4.w),
                // const Text('热门'),
                Icon(Icons.arrow_forward_ios,
                    fontWeight: FontWeight.w700,
                    size: 16.w,
                    color: AppColors.textTertiary(context)),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: aiAgents.length,
              itemBuilder: (context, index) {
                final agent = aiAgents[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < aiAgents.length - 1 ? 14.w : 0,
                  ),
                  child: AIAgentCard(
                    name: agent['name'],
                    avatarPath: agent['avatar'],
                    isFollowed: agent['isFollowed'],
                    onFollowTap: () {
                      // setState(() {
                      //   aiAgents[index]['isFollowed'] =
                      //       !aiAgents[index]['isFollowed'];
                      // });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),

          // 代币列表标签
          TokenListTabs(
            selectedTabIndex: selectedTokenTabIndex,
            onTabSelected: (index) {
              // setState(() {
              //   selectedTokenTabIndex = index;
              // });
            },
          ),
          SizedBox(height: 10.h),
          // 代币列表
          const WalletList(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildAIAgentContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),
          // AI特工标题
          TrendingSectionHeader(
            title: 'AI特工',
            onTap: () {
              // 处理查看更多
            },
          ),
          // AI特工卡片列表
          SizedBox(height: 8.h),
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: aiAgents.length,
              itemBuilder: (context, index) {
                final agent = aiAgents[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < aiAgents.length - 1 ? 14.w : 0,
                  ),
                  child: AIAgentCard(
                    name: agent['name'],
                    avatarPath: agent['avatar'],
                    isFollowed: agent['isFollowed'],
                    onFollowTap: () {
                      // setState(() {
                      //   aiAgents[index]['isFollowed'] =
                      //       !aiAgents[index]['isFollowed'];
                      // });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          // 代币列表标签
          TokenListTabs(
            selectedTabIndex: selectedTokenTabIndex,
            onTabSelected: (index) {
              // setState(() {
              //   selectedTokenTabIndex = index;
              // });
            },
          ),
          SizedBox(height: 5.h),
          // 代币列表
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockTokens.length,
            itemBuilder: (context, index) {
              return TokenItem(
                token: mockTokens[index],
                onTap: (token) {
                  // 处理代币点击
                },
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildTrendContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          // 趋势内容
          Center(
            child: Image.asset(
              'assets/images/trending/trending_token_list.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // 头部
              UserProfileWithSearchBar(openDrawer: () => {}),

              // 标签导航
              TrendingTabBar(
                selectedIndex: selectedTabIndex,
                onTabSelected: (index) {
                  // setState(() {
                  //   selectedTabIndex = index;
                  // });
                },
              ),

              // 内容区域
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ));
  }
}
