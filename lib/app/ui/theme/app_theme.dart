import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_playground/sharedd/data/local/storage_service.dart';
//import 'package:flutter_playground/sharedd/domain/providers/sharedpreferences_storage_service_provider.dart';

import './app_colors.dart';
import './text_styles.dart';
import './text_theme.dart';

///dark :

///
///
///background color #1c242f
///background color #1d2733
///appbar color #233040
///background color #242e38
///appbar color #262e3b

///
///text color #d5d9dd
///text color #6f7985
///
///
///budg color #6f7985
///color text on budge #434f5b
///
///
///selected text color #434f5b
///
///

class AppTheme {
  ///scafuld background #242e42--
  ///background #2f3b52 --
  ///#1c242f--
  ///#141c21
  ///
  ///#1e1f2f
  ///
  ///#1c2f26
  ///#14211b
  ///
  ///
  ///
  ///--
  ///
  ///scaffoldBackground #1c242f 0xff1c242f
  ///appBarBackground  #242e42 0xff242e42
  ///defult background #2f3b52 0xff2f3b52
  ///primary #141c21 0xff141c21
  ///secondary #1e1f2f 0xff1e1f2f
  ///
  ///tertiary #1c2f26 0xff1c2f26
  ///
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colorScheme: SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: Color.fromARGB(255, 48, 62, 90),
        primaryContainer: Color.fromARGB(255, 48, 62, 90),
        secondaryContainer: Color.fromARGB(255, 33, 46, 70),
        tertiaryContainer: Color.fromARGB(255, 88, 116, 168),

        //tones: FlexTones.vivid(Brightness.dark),
      ),
      //scheme: FlexScheme.blueM3,
      /*colors: FlexSchemeColor(
        primary: Color.fromARGB(255, 48, 62, 90),
        secondary: Color.fromARGB(255, 33, 46, 70),
        tertiary: Color.fromARGB(255, 88, 116, 168),
      ),*/
      background: Color(0xff2f3b52),
      scaffoldBackground: Color(0xff242e42), //Color(0xff1c242f),
      appBarBackground: Color(0xff242e42),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheaamee {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
        error: AppColors.error,
        background: AppColors.black,
      ),
      // backgroundColor: AppColors.black,
      scaffoldBackgroundColor: const Color(0xff1c242f),
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xff233040),
        titleTextStyle: AppTextStyles.h2,
      ),
    );
  }

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      //scheme: FlexScheme.blue,
      colorScheme: SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.lightBlue,

        //tones: FlexTones.vivid(Brightness.dark),
      ),
      useMaterial3: true,
    );
  }

  /// Light theme data of the app
  static ThemeData get lightThemeaaae {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: ColorScheme(
        primary: Color(0xFF0A0E21),
        onBackground: Colors.white,
        onError: Colors.yellow,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        background: Colors.yellow,
        secondary: Colors.purple,
        surface: Color(0xFF0A0E21),
        error: Colors.red,
        onPrimary: Color(0xFF0A0E21),
        brightness: Brightness.dark,
      ),

      /*colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
        error: AppColors.error,
      ),*/
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
