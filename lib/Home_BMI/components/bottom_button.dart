import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/constants.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
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
            style: getAppTextStyle(
                16,
                glb.dark_theme ? glb.main_foreground_header : Colors.white,
                true),
          ),
        ),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                // spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: glb.dark_theme ? Colors.purple[900] : kBottomContainerColour,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
