import 'package:flutter/material.dart';

const Color primary = Color(0xFF506CA4);
const Color accent = Color(0xFF506CA4);
const Color lightAccent = Color(0xFF506CA4);

const Color bgDark = Color(0xFF000000);
const Color bgLight = Color(0xFFF0F0F0);

const Color darkSurface = Color(0xFF111111);
const Color lightSurface = Color(0xFFFFFFFF);


final lightTheme = ThemeData(
  scaffoldBackgroundColor: bgLight,
  appBarTheme: const AppBarTheme(
    color: bgLight,
    elevation: 0,
  ),
  disabledColor: const Color(0xFFd0d0d1),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: lightSurface,
    elevation: 2.0,
  ),
  canvasColor: lightSurface,
  splashColor: Colors.transparent,
  iconTheme: const IconThemeData(color: bgDark),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: bgDark,
    contentTextStyle: const TextStyle().copyWith(
      color: lightSurface,
    ),
  ),
  textTheme: TextTheme(
    button: const TextStyle(color: bgDark),
    headline6: TextStyle(
      fontSize: 32,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w700,
      color: bgDark.withOpacity(0.8),
    ),
    headline5: TextStyle(
      fontSize: 28,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w500,
      color: bgDark.withOpacity(0.8),
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w500,
      color: bgDark.withOpacity(0.8),
    ),
    subtitle1: TextStyle(
      color: bgDark.withOpacity(0.8),
    ),
    bodyText1: const TextStyle(
      color: bgDark,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primary,
    secondary: lightAccent,
    secondaryVariant: accent,  
    surface: lightSurface,
    onBackground: bgDark,
    onError: bgDark,
    onPrimary: bgDark,
    onSecondary: bgDark,
    onSurface: bgDark,
  ),
);

final darkTheme = ThemeData(
  backgroundColor: bgDark,
  scaffoldBackgroundColor: bgDark,
  appBarTheme: const AppBarTheme(
    color: bgDark,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: bgDark,
    elevation: 0.0,
  ),
  canvasColor: darkSurface,
  splashColor: Colors.transparent,
  disabledColor: const Color(0xFF29282c),
  iconTheme: const IconThemeData(color: bgLight),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5,),),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightSurface,
    contentTextStyle: const TextStyle().copyWith(
      color: bgDark,
    ),
  ),
  textTheme: const TextTheme(
    button: TextStyle(color: bgLight),
    headline6: TextStyle(
      fontSize: 32,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 28,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w500,
      color: bgLight,
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontFamily: "Cabin",
      fontWeight: FontWeight.w500,
      color: bgLight,
    ),
    subtitle1: TextStyle(
      color: bgLight,
    ),
    bodyText1: TextStyle(
      color: bgLight,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primary,
    secondary: accent,
    secondaryVariant: lightAccent,
    surface: darkSurface,
    onBackground: lightSurface,
    onError: lightSurface,
    onPrimary: lightSurface,
    onSecondary: lightSurface,
    onSurface: lightSurface,
  ),
);