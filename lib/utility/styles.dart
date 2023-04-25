import 'package:flutter/material.dart';

abstract class AppStyles {
  static const backgroundColor = Color(0xFFEBEEF2);
  static const iconColor = Color(0xFF1976D2);
  static const selectedLabelStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const dayTimeTextStyle =
      TextStyle(color: Color(0xFF1976D2), fontSize: 26);
  static const buildingTextStyle = TextStyle(
    fontSize: 12,
  );
  static const auditoriumTextStyle = TextStyle(
    fontSize: 12,
  );
  static const disciplineNameTextStyle = TextStyle(
      color: Color(0xFF1976D2), fontSize: 14, fontWeight: FontWeight.w600);
  static const disciplineTypeTextStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const lecturerTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static const dayDateTextStyle = TextStyle(
      color: Color(0xFF1976D2), fontSize: 10.5, fontWeight: FontWeight.w600);
  static const groupNumberTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static const modalBottomSheetDisciplineNameTextStyle =
      TextStyle(fontSize: 26, fontWeight: FontWeight.w600);
  static const modalBottomSheetScoreTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static ThemeData get light {
    return ThemeData(
        cardColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xffedeef0),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          color: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(labelColor: Colors.black),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        extensions: <ThemeExtension<dynamic>>[SwitchColors.light]);
  }

  static ThemeData get dark {
    return ThemeData(
        cardColor: const Color(0xff182633),
        scaffoldBackgroundColor: const Color(0xff151925),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xfffefefe),
            unselectedItemColor: Color(0xff727c86),
            backgroundColor: Color(0xff17212b)),
        appBarTheme: const AppBarTheme(
          color: Color(0xff17212b),
        ),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        extensions: <ThemeExtension<dynamic>>[SwitchColors.dark]);
  }
}

class SwitchColors extends ThemeExtension<SwitchColors> {
  final Color backgroundColor;
  final Color textColor;
  const SwitchColors({required this.backgroundColor, required this.textColor});

  @override
  ThemeExtension<SwitchColors> copyWith(
      {Color? backgroundColor, Color? textColor}) {
    return SwitchColors(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor);
  }

  @override
  ThemeExtension<SwitchColors> lerp(
      ThemeExtension<SwitchColors>? other, double t) {
    if (other is! SwitchColors) {
      return this;
    }

    return SwitchColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }

  static get dark => const SwitchColors(
      backgroundColor: Color(0xff2f3741), textColor: Color(0xffffffff));
  static get light => const SwitchColors(
      backgroundColor: Color(0xFFEBEEF2), textColor: Colors.black);
}
