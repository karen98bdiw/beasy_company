import 'package:beasy_company/utils/style_color.dart';
import 'package:flutter/material.dart';

TextStyle mediumTextStyle({Color color}) {
  return TextStyle(
      color: color ?? Colors.black, fontSize: 18, fontWeight: FontWeight.w400);
}

TextStyle titleStyle({isLight = false}) => TextStyle(
      color: !isLight ? mainBtnColor : darkBackground,
      fontSize: 40,
      fontWeight: FontWeight.w600,
    );

TextStyle midiumTextStyle({Color color}) => TextStyle(
    color: color ?? Colors.grey[400],
    fontSize: 18,
    fontWeight: FontWeight.w400);
TextStyle smallTextStyle({Color color}) => TextStyle(
    color: color ?? Colors.grey[400],
    fontSize: 15,
    fontWeight: FontWeight.w400);
TextStyle largeTextStyle() => TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

const checkedTextStyle = const TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w700,
  color: Colors.pink,
  decoration: TextDecoration.underline,
  decorationThickness: 2,
);

const unCheckedTextStyle = const TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.pink,
);

const usualInfoTextStyle = TextStyle(
  color: Colors.white,
  height: 1,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const titleTextStyle = TextStyle(
    color: Colors.white, height: 1, fontSize: 17, fontWeight: FontWeight.w600);
