import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/theme_extension.dart';

final ThemeData darktheme = ThemeData.dark().copyWith(extensions: [
  CustomTheme(
    primary: Colors.black,
    secondry: Colors.white,
  )
]);
final ThemeData lighttheme = ThemeData.light().copyWith(extensions: [
  CustomTheme(
    primary: Colors.white,
    secondry: Colors.black,
  )
]);
