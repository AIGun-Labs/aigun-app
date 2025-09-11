import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_svg/svg.dart';

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
          BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            return state.maybeWhen(
                orElse: () => CircleAvatar(
                      radius: 20,
                      child: Image.asset("assets/test/default-avatar.png"),
                    ),
                success: (user) => CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        getImageUrl(user.avatar) ?? "",
                      ),
                      child: Image.asset("assets/test/default-avatar.png"),
                    ));
          }),
          const SizedBox(width: 18),
          Expanded(
              child: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                        const Text("Paste",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textTertiary(context), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textTertiary(context), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textTertiary(context), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
