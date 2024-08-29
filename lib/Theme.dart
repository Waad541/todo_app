import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff5D9CEC),

    ),
    scaffoldBackgroundColor: Color(0xffDFECDB),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showUnselectedLabels: false,
      selectedItemColor: Color(0xff5D9CEC),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black
      ),
      bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
    )

  );

  static ThemeData darkTheme=ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff5D9CEC),
    ),
    scaffoldBackgroundColor: Color(0xff060E1E),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showUnselectedLabels: false,
      selectedItemColor: Color(0xff5D9CEC),
    ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color(0xff141922)
  ),
      textTheme: TextTheme(
          bodyMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),
        bodyLarge: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
      )

  );
}