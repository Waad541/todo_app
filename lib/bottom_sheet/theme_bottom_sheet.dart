import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/my_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

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
                    provider.changeTheme(ThemeMode.light);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('light'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      provider.appTheme == ThemeMode.light
                          ? Icon(Icons.done, size: 25)
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    provider.changeTheme(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('dark'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      provider.appTheme != ThemeMode.light
                          ? Icon(Icons.done, size: 25)
                          : SizedBox(),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
