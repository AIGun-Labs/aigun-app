import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/locale.dart';
import '../../../../core/service_locator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/appbar_widget.dart';
import '../controllers/locale_controller.dart';

class LocaleSettingScreen extends StatelessWidget {
  const LocaleSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = getIt<LocaleController>();

    return Scaffold(
      appBar: AppbarWidget(title: S.of(context).language, centerTitle: true),
      body: ListenableBuilder(
        listenable: localeController,
        builder: (context, _) {
          return ListView(
            children: [
              ListTile(
                title: Text(S.of(context).followSystem),
                trailing: Switch(
                  activeTrackColor: Colors.black,
                  value: localeController.followSystem,
                  onChanged: (value) {
                    print('onChanged: $value');
                    if (value) {
                      localeController.followSystemMode();
                    } else {
                      localeController.getDefaultLocale();
                    }
                  },
                ),
              ),

              if (!localeController.followSystem)
                ...supportedlocales.map((item) {
                  final isSelected =
                      localeController.appLocale?.languageCode ==
                      item.locale.languageCode;

                  return ListTile(
                    title: Text(item.name),
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
                    onTap: () => localeController.setLocale(item.locale),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
