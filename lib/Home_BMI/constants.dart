import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

double kBottomContainerHeight = 80.0;
Color kBottomContainerColour = Color(0xFFEC407A); //Colors.pink[400]

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

TextStyle getResultTextStyle(double bmi) {
  return TextStyle(
      color: (bmi >= 18.5 && bmi < 25) ? Color(0xFF24D876) : Colors.red,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins');
}
