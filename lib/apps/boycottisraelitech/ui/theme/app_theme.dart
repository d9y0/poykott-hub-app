import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colorScheme: SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: Color.fromARGB(255, 48, 62, 90),
        primaryContainer: Color.fromARGB(255, 48, 62, 90),
        secondaryContainer: Color.fromARGB(255, 33, 46, 70),
        tertiaryContainer: Color.fromARGB(255, 88, 116, 168),
      ),

      background: Color(0xff2f3b52),
      scaffoldBackground: Color(0xff242e42), //Color(0xff1c242f),
      appBarBackground: Color(0xff242e42),
      useMaterial3: true,
    );
    /*return FlexThemeData.dark(
      scheme: FlexScheme.blueM3,
      useMaterial3: true,
    );*/
  }

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      colorScheme: SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.lightBlue,

        //tones: FlexTones.vivid(Brightness.dark),
      ),
      useMaterial3: true,
    );
    /*return FlexThemeData.light(
      scheme: FlexScheme.blue,
      useMaterial3: true,
    );*/
  }
}
