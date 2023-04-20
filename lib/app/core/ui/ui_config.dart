import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiConfig {
  UiConfig._();

  static String get title => "UniChat";

  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffE42E2E),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xffE42E2E)),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffE42E2E),
          ),
        ),
      );
}
