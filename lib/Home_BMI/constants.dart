import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColour = Color(0xFFFFCC80);
// Color(0xFFFFB74D); //Colors.orange[300]

const kMaleActiveCardColour = Color(0xFF82e0ff);
const kFemaleActiveCardColour = Color(0xFFfab1f5);

const kInactiveCardColour = Colors.white;
const kBottomContainerColour = Color(0xFFEC407A); //Colors.pink[400]
const kGeneralbackground = Colors.white;

TextStyle kLabelTextStyle = getAppTextStyle(14, Colors.grey[800], false);

TextStyle kNumberTextStyle = getAppTextStyle(25, Colors.grey[800], true);

TextStyle kLargeButtonTextStyle = getAppTextStyle(18, Colors.grey[800], true);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

TextStyle getResultTextStyle(double bmi){
  return TextStyle(
      color: (bmi>=18.5 && bmi<25)?Color(0xFF24D876):Colors.red,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins'
  );
}

