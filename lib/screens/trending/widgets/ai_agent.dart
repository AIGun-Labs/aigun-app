import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/card/agent_desc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiAgentPage extends StatefulWidget {
  final Function(double)? onScrollUpdate;

  const AiAgentPage({super.key, this.onScrollUpdate});

  @override
  State<AiAgentPage> createState() => _AiAgentPageState();
}

class _AiAgentPageState extends State<AiAgentPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  double _lastShrinkRatio = -1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted || widget.onScrollUpdate == null) return;

    final shrinkRatio = (_scrollController.offset / 100).clamp(0.0, 1.0);

    if ((shrinkRatio - _lastShrinkRatio).abs() > 0.02) {
      _lastShrinkRatio = shrinkRatio;
      widget.onScrollUpdate!(shrinkRatio);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // 模拟AI特工数据
  final List<Map<String, dynamic>> aiAgents = [
    {
      'name': 'Solana侦查官',
      'avatar': 'assets/images/solana_agent.png',
      'description': '叫我大表哥，我为你追踪BSC最新投资机会',
      'isFollowed': false,
    },
    {
      'name': 'BSC侦查官',
      'avatar': 'assets/images/bsc_agent.png',
      'description': '叫我大表哥，我为你追踪BSC最新投资机会',
      'isFollowed': true,
    },
    {
      'name': 'X Layer侦查官',
      'avatar': 'assets/images/xlayer_agent.png',
      'description': '叫我大表哥，我为你追踪BSC最新投资机会',
      'isFollowed': false,
    },
    {
      'name': 'Ethereum侦查官',
      'avatar': 'assets/images/chain/ethereum.png',
      'description': '为你追踪Solana上最快、最新的投资机会',
      'isFollowed': false,
    },
    {
      'name': 'Polygon侦查官',
      'avatar': 'assets/images/chain/polygon.png',
      'description': '为你追踪全网事件机遇，包括了X、Telegram、新闻、公告等，不关注我你会拍...',
      'isFollowed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 15.h),
        itemCount: aiAgents.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 13.w,
          crossAxisSpacing: 13.w,
        ),
        itemBuilder: (context, index) {
          final agent = aiAgents[index];
          return CardAgentDesc(
            name: agent['name'],
            avatarPath: agent['avatar'],
            isFollowed: agent['isFollowed'],
            desc: agent['description'],
            onFollowTap: () {
              setState(() {
                aiAgents[index]['isFollowed'] = !aiAgents[index]['isFollowed'];
              });
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
