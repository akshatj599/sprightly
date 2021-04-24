import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprightly/views/Recipe_main.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:date_format/date_format.dart';

Future<void> getUserDetailsFromFB() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser.email)
      .get();
      
    // Setting global currentUserDetails
    glb.currentUserDetails = doc['Details'];
    glb.currentUserDetails['Email'] = doc.id;

    //Setting global goal, foodCaloriesToday & exerciseCaloriesToday
    Map<String, dynamic> diaryForToday = doc['Diary']
        [formatDate(DateTime.now(), [D, ', ', M, ' ', dd, ' \'', yy])];
    glb.goal = doc['Details']['Target Calories'];

    double foodCaloriesToday = 0;
    double exerciseCaloriesToday = 0;

    if (diaryForToday != null) {
      diaryForToday.forEach((categoryName, categoryMap) {
        if (categoryName != "Exercise") {
          categoryMap.forEach((dishName, dishMap) {
            foodCaloriesToday += dishMap["Total Energy"];
          });
        } else {
          categoryMap.forEach((exerciseName, exerciseCalories) {
            exerciseCaloriesToday += exerciseCalories;
          });
        }
      });
    }
    glb.foodCaloriesToday = foodCaloriesToday;
    glb.exerciseCaloriesToday = exerciseCaloriesToday;

    //Setting global chartMap
    glb.chartMapList = [];
    for (int i = -6; i <= 0; i++) {
      foodCaloriesToday = 0;
      exerciseCaloriesToday = 0;
      String todayMinusi = formatDate(DateTime.now().add(Duration(days: i)),
          [D, ', ', M, ' ', dd, ' \'', yy]);
      String day = formatDate(DateTime.now().add(Duration(days: i)), [D]);
      Map<String, dynamic> diaryForTodayMinusi = doc['Diary'][todayMinusi];

      if (diaryForTodayMinusi != null) {
        diaryForTodayMinusi.forEach((categoryName, categoryMap) {
          if (categoryName != "Exercise") {
            categoryMap.forEach((dishName, dishMap) {
              foodCaloriesToday += dishMap["Total Energy"];
            });
          } else {
            categoryMap.forEach((exerciseName, exerciseCalories) {
              exerciseCaloriesToday += exerciseCalories;
            });
          }
        });
        double finalCaloriesToday = foodCaloriesToday - exerciseCaloriesToday;
        if (finalCaloriesToday < 0) {
          finalCaloriesToday = 0;
        }
        else if (finalCaloriesToday > 4000) {
          finalCaloriesToday = 4000;
        }
        String day = formatDate(DateTime.now().add(Duration(days: i)), [D]);
        glb.chartMapList.add({day: finalCaloriesToday});
      } else {
        glb.chartMapList.add({day: 0});
      }
    }

    // glb.chartMapList.forEach((map) {
    //   map.forEach((key, value) {
    //     print(key + " : " + value.toString());
    //   });
    // });
}
