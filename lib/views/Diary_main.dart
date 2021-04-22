import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:date_format/date_format.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/diaryMealCard.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DateTime curr;
  var dt;
  bool isLoading = true;
  int counter = 0;
  int breakfastCalories = 0;
  int lunchCalories = 0;
  int dinnerCalories = 0;
  int snacksCalories = 0;
  int exerciseCalories = 0;
  Map<String, dynamic> breakfastMap = {};
  Map<String, dynamic> lunchMap = {};
  Map<String, dynamic> dinnerMap = {};
  Map<String, dynamic> snackMap = {};

  Future<void> getDiaryFromFB() async {
    print("in function");
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();

    Map<String, dynamic> dtDiary = doc.data()['Diary'][formatDate(curr, [D, ', ', M, ' ', dd, ' \'', yy])];
    print(dt.toString());
    if (dtDiary != null) {
      print("Entering here");
      if (dtDiary["Breakfast"] != null) breakfastMap = dtDiary["Breakfast"];
      if (dtDiary["Lunch"] != null) lunchMap = dtDiary["Lunch"];
      if (dtDiary["Dinner"] != null) dinnerMap = dtDiary["Dinner"];
      if (dtDiary["Snack"] != null) snackMap = dtDiary["Snack"];
    }
    setState(() {
      isLoading = false;
    });
  }

  void changeDate() {
    curr = DateTime.now().add(Duration(days: counter));
    if (counter == 0)
      dt = 'Today';
    else if (counter == 1)
      dt = 'Tomorrow';
    else if (counter == -1)
      dt = 'Yesterday';
    else
      dt = formatDate(curr, [D, ', ', M, ' ', dd, ' \'', yy]);
  }

  @override
  Widget build(BuildContext context) {
    changeDate();
    if (glb.diary_runFbFunc) {
      glb.diary_runFbFunc = false;
      getDiaryFromFB();
    }
    return Column(
      children: [
        Container(
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
          width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      counter--;
                    });
                  },
                  child: Text("<",
                      style: getAppTextStyle(16, Colors.red[400], false))),
              Text(dt,
                  style:
                      getAppTextStyle(16, glb.main_foreground_header, false)),
              TextButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  child: Text(">",
                      style: getAppTextStyle(16, Colors.red[400], false)))
            ],
          ),
        ),
        CaloriesRemaining(),
        SizedBox(height: 10),
        isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      getDiaryFoodMealCard(
                          "Breakfast", breakfastCalories, breakfastMap),
                      getDiaryFoodMealCard("Lunch", lunchCalories, lunchMap),
                      getDiaryFoodMealCard("Dinner", dinnerCalories, dinnerMap),
                      getDiaryFoodMealCard("Snack", snacksCalories, snackMap),
                      getDiaryExerciseMealCard(exerciseCalories),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
