import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';

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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedVisibilityDetector(
      uniqueKey: widget.uniqueKey,
      child: LoadingMoreList(
        ListConfig(
          showGlowLeading: false,
          cacheExtent: 100,
          sourceList: _source,
          itemBuilder: (context, item, index) => _buildListItem(index),
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return RepaintBoundary(
      child: ListTile(
        key: ValueKey('trending_item_$index'),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        horizontalTitleGap: 12.w,
        leading: ClipOval(
          child: CachedImage(
            imageUrl: 'assets/images/new-coin.png',
            width: 40.w,
            height: 40.w,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary(context),
          ),
          'name',
        ),
        subtitle: Text(
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary(context),
          ),
          '\$20K | 大户建仓买入',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
                '\$0.0106'),
            Text(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondary,
              ),
              '-14.22%',
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
