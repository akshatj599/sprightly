import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:sprightly/widgets/dateSwitcher.dart';
import 'package:sprightly/widgets/diaryMealCard.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  bool isLoading = true;
  double breakfastCalories = 0;
  double lunchCalories = 0;
  double dinnerCalories = 0;
  double snacksCalories = 0;
  double exerciseCalories = 0;
  Map<String, dynamic> breakfastMap = {};
  Map<String, dynamic> lunchMap = {};
  Map<String, dynamic> dinnerMap = {};
  Map<String, dynamic> snackMap = {};
  Map<String, dynamic> exerciseMap = {};
  int goal = 0;
  DateSwitcher dateSwitcher;


  Future<void> getDiaryFromFB() async {
    glb.diary_runFbFunc = false;
    setState(() {
      isLoading = true;
    });
    breakfastCalories = 0;
    lunchCalories = 0;
    dinnerCalories = 0;
    snacksCalories = 0;
    exerciseCalories = 0;
    breakfastMap = {};
    lunchMap = {};
    dinnerMap = {};
    snackMap = {};
    exerciseMap = {};
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();

    Map<String, dynamic> dtDiary = doc.data()['Diary'][dateSwitcher.dtMain];
    print(dateSwitcher.dtMain.toString()+" - entering here from Diary_main");
    if (dtDiary != null) {
      if (dtDiary["Breakfast"] != null) {
        breakfastMap = dtDiary["Breakfast"];
        breakfastMap.forEach((key, value) {
          breakfastCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Lunch"] != null) {
        lunchMap = dtDiary["Lunch"];
        lunchMap.forEach((key, value) {
          lunchCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Dinner"] != null) {
        dinnerMap = dtDiary["Dinner"];
        dinnerMap.forEach((key, value) {
          dinnerCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Snack"] != null) {
        snackMap = dtDiary["Snack"];
        snackMap.forEach((key, value) {
          snacksCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Exercise"] != null) {
        exerciseMap = dtDiary["Exercise"];
        exerciseMap.forEach((key, value) {
          exerciseCalories += value;
        });
      }
    }
    goal = doc.data()['Details']['Target Calories'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (glb.diary_runFbFunc) {
      glb.context = context;
      getDiaryFromFB();
    }
    dateSwitcher = DateSwitcher(getDiaryFromFB);
    return Column(
      children: [
        dateSwitcher,
        CaloriesRemaining(
            goal,
            (breakfastCalories +
                    lunchCalories +
                    dinnerCalories +
                    snacksCalories)
                .round(),
            exerciseCalories.round()),
        SizedBox(height: 10),
        isLoading
            ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A)))
            : Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      getDiaryFoodMealCard("Breakfast", breakfastCalories,
                          breakfastMap, dateSwitcher.dtMain),
                      getDiaryFoodMealCard("Lunch", lunchCalories, lunchMap,
                          dateSwitcher.dtMain),
                      getDiaryFoodMealCard("Dinner", dinnerCalories, dinnerMap,
                          dateSwitcher.dtMain),
                      getDiaryFoodMealCard("Snack", snacksCalories, snackMap,
                          dateSwitcher.dtMain),
                      getDiaryExerciseMealCard(
                          exerciseCalories, exerciseMap, dateSwitcher.dtMain),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
