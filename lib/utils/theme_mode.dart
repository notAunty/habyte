import 'package:flutter/material.dart';

ThemeMode themeModeFromString(String str) {
  switch (str) {
    case "light":
      return ThemeMode.light;
    case "dark":
      return ThemeMode.dark;
    case "system":
    default:
      return ThemeMode.system;
  }
}

String themeModeToString(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return "light";
    case ThemeMode.dark:
      return "dark";
    case ThemeMode.system:
    default:
      return "system";
  }
}