import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlowerTheme {
  // 色板：宣纸米白 + 胭脂红 + 墨绿 + 金黄
  static const Color background   = Color(0xFFFAF7F0); // 宣纸色
  static const Color surface      = Color(0xFFFFFEFB); // 白
  static const Color primary      = Color(0xFFC0392B); // 胭脂红
  static const Color primaryLight = Color(0xFFE8747A); // 浅胭脂
  static const Color secondary    = Color(0xFF4A7C59); // 墨绿
  static const Color accent       = Color(0xFFD4AF37); // 金黄
  static const Color textPrimary  = Color(0xFF3C2F2F); // 深墨褐
  static const Color textSecondary= Color(0xFF9E8F8F); // 浅灰褐
  static const Color divider      = Color(0xFFEDE8DE); // 浅米黄

  static TextStyle serif({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = textPrimary,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.notoSerifSc(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = textPrimary,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
          surface: surface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: serif(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
          iconTheme: const IconThemeData(color: textPrimary),
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: divider, width: 1),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          hintStyle: sans(fontSize: 14, color: textSecondary),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
}
