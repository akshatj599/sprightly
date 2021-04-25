import 'package:flutter/material.dart';
import 'package:sprightly/views/AppHomeScreen.dart';
import 'package:sprightly/widgets/chart.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprightly/backend/backend.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  String userName;
  String gender;
  String emailId;
  double goalWeight;
  int goalCalories;
  bool isLoading = true;
  bool callFunction = true;

  Future<void> getDataFromFirebase() async {
    print("getDataFromFirebase() called");
    setState(() {
      isLoading = true;
    });
    userName = "Not found";
    gender = "Not found";
    emailId = "Not found";
    goalWeight = 0;
    goalCalories = 0;
    await getUserDetailsFromFB();
    if (glb.currentUserDetails.isNotEmpty) {
      userName = glb.currentUserDetails['Username'];
      gender = glb.currentUserDetails['Gender'];
      emailId = glb.currentUserDetails['Email'];
      var temp = glb.currentUserDetails['Target Weight'] ??
          glb.currentUserDetails['Weight'];
      goalWeight = temp + 0.0;
      goalCalories = glb.currentUserDetails['Target Calories'];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (callFunction) {
      callFunction = false;
      getDataFromFirebase();
    }
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))))
        : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: glb.main_background,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     // spreadRadius: 5,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
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
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await FirebaseAuth.instance.signOut();
                              if (glb.dark_theme) glb.switchTheme();
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
                  LineChartSample2(getDataFromFirebase),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: glb.main_background,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     // spreadRadius: 5,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
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
                                      goalWeight.toStringAsFixed(0) + " kg",
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
                                      goalCalories.toString(),
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
