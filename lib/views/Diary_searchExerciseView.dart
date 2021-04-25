import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class SearchExerciseView extends StatefulWidget {
  String dt;

  SearchExerciseView(this.dt);
  @override
  _SearchExerciseViewState createState() => _SearchExerciseViewState();
}

class _SearchExerciseViewState extends State<SearchExerciseView> {
  List<dynamic> initialItems = [];
  List<Widget> finalItems = [];
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController calorieEditingController = TextEditingController();
  String searchItem;
  bool isLoading = false;
  bool initialState = true;

  Future<void> addExerciseItemToDiaryFB() async {
    if (exerciseNameController.text.isNotEmpty &&
        calorieEditingController.text.isNotEmpty) {
      if (RegExp("^[0-9]+(\.[0-9]{1}){0,1}\$")
          .hasMatch(calorieEditingController.text)) {
        FirebaseFirestore fb = FirebaseFirestore.instance;
        await fb
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.email)
            .update({
          'Diary.' +
                  widget.dt +
                  '.' +
                  "Exercise" +
                  '.' +
                  exerciseNameController.text:
              double.parse(calorieEditingController.text)
        });
        showSnackBar(
            "Exercise Added / Updated: " +
                exerciseNameController.text +
                " - " +
                calorieEditingController.text + " kcal",
            context);
      } else {
        showSnackBar("Please enter a valid calorie count", context);
      }
    } else
      showSnackBar("One or more fields are empty", context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: Scaffold(
            backgroundColor: glb.main_background,
            appBar: glb.appBar_Sprightly(() {
              setState(() {
                glb.switchTheme();
              });
            }),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Center(
                        child: Text("Add An Exercise",
                            style: getAppTextStyle(
                                20, glb.main_foreground_header, true)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                                controller: exerciseNameController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: InputBorder.none,
                                    hintText: 'Exercise Name',
                                    hintStyle: getAppTextStyle(
                                        16, Colors.grey[700], false))),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: TextField(
                                controller: calorieEditingController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: InputBorder.none,
                                    hintText: 'Calories',
                                    hintStyle: getAppTextStyle(
                                        16, Colors.grey[700], false))),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          initialState = false;
                          searchItem = exerciseNameController.text;
                          if (searchItem.isEmpty) {
                            setState(() {
                              initialState = true;
                            });
                          } else {
                            addExerciseItemToDiaryFB();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20),
                          child: Text(
                            "Add to your diary",
                            style: getAppTextStyle(16, Colors.white, false),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Icon(
                              Icons.add_circle_rounded,
                              color: glb.main_foreground_dimmer,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Which exercise made those calories burn?",
                              style: getAppTextStyle(
                                  14, glb.main_foreground_dimmer, false),
                            ),
                            SizedBox(height: 2),
                            Text("Add its details here.",
                                style: getAppTextStyle(
                                    14, glb.main_foreground_dimmer, false))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
