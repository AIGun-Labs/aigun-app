import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
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
      child: Center(child: Text(S.of(context).noData)),
    );
  }
}
