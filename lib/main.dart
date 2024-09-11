import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/HomeScreen.dart';
import 'package:todo_app/Theme.dart';
import 'package:todo_app/edit.dart';
import 'package:todo_app/register/login.dart';
import 'package:todo_app/register/signup.dart';
import 'package:todo_app/splash_screen.dart';

import 'Providers/my_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')],
    startLocale: Locale('en'),
    path: 'assets/translations',
    child: ChangeNotifierProvider(
        create: (context) => MyProvider(), child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyTheme.lightTheme,
      themeMode: provider.appTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        Edit.routeName: (context) => Edit()
      },
    );
  }
}
