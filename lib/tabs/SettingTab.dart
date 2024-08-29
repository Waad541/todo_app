import 'package:flutter/material.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Theme",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            // onTap: () {
            //   showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (context) {
            //       return ThemeBottom();
            //     },
            //   );
            // },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                'Dark',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          // Text(
          //   "language",
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          // SizedBox(
          //   height: 12,
          // ),
          // GestureDetector(
          //   // onTap: () {
          //   //   showModalBottomSheet(
          //   //     context: context,
          //   //     isScrollControlled: true,
          //   //     builder: (context) {
          //   //       return Language();
          //   //     },
          //   //   );
          //   // },
          //   child: Container(
          //     padding: const EdgeInsets.all(12.0),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(24),
          //       border: Border.all(color: Theme.of(context).primaryColor),
          //     ),
          //     child: Text(
          //       'jj',
          //       // currentLocale == Locale('en')? 'english'.tr():'arabic'.tr(),
          //       style: Theme.of(context).textTheme.bodySmall,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
