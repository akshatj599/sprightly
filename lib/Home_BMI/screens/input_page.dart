import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprightly/Home_BMI/calculator_brain.dart';
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/Home_BMI/components/icon_content.dart';
import 'package:sprightly/Home_BMI/components/reusable_card.dart';
import 'package:sprightly/Home_BMI/components/round_icon_button.dart';
import 'package:sprightly/Home_BMI/screens/results_page.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 5),
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
                "Calculate Your BMI",
                style: getAppTextStyle(18, glb.main_foreground_header, true),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? Color(0xFF82e0ff)
                        : glb.main_background,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                      iconColor: selectedGender == Gender.male
                          ? Colors.grey[800]
                          : glb.main_foreground_header,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? Color(0xFFfab1f5)
                        : glb.main_background,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                      iconColor: selectedGender == Gender.female
                          ? Colors.grey[800]
                          : glb.main_foreground_header,
                    ),
                  ),
                ),
              ],
            ),
            ReusableCard(
              colour: glb.main_background,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style:
                        getAppTextStyle(14, glb.main_foreground_header, false),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: getAppTextStyle(
                              25, glb.main_foreground_header, true),
                        ),
                        Text(
                          ' cm',
                          style: getAppTextStyle(
                              14, glb.main_foreground_header, false),
                        )
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Colors.grey[200],
                      activeTrackColor: Colors.orange[300],
                      thumbColor: Colors.orange[800],
                      // ? Colors.purple[900]
                      // : Colors.pink[400],
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: glb.main_background,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: getAppTextStyle(
                              14, glb.main_foreground_header, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                weight.toString(),
                                style: getAppTextStyle(
                                    25, glb.main_foreground_header, true),
                              ),
                              Text(
                                " kg",
                                style: getAppTextStyle(
                                    14, glb.main_foreground_header, false),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: glb.main_background,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: getAppTextStyle(
                              14, glb.main_foreground_header, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                age.toString(),
                                style: getAppTextStyle(
                                    25, glb.main_foreground_header, true),
                              ),
                              Text(
                                " yr",
                                style: getAppTextStyle(
                                    14, glb.main_foreground_header, false),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(
                                  () {
                                    age--;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BottomButton(
              buttonTitle: 'CALCULATE',
              onTap: () async {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);

                await Navigator.of(context)
                    .push(PageRouteBuilder(
                        pageBuilder: (context, animation, anotherAnimation) {
                          return ResultsPage(
                            bmiResult: calc.calculateBMI(),
                            resultText: calc.getResult(),
                            interpretation: calc.getInterpretation(),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder:
                            (context, animation, anotherAnimation, child) {
                          return SlideTransition(
                            position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0))
                                .animate(animation),
                            child: child,
                          );
                        }))
                    .then((value) {
                  glb.bnb.onTap(glb.bnb.currentIndex);
                });

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ResultsPage(
                //       bmiResult: calc.calculateBMI(),
                //       resultText: calc.getResult(),
                //       interpretation: calc.getInterpretation(),
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
