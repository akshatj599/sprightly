import 'package:flutter/material.dart';
import 'package:sprightly/views/AppHomeScreen.dart';
import 'package:sprightly/views/Home_main.dart';
import 'package:sprightly/widgets/chart.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  String userName;
  String gender;
  String emailId;
  int goal_weight;
  int goal_calories;

  void getDataFromFirebase() {
    userName = "Not found";
    gender = "Not found";
    emailId = "Not found";
    goal_weight = 0;
    goal_calories = 0;
    if (glb.currentUserDetails.isNotEmpty) {
      userName = glb.currentUserDetails['Username'];
      gender = glb.currentUserDetails['Gender'];
      emailId = glb.currentUserDetails['Email'];
      goal_weight = glb.currentUserDetails['Target Weight'] ??
          glb.currentUserDetails['Weight'];
      goal_calories = glb.currentUserDetails['Target Calories'];
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataFromFirebase();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: glb.main_background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    // spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    "images/user_default.png",
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User Name: ",
                        style: getAppTextStyle(
                            16, glb.main_foreground_dimmer, false),
                      ),
                      Text(
                        userName,
                        style: getAppTextStyle(
                            16, glb.main_foreground_header, true),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email: ",
                        style: getAppTextStyle(
                            16, glb.main_foreground_dimmer, false),
                      ),
                      Text(
                        emailId,
                        style: getAppTextStyle(
                            16, glb.main_foreground_header, true),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gender: ",
                        style: getAppTextStyle(
                            16, glb.main_foreground_dimmer, false),
                      ),
                      Text(
                        gender,
                        style: getAppTextStyle(
                            16, glb.main_foreground_header, true),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BottomButton(
                      buttonTitle: 'Sign Out',
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        glb.currentUserDetails = {};
                        print("User Signed Out");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppHomeScreen()));
                      }),
                ],
              ),
            ),
            LineChartSample2(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: glb.main_background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    // spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Center(
                      child: Text("Goals",
                          style: getAppTextStyle(
                              18, glb.main_foreground_header, true))),
                  SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Text(
                                goal_weight.toString() + " kg",
                                style: getAppTextStyle(
                                    40, glb.main_foreground_header, true),
                              ),
                              Text(
                                "Weight",
                                style: getAppTextStyle(
                                    18, glb.main_foreground_dimmer, true),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: VerticalDivider(
                              color: glb.main_foreground_dimmer,
                              width: 5,
                              indent: 10,
                              endIndent: 7,
                            )),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Text(
                                goal_calories.toString(),
                                style: getAppTextStyle(
                                    40, glb.main_foreground_header, true),
                              ),
                              Text(
                                "Calories",
                                style: getAppTextStyle(
                                    18, glb.main_foreground_dimmer, true),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
