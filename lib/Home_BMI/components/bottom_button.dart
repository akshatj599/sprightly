import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/constants.dart';
import 'package:sprightly/widgets/widgets.dart';

class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: getAppTextStyle(16, Colors.white, true),
          ),
        ),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 20),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
          color: kBottomContainerColour,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
