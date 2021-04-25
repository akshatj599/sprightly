import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/views/Diary_searchExerciseView.dart';
import 'package:sprightly/views/Diary_searchFoodView.dart';
import 'package:sprightly/views/Diary_showFoodDetailsView.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

Column getDiaryFoodMealCard(
    String mealName, double calories, Map<String, dynamic> mealMap, String dt) {
  List<Widget> ls = [
    GestureDetector(
        onTap: () async {
          await Navigator.of(glb.context)
              .push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return SearchFoodView(mealName, dt);
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
                  }))
              .then((value) {
            glb.bnb.onTap(glb.bnb.currentIndex);
          });
        },
        child:
            Text("+ Add Food", style: getAppTextStyle(16, Colors.black, false)))
  ];
  List<Widget> finalList = makeList(ls, mealName, mealMap, dt);
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
            Text(calories.toString() + " kcal",
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

Column getDiaryExerciseMealCard(
    double calories, Map<String, dynamic> exerciseMap, String dt) {
  List<Widget> ls = [
    GestureDetector(
        onTap: () async {
          await Navigator.of(glb.context)
              .push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return SearchExerciseView(dt);
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
                  }))
              .then((value) {
            glb.bnb.onTap(glb.bnb.currentIndex);
          });
        },
        child: Text("+ Add Exercise",
            style: getAppTextStyle(16, Colors.black, false)))
  ];
  List<Widget> finalList = makeListForExercise(ls, exerciseMap);
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
            Text(calories.toString() + " kcal",
                style: getAppTextStyle(16, glb.main_foreground_header, false))
          ],
        ),
      ),
      Container(
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

List<Widget> makeList(
    List<Widget> ls, String mealName, Map<String, dynamic> mealMap, String dt) {
  //Items
  mealMap.forEach((key, value) {
    ls.add(Divider(
      color: Colors.grey[700],
    ));
    ls.add(GestureDetector(
      onTap: () async {
        await Navigator.of(glb.context).push(PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return ShowFoodDetailsView(mealMap[key], mealName, false,
                  mealMap[key]["Weight"].toString(), dt);
            },
            transitionDuration: Duration(milliseconds: 150),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
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
          Container(
              width: MediaQuery.of(glb.context).size.width / 2,
              child: Text(
                key,
                style: getAppTextStyle(16, Colors.black, false),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          Text(mealMap[key]["Total Energy"].toString() + " kcal",
              style: getAppTextStyle(16, Colors.black, false)),
        ],
      ),
    ));
  });
  return ls;
}

List<Widget> makeListForExercise(
    List<Widget> ls, Map<String, dynamic> exerciseMap) {
  //Items
  exerciseMap.forEach((key, value) {
    ls.add(Divider(
      color: Colors.grey[700],
    ));
    ls.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(glb.context).size.width / 2,
          child: Text(key,
              style: getAppTextStyle(16, Colors.black, false),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
        Text(value.toString() + " kcal",
            style: getAppTextStyle(16, Colors.black, false)),
      ],
    ));
  });
  return ls;
}
