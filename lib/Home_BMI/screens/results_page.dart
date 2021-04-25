import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/constants.dart';
import 'package:sprightly/Home_BMI/components/reusable_card.dart';
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class ResultsPage extends StatefulWidget {
  ResultsPage(
      {@required this.interpretation,
      @required this.bmiResult,
      @required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: glb.main_scaffold_background,
      appBar: glb.appBar_Sprightly(() {
          setState(() {
            glb.switchTheme();
          });
        }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
          //       boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     // spreadRadius: 5,
          //     blurRadius: 5,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
                  color: glb.main_background,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Your Result",
                style: getAppTextStyle(18, glb.main_foreground_header, true),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(  
                    colour: glb.main_background,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.resultText.toUpperCase(),
                          style: getResultTextStyle(double.parse(widget.bmiResult)),
                        ),
                        Text(
                          widget.bmiResult,
                          style: getAppTextStyle(100, glb.main_foreground_header, true),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            widget.interpretation,
                            textAlign: TextAlign.center,
                            style: getAppTextStyle(16, glb.main_foreground_header, false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
