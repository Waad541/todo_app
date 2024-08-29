import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/my_provider.dart';
import '../bottom_sheet/language_bottom_sheet.dart';
import '../bottom_sheet/theme_bottom_sheet.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "theme".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return ThemeBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                provider.appTheme==ThemeMode.dark ?
                'dark'.tr(): 'light'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "language".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return LanguageBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                context.locale==Locale('en')?
                'english'.tr():
                'arabic'.tr()
                ,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
