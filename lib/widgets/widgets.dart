import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

void showSnackBar(String textToDisplay, BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(textToDisplay)));
}

String capitalizeEachWord(String input, bool doLower) {
  if (doLower) {
    input = input.toLowerCase();
  }
  List<String> list = input.split(' ');
  String output = "";
  list.forEach((element) {
    element = element[0].toUpperCase() + element.substring(1);
    output += element + " ";
  });
  return output.trimRight();
}

InputDecoration inputTextFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle:
        TextStyle(color: Colors.grey[700], fontSize: 16, fontFamily: "Poppins"),
    focusedBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: Color(0xff264653), style: BorderStyle.solid),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff264653)),
    ),
  );
}

BoxDecoration getGradientBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
        stops: [0.5, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          //Sunkist
          Color(0xffFFFFFF).withOpacity(0.8),
          Color(0xffffc4cb).withOpacity(0.8),
          // Color(0xffffc4cb).withOpacity(0.8),
        ],
      ),
      borderRadius: BorderRadius.circular(10));
}
