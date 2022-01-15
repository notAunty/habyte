import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: WHITE_02,
  appBarTheme: const AppBarTheme(
    color: WHITE_02,
    elevation: 0,
  ),
  disabledColor: GREY_02,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: WHITE_01,
    elevation: 2.0,
  ),
  cardColor: WHITE_01,
  canvasColor: WHITE_01,
  iconTheme: const IconThemeData(color: GREY_01),
  buttonTheme: const ButtonThemeData(
    height: 16,
    buttonColor: BLUE_02,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: BLUE_02,
      onPrimary: WHITE_01,
      textStyle: const TextStyle().copyWith(
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      )
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: BLACK_02,
    contentTextStyle: const TextStyle().copyWith(
      color: WHITE_01,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 40,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -1.5,
    ),
    headline2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 35,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.5,
    ),
    headline3: TextStyle(
      fontFamily: "Poppins",
      fontSize: 30,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.75
    ),
    headline4: TextStyle(
      fontFamily: "Poppins",
      fontSize: 25,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: 0.25,
    ),
    headline5: TextStyle(
      fontFamily: "Poppins",
      fontSize: 22,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.45
    ),
    headline6: TextStyle(
      fontFamily: "Poppins",
      fontSize: 19,
      color: BLACK_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: 0.15,
    ),
    subtitle1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      color: BLACK_02,
      fontWeight: FontWeight.w400,
      height: 1.15,
      // letterSpacing: 0
    ),
    subtitle2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      color: BLACK_02,
      height: 1.15,
      // fontWeight: FontWeight.w600,
      // letterSpacing: 0.1
    ),
    bodyText1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      color: BLACK_01,
      fontWeight: FontWeight.w400,
      height: 1.15,
      // letterSpacing: 0.01,
    ),
    bodyText2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      color: BLACK_01,
      height: 1.15,
    ),
    button: TextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      color: BLACK_01,
      fontWeight: FontWeight.w500,
      height: 1.15,

      // letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: "Poppins",
      color: BLACK_01,
      height: 1.15,
    ),
    overline: TextStyle(
      fontFamily: "Poppins",
      color: BLACK_02,
      height: 1.15,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: BLUE_01,
    secondary: BLUE_02,
    secondaryVariant: RED_02,
    background: WHITE_02,
    surface: WHITE_01,
    onBackground: BLACK_01,
    onError: BLACK_01,
    onPrimary: BLACK_01,
    onSecondary: BLACK_01,
    onSurface: BLACK_01,
  ),
);

final darkTheme = ThemeData(
  backgroundColor: BLACK_02,
  scaffoldBackgroundColor: BLACK_02,
  appBarTheme: const AppBarTheme(
    color: BLACK_02,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: BLACK_02,
    elevation: 0.0,
  ),
  cardColor: BLACK_03,
  canvasColor: BLACK_03,
  disabledColor: GREY_02,
  dialogBackgroundColor: BLACK_02,
  cardTheme: const CardTheme(elevation: 8),
  iconTheme: const IconThemeData(color: WHITE_02),
  buttonTheme: const ButtonThemeData(
    buttonColor: BLUE_02,
  ),
  primaryIconTheme: const IconThemeData(color: WHITE_02),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      onPrimary: WHITE_01,
      primary: BLUE_02,
      textStyle: const TextStyle().copyWith(
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      )
    ),
  ),
  // inputDecorationTheme: const InputDecorationTheme(
  //   border: OutlineInputBorder(),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: WHITE_01,
  //       width: 1.5,
  //     ),
  //   ),
  //   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  // ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: WHITE_01,
    contentTextStyle: const TextStyle().copyWith(
      color: BLACK_02,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 40,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -1.5,
    ),
    headline2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 35,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.5,
    ),
    headline3: TextStyle(
      fontFamily: "Poppins",
      fontSize: 30,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.75
    ),
    headline4: TextStyle(
      fontFamily: "Poppins",
      fontSize: 25,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: 0.25,
    ),
    headline5: TextStyle(
      fontFamily: "Poppins",
      fontSize: 22,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: -0.45
    ),
    headline6: TextStyle(
      fontFamily: "Poppins",
      fontSize: 19,
      color: WHITE_01,
      fontWeight: FontWeight.w600,
      height: 1.15,
      // letterSpacing: 0.15,
    ),
    subtitle1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      color: WHITE_02,
      fontWeight: FontWeight.w400,
      height: 1.15,
      // letterSpacing: 0
    ),
    subtitle2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      color: WHITE_02,
      height: 1.15,
      // fontWeight: FontWeight.w600,
      // letterSpacing: 0.1
    ),
    bodyText1: TextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      color: WHITE_01,
      fontWeight: FontWeight.w400,
      height: 1.15,
      // letterSpacing: 0.01,
    ),
    bodyText2: TextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      color: WHITE_01,
      height: 1.15,
    ),
    button: TextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      color: WHITE_01,
      fontWeight: FontWeight.w500,
      height: 1.15,
      // letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: "Poppins",
      color: WHITE_01,
      height: 1.15,
    ),
    overline: TextStyle(
      fontFamily: "Poppins",
      color: WHITE_01,
      height: 1.15,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: BLUE_01,
    secondary: BLUE_02,
    secondaryVariant: RED_02,
    background: BLACK_02,
    surface: BLACK_03,
    onBackground: WHITE_01,
    onError: WHITE_01,
    onPrimary: WHITE_01,
    onSecondary: WHITE_01,
    onSurface: WHITE_01,
  ),
);
