import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/language.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).wallet_addAccount,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildLanguageSelector(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final languageCubit = context.watch<LanguageCubit>();
    final currentLanguageCode = languageCubit.state.locale.languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择语言 / Select Language',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _languageOption(
              context,
              '中文',
              Language.zh,
              currentLanguageCode == Language.zh,
              languageCubit,
            ),
            const SizedBox(width: 16),
            _languageOption(
              context,
              'English',
              Language.en,
              currentLanguageCode == Language.en,
              languageCubit,
            ),
          ],
        ),
      ],
    );
  }

  Widget _languageOption(
    BuildContext context,
    String label,
    String languageCode,
    bool isSelected,
    LanguageCubit languageCubit,
  ) {
    return GestureDetector(
      onTap: () async {
        await languageCubit.setLanguage(context, languageCode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
