import 'package:flutter/cupertino.dart';

TextStyle getAppTextStyle(double size, Color color, bool isBold) {
  FontWeight fontWeight;
  if (isBold)
    fontWeight = FontWeight.bold;
  else
    fontWeight = FontWeight.w400;
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: "Poppins",
      fontWeight: fontWeight);
}
