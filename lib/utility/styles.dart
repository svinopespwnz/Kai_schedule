import 'package:flutter/cupertino.dart';

abstract class AppStyles {
  static const backgroundColor = Color(0xFFEBEEF2);
static const iconColor= Color(0xFF1976D2);
  ///
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
}
