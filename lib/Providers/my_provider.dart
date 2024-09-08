import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_functions.dart';
import '../models/usermodel.dart';

class MyProvider extends ChangeNotifier{

  ThemeMode appTheme=ThemeMode.light;
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  Future<void> initUser() async {
    userModel = await FirebaseFunction.readUserData();
    notifyListeners();
  }

  changeTheme(ThemeMode theme){
    appTheme=theme;
    notifyListeners();
  }


}