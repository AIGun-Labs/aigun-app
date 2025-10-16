import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';

class SwitchLanguageScreen extends StatefulWidget {
  const SwitchLanguageScreen({super.key});

  @override
  State<SwitchLanguageScreen> createState() => _SwitchLanguageScreenState();
}

class _SwitchLanguageScreenState extends State<SwitchLanguageScreen> {
  // 语言选项列表
  List<Map<String, String>> languages = [
    {'name': '简体中文', 'code': 'zh'},
    {'name': 'English', 'code': 'en'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonCustomAppBar(
        title: S.of(context).language,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          final currentLanguageCode = languageState.locale.languageCode;
          print('Current language code: $currentLanguageCode');
          return ListView(
            children: languages.map((language) {
              final isSelected = currentLanguageCode == language['code'];

              return ListTile(
                title: Text(language['name']!),
                trailing: isSelected
                    ? Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    : null,
                onTap: () async {
                  await context
                      .read<LanguageCubit>()
                      .setLanguage(context, language['code']!);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
