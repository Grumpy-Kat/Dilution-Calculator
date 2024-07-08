import 'package:flutter/cupertino.dart';

const Color backgroundColorLightMode = Color.fromRGBO(255, 255, 255, 1);
const Color backgroundColorDarkMode = Color.fromRGBO(0, 0, 0, 1);
const CupertinoDynamicColor backgroundColor = CupertinoDynamicColor.withBrightness(
    color: backgroundColorLightMode,
    darkColor: backgroundColorDarkMode,
);

const Color primaryColorLightMode = Color.fromRGBO(0, 122, 255, 1);
const Color primaryColorDarkMode = Color.fromRGBO(10, 132, 255, 1);
const CupertinoDynamicColor primaryColor = CupertinoDynamicColor.withBrightness(
    color: primaryColorLightMode,
    darkColor: primaryColorDarkMode,
);
const Color primaryContrastingColorLightMode = Color.fromRGBO(3, 3, 3, 1);
const Color primaryContrastingColorDarkMode = Color.fromRGBO(253, 253, 253, 1);
const CupertinoDynamicColor primaryContrastingColor = CupertinoDynamicColor.withBrightness(
    color: primaryContrastingColorLightMode,
    darkColor: primaryContrastingColorDarkMode,
);

const Color textColorLightMode = Color.fromRGBO(0, 0, 0, 1);
const Color textColorDarkMode = Color.fromRGBO(255, 255, 255, 1);
const CupertinoDynamicColor textColor = CupertinoDynamicColor.withBrightness(
    color: textColorLightMode,
    darkColor: textColorDarkMode
);
const Color secondaryTextColorLightMode = Color.fromRGBO(153, 153, 153, 1);
const Color secondaryTextColorDarkMode = Color.fromRGBO(117, 117, 117, 1);
const CupertinoDynamicColor secondaryTextColor = CupertinoDynamicColor.withBrightness(
    color: secondaryTextColorLightMode,
    darkColor: secondaryTextColorDarkMode
);
const CupertinoTextThemeData textTheme = CupertinoTextThemeData(
  primaryColor: primaryColor,
  textStyle: TextStyle(color: textColor),
  navLargeTitleTextStyle: TextStyle(color: textColor),
  navTitleTextStyle: TextStyle(color: textColor),
  tabLabelTextStyle: TextStyle(color: secondaryTextColor),
);

const Color navigationBarColorLightMode = Color.fromRGBO(249, 249, 249, 0.94);
const Color navigationBarColorDarkMode = Color.fromRGBO(29, 29, 29, 0.94);
const CupertinoDynamicColor navigationBarColor = CupertinoDynamicColor.withBrightness(
    color: navigationBarColorLightMode,
    darkColor: navigationBarColorDarkMode
);
const Color tabBarColorLightMode = Color.fromRGBO(249, 249, 249, 0.94);
const Color tabBarColorDarkMode = Color.fromRGBO(22, 22, 22, 0.94);
const CupertinoDynamicColor tabBarColor = CupertinoDynamicColor.withBrightness(
    color: navigationBarColorLightMode,
    darkColor: navigationBarColorDarkMode
);

const CupertinoThemeData themeData = CupertinoThemeData(
  applyThemeToAll: true,
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: primaryColor,
  primaryContrastingColor: primaryContrastingColor,
  textTheme: textTheme,
  barBackgroundColor: navigationBarColor,
);