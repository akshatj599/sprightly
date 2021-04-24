import 'package:flutter/material.dart';
import 'package:sprightly/views/Sprightly.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/views/SignIn_main.dart';
import 'package:sprightly/views/SignUp_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/backend/backend.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {

  
  //TODO: Add snack bar for INTERNET_SWITCHED_OFF Condition

  Column doIfSignedIn(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return SprightlyHome(false);
                },
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  );
                }));
    });
    return Column(
      children: [
        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))),
        Text(
          "Signing in as",
          style: getAppTextStyle(16, Colors.white, false),
        ),
        Text(FirebaseAuth.instance.currentUser.email,
            style: getAppTextStyle(16, Colors.white, true)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    glb.dark_theme = false;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: glb.backgroundImage,
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/sprightly_logo.png',
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ButtonTheme(
                    minWidth: 160,
                    height: 40,
                    child: BottomButton(
                      buttonTitle: "Sign In",
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return SignInView();
                },
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  );
                }));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ButtonTheme(
                    minWidth: 160,
                    height: 40,
                    child: BottomButton(
                      buttonTitle: "Sign Up",
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return SignUpView();
                },
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  );
                }));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  (FirebaseAuth.instance.currentUser != null)
                      ? doIfSignedIn(context)
                      : SizedBox(height: 0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
