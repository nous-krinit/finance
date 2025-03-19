import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  static TextStyle quote = const TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      color: secondaryColor,
      fontWeight: FontWeight.w600);
  static TextStyle quoteAuthor = const TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      color: greyColor,
      fontWeight: FontWeight.w600);
  static TextStyle appBar = const TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      color: secondaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle appBarButton = const TextStyle(
      fontSize: 14,
      fontFamily: 'Poppins',
      color: primaryColor,
      fontWeight: FontWeight.w600);
  static TextStyle navigationBar = const TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    color: secondaryColor,
  );
  static TextStyle input = const TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    color: secondaryColor,
  );
  static TextStyle label = const TextStyle(
      fontSize: 14,
      fontFamily: 'Poppins Light',
      color: secondaryColor,
      fontWeight: FontWeight.bold);
}
