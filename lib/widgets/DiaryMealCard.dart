import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/views/Diary_showFoodDetailsView.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/views/Diary_searchFoodView.dart';
import 'package:sprightly/views/Diary_searchExerciseView.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

Column getDiaryFoodMealCard(
    String mealName, int calories, Map<String, dynamic> mealMap) {
  List<Widget> finalList = makeList(mealName, mealMap);
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mealName,
              style: getAppTextStyle(16, glb.main_foreground_header, false),
            ),
            Text(calories.toString(),
                style: getAppTextStyle(16, glb.main_foreground_header, false))
          ],
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          color: glb.main_secondary,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: finalList,
        ),
      )
    ],
  );
}

Column getDiaryExerciseMealCard(int calories) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Exercise",
              style: getAppTextStyle(16, glb.main_foreground_header, false),
            ),
            Text(calories.toString(),
                style: getAppTextStyle(16, glb.main_foreground_header, false))
          ],
        ),
      ),
      GestureDetector(
        onTap: () async {
          await Navigator.of(glb.context)
              .push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return SearchExerciseView();
                  },
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    return SlideTransition(
                      position:
                          Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation),
                      child: child,
                    );
                  }))
              .then((value) {
            glb.bnb.onTap(glb.bnb.currentIndex);
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: glb.main_secondary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                // spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Text("+ Add Exercise",
              style: getAppTextStyle(16, Colors.black, false)),
        ),
      )
    ],
  );
}

List<Widget> makeList(String mealName, Map<String, dynamic> mealMap) {
  List<Widget> ls = [
    GestureDetector(
        onTap: () async {
          await Navigator.of(glb.context)
              .push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return SearchFoodView(mealName);
                  },
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    return SlideTransition(
                      position:
                          Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation),
                      child: child,
                    );
                  }))
              .then((value) {
            glb.bnb.onTap(glb.bnb.currentIndex);
          });
        },
        child:
            Text("+ Add Food", style: getAppTextStyle(16, Colors.black, false)))
  ];

  //Items
  mealMap.forEach((key, value) {    
  ls.add(Divider(color: Colors.grey[700],));
    double calories =
        double.parse(value['foodNutrients'][3]['value'].toString());
    calories = (calories * (value['Weight'] / 100)).roundToDouble();
    ls.add(GestureDetector(
      onTap: () async {
        await Navigator.of(glb.context)
            .push(PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return ShowFoodDetailsView(mealMap[key], mealName, false, mealMap[key]["Weight"].toString());
                },
                transitionDuration: Duration(milliseconds: 300),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  );
                }))
            .then((value) {
          glb.bnb.onTap(glb.bnb.currentIndex);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: getAppTextStyle(16, Colors.black, false)),
          Text(calories.toStringAsFixed(1)+" kcal",
              style: getAppTextStyle(16, Colors.black, false)),
        ],
      ),
    ));
  });
  return ls;
}
