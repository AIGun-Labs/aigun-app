import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/locale.dart';
import '../../core/service_locator.dart';
import '../../features/language/domain/entities/language_setting_entity.dart';
import '../../features/language/presentation/controllers/locale_controller.dart';
import '../../l10n/l10n.dart';
import '../../shared/presentation/widgets/appbar_widget.dart';

class SwitchLanguageScreen extends StatefulWidget {
  const SwitchLanguageScreen({super.key});

  @override
  State<SwitchLanguageScreen> createState() => _SwitchLanguageScreenState();
}

class _SwitchLanguageScreenState extends State<SwitchLanguageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: S.of(context).language, centerTitle: true),
      body: ValueListenableBuilder<LanguageSettingEntity>(
        valueListenable: ValueNotifier(getIt<LocaleController>().setting),
        builder: (context, value, _) {
          print('Current language code: ${value.locale.languageCode}');
          return ListView(
            children: [
              ...supportedlocales.map((item) {
                final isSelected =
                    value.locale.languageCode == item['locale']!.languageCode;

                return ListTile(
                  title: Text(item['name']!),
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
                  onTap: () =>
                      getIt<LocaleController>().setLocale(item['locale']!),
                );
              }),

              // ListTile(
              //   title: Text(S.of(context).followSystem),
              //   trailing: value.followSystem
              //       ? Container(
              //           width: 24.w,
              //           height: 24.w,
              //           decoration: const BoxDecoration(
              //             color: Colors.black,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.check,
              //             size: 16.sp,
              //             color: Colors.white,
              //           ),
              //         )
              //       : null,
              //   onTap: () => getIt<LocaleController>().followSystemMode(),
              // ),
            ],
          );
        },
      ),
    );
  }
}
