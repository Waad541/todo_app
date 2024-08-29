import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/my_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
        decoration: BoxDecoration(
            color:provider.appTheme == ThemeMode.light
                ? Colors.white
                : Color(0xff141922),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    context.setLocale(Locale('ar'));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('arabic'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      context.locale!=Locale('en')
                          ? Icon(Icons.done, size: 25)
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.setLocale(Locale('en'));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('english'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      context.locale==Locale('en')
                          ? Icon(Icons.done, size: 25)
                          : SizedBox(),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
