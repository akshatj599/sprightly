import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/views/Diary_searchFoodView.dart';
import 'package:sprightly/widgets/globals.dart' as globals;

Column getDiaryMealCard(String mealName, int calories){
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          color: Colors.white,
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
              style: getAppTextStyle(16, Colors.black, false),
            ),
            Text(calories.toString(),
                style: getAppTextStyle(16, Colors.black, false))
          ],
        ),
      ),

      GestureDetector(
        onTap: (){
          Navigator.push(globals.context, MaterialPageRoute(builder: (context) => SearchFoodView(mealName)));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.orange[50],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                // spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Text("+ Add Food",
              style: getAppTextStyle(16, Colors.black, false)),
        ),
      )
    ],
  );
}