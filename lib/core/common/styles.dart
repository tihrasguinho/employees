import 'package:flutter/material.dart';

class Styles {
  const Styles._();

  static const colors = (
    blue: Color(0xFF0500FF),
    blue10: Color(0xFFEDEFFB),
    black: Color(0xFF1C1C1C),
    white: Color(0xFFFFFFFF),
    gray20: Color(0xFF9E9E9E),
    gray10: Color(0xFFDFDFDF),
    gray05: Color(0xFFF5F5F5),
    gray00: Color(0xFFF0F0F0),
  );

  static const texts = (
    h1: TextStyle(
      fontSize: 20,
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w700,
    ),
    h2: TextStyle(
      fontSize: 16,
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w700,
    ),
    h3: TextStyle(
      fontSize: 14,
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
    ),
  );

  static const assets = (logo: 'assets/logo.svg');

  static ThemeData theme = ThemeData(
    fontFamily: 'HelveticaNeue',
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: colors.white,
    appBarTheme: AppBarTheme(backgroundColor: colors.white),
  );
}
