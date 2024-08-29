import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{

  ThemeMode appTheme=ThemeMode.light;

  changeTheme(ThemeMode theme){
    appTheme=theme;
    notifyListeners();
  }


}