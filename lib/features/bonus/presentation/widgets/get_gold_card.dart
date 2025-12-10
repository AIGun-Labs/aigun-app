import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/image.dart';
import '../utils/show_about_gold_sheet.dart';
import 'card_widget.dart';

class GetGoldCard extends StatelessWidget {
  final int unclaimedGold;
  final Future<void> Function() onClaim;
  const GetGoldCard({
    super.key,
    required this.unclaimedGold,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final isLoadingNotifier = ValueNotifier<bool>(unclaimedGold <= 0);

    return CardWidget(
      paddingValue: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                S.of(context).unclaimedGold,
                style: TextStyle(
                    fontSize: 12.sp, color: AppColors.textSecondary(context)),
              ),
              2.horizontalSpace,
              InkWell(
                onTap: () => showAboutGoldSheet(context),
                child: Icon(Icons.info_outline,
                    size: 14.w, color: AppColors.textSecondary(context)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedImage(
                // const $AssetsImagesGen().gold.path,
                imageUrl: Assets.images.gold.path,
                width: 20.w,
              ),
              Expanded(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  unclaimedGold.comma(context),
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              )),
              ValueListenableBuilder(
                  valueListenable: isLoadingNotifier,
                  builder: (context, isloading, child) {
                    final canClaim = unclaimedGold > 0;

                    return InkWell(
                      onTap: () async {
                        if (!canClaim) return;

                        isLoadingNotifier.value = true;

                        if (isloading) return;

                        await onClaim();
                        if (!context.mounted) return;
                        ToastUtils.showCenterToast(
                            context, S.of(context).claimSuccess);
                        isLoadingNotifier.value = false;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isloading
                              ? AppColors.textTertiary(context)
                              : AppColors.quaternary,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Text(
                          S.of(context).claim,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.background(context),
                            height: 1.2,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
