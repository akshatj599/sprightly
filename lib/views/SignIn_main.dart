import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/views/Sprightly.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:sprightly/views/SignUp_main.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/backend/backend.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool scrollPossible = false;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        scrollPossible = scrollController.position.extentAfter > 0;
      });
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "images/back_main.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        'images/sprightly_logo.png',
                        width: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.height / 4 + 80),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          decoration: getGradientBoxDecoration(),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: getAppTextStyle(
                                          18, Colors.grey[900], true),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: emailFormKey,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: Column(
                                      children: [
                                        //Email
                                        TextFormField(
                                            controller: emailController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (val) {
                                              return RegExp(
                                                          // Escape Character: \
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val)
                                                  ? null
                                                  : "Please enter a valid email";
                                            },
                                            decoration:
                                                inputTextFieldDecoration(
                                                    "Email"),
                                            style: getAppTextStyle(
                                                16, Colors.grey[900], false)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Form(
                                    key: passwordFormKey,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: Column(
                                        children: [
                                          //Password
                                          TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            validator: (val) {
                                              return val.isNotEmpty
                                                  ? null
                                                  : "Please enter your password";
                                            },
                                            decoration:
                                                inputTextFieldDecoration(
                                                    "Password"),
                                            style: getAppTextStyle(
                                                16, Colors.grey[900], false),
                                          ),

                                          //Forgot Password
                                          Container(
                                            alignment: Alignment.centerRight,
                                            height: 70,
                                            child: GestureDetector(
                                              onTap: () async {
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                                bool valid = emailFormKey
                                                    .currentState
                                                    .validate();
                                                if (emailController
                                                        .text.isEmpty ||
                                                    !valid) {
                                                  showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.error(
                                                      message:
                                                          "Enter a valid email",
                                                      textStyle:
                                                          getAppTextStyle(
                                                              16,
                                                              Colors.white,
                                                              true),
                                                    ),
                                                    displayDuration:
                                                        Duration(seconds: 1),
                                                  );
                                                } else if (valid) {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .sendPasswordResetEmail(
                                                            email:
                                                                emailController
                                                                    .text);
                                                    showTopSnackBar(
                                                      context,
                                                      CustomSnackBar.success(
                                                        message:
                                                            "Verification link sent at " +
                                                                emailController
                                                                    .text,
                                                        textStyle:
                                                            getAppTextStyle(
                                                                16,
                                                                Colors.white,
                                                                true),
                                                      ),
                                                      displayDuration:
                                                          Duration(seconds: 1),
                                                    );
                                                  } catch (error) {
                                                    showSnackBar(
                                                        error.message, context);
                                                  } finally {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
                                                }
                                              },
                                              child: Text(
                                                "Forgot Password?",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 16,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          //Sign In
                                          ButtonTheme(
                                            minWidth: 160,
                                            height: 40,
                                            child: BottomButton(
                                              buttonTitle: "Sign In",
                                              onTap: () async {                                                
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                try {
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text);
                                                  glb.isUserSignedIn = true;
                                                  print("User Signed In");
                                                  getUserDetailsFromFB();
                                                } catch (error) {
                                                  showSnackBar(
                                                      error.message, context);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  return;
                                                }
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SprightlyHome(
                                                                false)),
                                                    ModalRoute.withName(
                                                        "/AppHomeScreen"));
                                              },
                                            ),
                                          ),

                                          (isLoading)
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  alignment: Alignment.center,
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator())
                                              : SizedBox(height: 30),

                                          //Create an account
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "New to Sprightly?",
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 16,
                                                      fontFamily: "Poppins"),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SignUpView()));
                                                  },
                                                  child: Text(
                                                    "Create an account.",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontSize: 16,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          )),
                    ),
                    (scrollPossible)
                        ? Image.asset("images/down_arrow.png",
                            height: 30, color: Colors.white)
                        : SizedBox(height: 30),
                    SizedBox(height: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
