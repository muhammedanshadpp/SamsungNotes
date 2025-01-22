import 'package:flutter/material.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color primary;
  final Color secondry;

  CustomTheme({
    required this.primary,
    required this.secondry,
  });
  @override
  ThemeExtension<CustomTheme> copyWith(
      {Color? primary, Color? secondry, Color? bagroundColor}) {
    return CustomTheme(
      primary: primary ?? this.primary,
      secondry: secondry ?? this.secondry,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      covariant ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }
    return CustomTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondry: Color.lerp(secondry, other.secondry, t)!,
    );
  }
}
