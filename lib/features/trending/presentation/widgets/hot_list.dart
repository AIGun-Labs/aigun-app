import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../../themes/colors.dart';
import 'hot_token_card.dart';

class LoadMoreListSource extends LoadingMoreBase<int> {
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < 10; i++) {
        add(0);
      }

      return true;
    });
  }
}

class HotList extends StatefulWidget {
  const HotList({super.key, required this.uniqueKey});
  final Key uniqueKey;

  @override
  State<HotList> createState() => _HotListState();
}

class _HotListState extends State<HotList> with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource _source = LoadMoreListSource();
  String _selectedNetwork = 'all';

  final List<Map<String, String>> _networks = [
    {'key': 'all', 'label': '全网'},
    {'key': 'solana', 'label': 'Solana'},
    {'key': 'bsc', 'label': 'BSC'},
    {'key': 'eth', 'label': 'ETH'},
    {'key': 'base', 'label': 'BASE'},
    {'key': 'spark', 'label': 'Spark'},
    {'key': 'rgb', 'label': 'RGB'},
  ];

  // Mock data for demonstration
  final List<Map<String, dynamic>> _mockTokens = [
    {
      'name': 'WIG',
      'image': 'assets/images/tokens/wig.png',
      'marketCap': '\$20K',
      'color': Colors.green,
    },
    {
      'name': '功夫熊猫',
      'image': 'assets/images/tokens/panda.png',
      'marketCap': '\$20K',
      'color': Colors.white,
    },
    {
      'name': 'AI16z',
      'image': 'assets/images/tokens/ai16z.png',
      'marketCap': '\$20M',
      'color': Colors.orange,
    },
    {
      'name': 'XZLL',
      'image': 'assets/images/tokens/xzll.png',
      'marketCap': '\$20M',
      'color': Colors.blue,
    },
    {
      'name': 'ROCK',
      'image': 'assets/images/tokens/rock.png',
      'marketCap': '\$20M',
      'color': Colors.red,
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedVisibilityDetector(
      uniqueKey: widget.uniqueKey,
      child: Column(
        children: [
          _FilterHeader(
            selectedNetwork: _selectedNetwork,
            networks: _networks,
            onNetworkSelected: (network) {
              setState(() {
                _selectedNetwork = network;
              });
            },
          ),
          Expanded(
              child: LoadingMoreList(ListConfig<int>(
            autoLoadMore: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.63,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 13.h,
            ),
            sourceList: _source,
            itemBuilder: (context, item, index) {
              final token = _mockTokens[index % _mockTokens.length];
              return HotTokenCard(token: token);
            },
          )))
        ],
      ),
    );
  }
}

// Custom delegate for sticky filter chips header
class _FilterHeader extends StatelessWidget {
  final String selectedNetwork;
  final List<Map<String, String>> networks;
  final ValueChanged<String> onNetworkSelected;

  const _FilterHeader({
    super.key,
    required this.selectedNetwork,
    required this.networks,
    required this.onNetworkSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background(context),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 8.h,
        children: networks.map((network) {
          final isSelected = selectedNetwork == network['key'];
          return SizedBox(
              height: 28.h,
              child: TextButton(
                onPressed: () => onNetworkSelected(network['key']!),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    isSelected
                        ? AppColors.foreground(context)
                        : AppColors.quinary,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    isSelected
                        ? AppColors.background(context)
                        : AppColors.foreground(context),
                  ),
                  textStyle: WidgetStateProperty.all(
                      TextStyle(fontSize: 14.sp, height: 1.h)),
                ),
                child: Text(
                  network['label']!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected
                        ? AppColors.background(context)
                        : AppColors.foreground(context),
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
