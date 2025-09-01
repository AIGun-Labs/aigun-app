import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel_back/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/image_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_aigun/utils/date_time_helper.dart';

class IntelContent extends StatelessWidget {
  final IntelMessage? intel;

  const IntelContent({
    super.key,
    this.intel,
  });

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildMarkdownContent(String text) {
    return MarkdownBody(
      data: text,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(fontSize: 16.sp),
        h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        a: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        blockquote: TextStyle(
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
        code: TextStyle(
          backgroundColor: Colors.grey[200],
          fontFamily: 'monospace',
        ),
      ),
      onTapLink: (text, href, title) {
        if (href != null) {
          _launchUrl(href);
        }
      },
    );
  }

  // 引入推文内容
  Widget _buildQuotedContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 引用的头部
          Row(
            children: [
              // 头像
              CachedImage(
                imageUrl: intel?.user?.avator ?? '',
                width: 40.w,
                height: 40.w,
                borderRadius: BorderRadius.circular(20.r),
              ),
              SizedBox(width: 8.w),
              // 用户名和时间
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      intel?.user?.name ?? 'User',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateTimeHelper.formatTimestamp(intel?.timestamp),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (intel?.content != null) _buildMarkdownContent(intel!.content!),
          if (intel?.medias != null && intel!.medias!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            // 图片
            ImageGrid(
              imageUrls:
                  intel!.medias!.map((media) => media.url ?? '').toList(),
              height: 150.h,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ],
          if (intel?.content != null) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _launchUrl(intel?.origin ?? ''),
              child: Text(
                S.of(context).market_sourceLink,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMarkdownContent(intel?.analyze ?? ''),
        if (intel?.content != null) ...[
          SizedBox(height: 12.h),
          _buildQuotedContent(context),
        ],
      ],
    );
  }
}
