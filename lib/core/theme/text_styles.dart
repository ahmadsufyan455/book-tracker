import 'package:flutter/material.dart';
import 'package:librio/gen/fonts.gen.dart';

class LibrioTextStyle {
  const LibrioTextStyle._();

  static const String fontFamily = FontFamily.lato;

  static TextStyle? title1 = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? title2 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? title3 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );

  static TextStyle? headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? subHeadline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static TextStyle? bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? smallBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static TextStyle? smallBodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle? buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle? buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );

  static TextStyle? buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
}
