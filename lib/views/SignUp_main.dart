import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/components/bottom_button.dart';
import 'package:sprightly/views/Sprightly.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:sprightly/views/SignIn_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController targetWeightController = TextEditingController();

  bool isLoading = false;
  bool scrollPossible = false;
  final scrollController = ScrollController();
  String wishValue;
  String targetPerWeek;
  String gender;
  String exerciseFactor;

  void addNewUser(BuildContext context) async {
    if (wishValue == null ||
        gender == null ||
        exerciseFactor == null ||
        (wishValue != "Maintain Weight" && targetPerWeek == null)) {
      showSnackBar("One or more values have not been selected", context);
      formKey.currentState.validate();
      return null;
    }
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        FirebaseAuth _auth = FirebaseAuth.instance;
        UserCredential newUser = await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        newUser.user.sendEmailVerification();
        Alert(
            context: context,
            title: "Verify your email",
            style: AlertStyle(
                titleStyle: getAppTextStyle(18, Colors.black, true),
                descStyle: getAppTextStyle(16, Colors.grey[800], true)),
            image: Image.asset(
              "images/email_icon.png",
              height: 80,
            ),
            desc: "Click on the link sent at " + emailController.text,
            onWillPopActive: true,
            closeFunction: () async {
              try {
                await FirebaseAuth.instance.currentUser.delete();
                showSnackBar("Previous sign up attempt cancelled", context);
              } on FirebaseAuthException catch (error) {
                if (error.code == 'requires-recent-login') {
                  print(
                      'The user must reauthenticate before this operation can be executed.');
                }
                showSnackBar(error.message, context);
              } finally {
                Navigator.pop(context);
              }
            },
            buttons: [
              DialogButton(
                onPressed: () async {
                  await _auth.currentUser.reload();
                  if (_auth.currentUser.emailVerified) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.info(
                        message: "Email verified. Please wait for a moment.",
                        textStyle: getAppTextStyle(16, Colors.white, true),
                        icon: Icon(Icons.timer,
                            size: 120, color: Color(0x15000000)),
                      ),
                      displayDuration: Duration(seconds: 1),
                    );
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('Users');
                    int bmr = calculateBMR();
                    Map<String, dynamic> map = {
                      "Username": usernameController.text,
                      "Weight": double.parse(weightController.text),
                      "Height": double.parse(heightController.text),
                      "Age": int.parse(ageController.text),
                      "Gender": gender,
                      "Wish": wishValue,
                      "Lifestyle": exerciseFactor,
                      "Target Weight": targetWeightController.text.isNotEmpty
                          ? int.parse(targetWeightController.text)
                          : null,
                      "Weekly Target": targetPerWeek != null
                          ? double.parse(targetPerWeek.split(' ')[0])
                          : null,
                      "BMR": bmr,
                      "Target Calories": calculateCalories(bmr)
                    };
                    await users.doc(emailController.text).set({"Details": map});
                    await users.doc(emailController.text).update({"Diary": {}});
                    glb.currentUserDetails = map;
                    glb.currentUserDetails['Email'] = emailController.text;
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, anotherAnimation) {
                              return SprightlyHome(true);
                            },
                            transitionDuration: Duration(milliseconds: 300),
                            transitionsBuilder:
                                (context, animation, anotherAnimation, child) {
                              return SlideTransition(
                                position: Tween(
                                        begin: Offset(1.0, 0.0),
                                        end: Offset(0.0, 0.0))
                                    .animate(animation),
                                child: child,
                              );
                            }),
                        ModalRoute.withName("/AppHomeScreen"));
                    print("User & Details Added Successfully");
                  } else {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: "Not verified yet",
                        textStyle: getAppTextStyle(16, Colors.white, true),
                      ),
                      displayDuration: Duration(seconds: 1),
                    );
                  }
                },
                child: Text(
                  "Click here when done",
                  style: getAppTextStyle(16, Colors.white, true),
                ),
                color: Color(0xFFEC407A),
              )
            ]).show();
      } catch (error) {
        showSnackBar(error.message, context);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  int calculateBMR() {
    Map map = {
      'Sedentary': 1.2,
      'Moderately Active': 1.3,
      'Highly Active': 1.4
    };
    if (gender == "Male") {
      //(10W + 6.25H - 5A + 5) * exercise
      return ((10 * double.parse(weightController.text) +
                  6.25 * double.parse(heightController.text) -
                  5 * int.parse(ageController.text) +
                  5) *
              map[exerciseFactor])
          .toInt();
    } else {
      //(10W + 6.25H - 5A - 161) * exercise
      return ((10 * double.parse(weightController.text) +
                  6.25 * double.parse(heightController.text) -
                  5 * int.parse(ageController.text) -
                  161) *
              map[exerciseFactor])
          .toInt();
    }
  }

  int calculateCalories(int bmr) {
    //BMR - 555 per day ->-0.50 kg in 1 week
    //BMR - 278 per day ->-0.25 kg in 1 week
    if (targetPerWeek != null) {
      if (wishValue.compareTo("Lose Weight") == 0) {
        if (targetPerWeek.compareTo("0.25 kg") == 0) {
          return bmr - 278;
        } else {
          return bmr - 555;
        }
      } else if (wishValue == "Gain Weight") {
        if (targetPerWeek.compareTo("0.25 kg") == 0) {
          return bmr + 278;
        } else {
          return bmr + 555;
        }
      } else {
        return bmr;
      }
    } else {
      return bmr;
    }
  }

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
                            physics: BouncingScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: getAppTextStyle(
                                          18, Colors.grey[900], true),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: formKey,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: usernameController,
                                          decoration: inputTextFieldDecoration(
                                              "Username"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
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
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          validator: (val) {
                                            return RegExp("[A-Za-z0-9]{8,}")
                                                    .hasMatch(val)
                                                ? null
                                                : "Password must have at least 8 characters";
                                          },
                                          decoration: inputTextFieldDecoration(
                                              "Password"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: confirmPasswordController,
                                          obscureText: true,
                                          validator: (val) {
                                            String password =
                                                passwordController.text;
                                            return (val != null &&
                                                    password == val.toString())
                                                ? null
                                                : "Passwords don't match";
                                          },
                                          decoration: inputTextFieldDecoration(
                                              "Confirm Password"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: weightController,
                                          validator: (val) {
                                            return (val.isNotEmpty &&
                                                    RegExp("^[0-9]{1,3}(\.[0-9]{1}){0,1}\$")
                                                        .hasMatch(
                                                            val.toString()))
                                                ? null
                                                : "Weight must be <1000 kg. Ex: 75, 82.5";
                                          },
                                          decoration: inputTextFieldDecoration(
                                              "Weight (in kg)"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: heightController,
                                          validator: (val) {
                                            return (val.isNotEmpty &&
                                                    RegExp("^[0-9]{1,3}(\.[0-9]{1}){0,1}\$")
                                                        .hasMatch(
                                                            val.toString()))
                                                ? null
                                                : "Height must be <1000 cm. Ex: 175, 182.5";
                                          },
                                          decoration: inputTextFieldDecoration(
                                              "Height (in cm)"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: ageController,
                                          validator: (val) {
                                            return (val.isNotEmpty &&
                                                    RegExp("^[0-9]{1,2}\$")
                                                        .hasMatch(
                                                            val.toString()))
                                                ? null
                                                : "Age must be a number & <100";
                                          },
                                          decoration: inputTextFieldDecoration(
                                              "Age (in yr)"),
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                        ),
                                        SizedBox(height: 20),
                                        DropdownButton<String>(
                                          hint: Text("Gender",
                                              style: getAppTextStyle(
                                                  16, Colors.grey[700], false)),
                                          isExpanded: true,
                                          value: gender,
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                          underline: Container(
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),
                                          onChanged: (String newValue) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            setState(() {
                                              gender = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'Male',
                                            'Female',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 20),
                                        DropdownButton<String>(
                                          hint: Text("What do you wish to do?",
                                              style: getAppTextStyle(
                                                  16, Colors.grey[700], false)),
                                          isExpanded: true,
                                          value: wishValue,
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                          underline: Container(
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),
                                          onChanged: (String newValue) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            setState(() {
                                              wishValue = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'Lose Weight',
                                            'Maintain Weight',
                                            'Gain Weight',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),

                                        (wishValue != null &&
                                                wishValue != "Maintain Weight")
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        targetWeightController,
                                                    validator: (val) {
                                                      return (val.isNotEmpty &&
                                                              RegExp("^[0-9]{1,3}\$")
                                                                  .hasMatch(val
                                                                      .toString()))
                                                          ? null
                                                          : "Weight must be a number & <1000 kg";
                                                    },
                                                    decoration:
                                                        inputTextFieldDecoration(
                                                            "Target weight (in kg)"),
                                                    style: getAppTextStyle(
                                                        16,
                                                        Colors.grey[900],
                                                        false),
                                                  ),
                                                  SizedBox(height: 20),
                                                  DropdownButton<String>(
                                                    hint: Text("Weekly Target",
                                                        style: getAppTextStyle(
                                                            16,
                                                            Colors.grey[700],
                                                            false)),
                                                    isExpanded: true,
                                                    value: targetPerWeek,
                                                    style: getAppTextStyle(
                                                        16,
                                                        Colors.grey[900],
                                                        false),
                                                    underline: Container(
                                                      height: 1,
                                                      color: Colors.grey[700],
                                                    ),
                                                    onChanged:
                                                        (String newValue) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                      setState(() {
                                                        targetPerWeek =
                                                            newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      '0.25 kg',
                                                      '0.50 kg',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  )
                                                ],
                                              )
                                            : (SizedBox(height: 0)),
                                        SizedBox(height: 20),

                                        DropdownButton<String>(
                                          hint: Text("Select your lifestyle",
                                              style: getAppTextStyle(
                                                  16, Colors.grey[700], false)),
                                          isExpanded: true,
                                          value: exerciseFactor,
                                          style: getAppTextStyle(
                                              16, Colors.grey[900], false),
                                          underline: Container(
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),
                                          onChanged: (String newValue) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            setState(() {
                                              exerciseFactor = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'Sedentary',
                                            'Moderately Active',
                                            'Highly Active',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),

                                        SizedBox(height: 30),
                                        //Sign In
                                        ButtonTheme(
                                          minWidth: 160,
                                          height: 40,
                                          child: BottomButton(
                                            buttonTitle: "Sign Up",
                                            onTap: () {
                                              addNewUser(context);
                                            },
                                          ),
                                        ),

                                        (isLoading)
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                alignment: Alignment.center,
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))))
                                            : SizedBox(height: 30),

                                        //Create an account
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Already have an account?",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 16,
                                                    fontFamily: "Poppins"),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              anotherAnimation) {
                                                            return SignInView();
                                                          },
                                                          transitionDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      300),
                                                          transitionsBuilder:
                                                              (context,
                                                                  animation,
                                                                  anotherAnimation,
                                                                  child) {
                                                            return SlideTransition(
                                                              position: Tween(
                                                                      begin: Offset(
                                                                          1.0,
                                                                          0.0),
                                                                      end: Offset(
                                                                          0.0,
                                                                          0.0))
                                                                  .animate(
                                                                      animation),
                                                              child: child,
                                                            );
                                                          }));
                                                },
                                                child: Text(
                                                  "Sign In.",
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
                                  ),
                                ),
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
