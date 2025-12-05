import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/colors.dart';
import '../../../utils/clipboard.dart';

class IntelHeader extends StatefulWidget {
  const IntelHeader({super.key});

  @override
  State<IntelHeader> createState() => _IntelHeaderState();
}

class _IntelHeaderState extends State<IntelHeader> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://cdn.route.aigun.ai/fission/images/avatar/12.png",
            ),
            child: Image.asset("assets/test/default-avatar.png"),
          ),
          SizedBox(width: 18),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: "Search name or CA",
                  hintStyle: TextStyle(color: AppColors.textTertiary(context)),
                  // prefixIcon: const Icon(Icons.search_sharp),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: SvgPicture.asset(
                      "assets/images/icons/lightning-search.svg",
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {
                      ClipboardUtils.paste().then((value) {
                        searchController.text = value;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[500]!.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon(
                          //   Icons.copy_all_outlined,
                          //   color: Colors.white,
                          // ),
                          SvgPicture.asset("assets/images/icons/copy.svg"),
                          const Text(
                            "Paste",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.textTertiary(context),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.textTertiary(context),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.textTertiary(context),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
