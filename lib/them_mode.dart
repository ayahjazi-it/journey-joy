import 'package:flutter/material.dart';

class ModeThem {
  static final ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Colors.grey[900]!,
      onPrimary: Colors.white,
    ),
  );
}
