import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/constants.dart';
import 'package:sprightly/Home_BMI/components/reusable_card.dart';
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/widgets/widgets.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(
      {@required this.interpretation,
      @required this.bmiResult,
      @required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Image.asset('images/sprightly_logo.png', height: 40),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Your Result",
                style: kLargeButtonTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(  
                    colour: kGeneralbackground,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          resultText.toUpperCase(),
                          style: getResultTextStyle(double.parse(bmiResult)),
                        ),
                        Text(
                          bmiResult,
                          style: getAppTextStyle(100, Colors.grey[800], true),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            interpretation,
                            textAlign: TextAlign.center,
                            style: getAppTextStyle(16, Colors.grey[800], false),
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
