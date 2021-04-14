import 'package:flutter/material.dart';
import 'package:sprightly/views/ExpandedCaloriesView.dart';
import 'package:sprightly/widgets/widgets.dart';

class CaloriesRemaining extends StatelessWidget {
  int goal;
  int food;
  int exercise;
  int remaining;

  CaloriesRemaining() {
    //TODO: Retrieve goal of user & current calories burnt (food & exercise)
    this.goal = 2000;
    this.food = 1200;
    this.exercise = 800;
    this.remaining = goal - (food + exercise);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandedCaloriesView()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
        // color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Calories Remaining",
                style: getAppTextStyle(18, Colors.grey[800], true),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text(goal.toString(),
                      style: getAppTextStyle(16, Colors.black, false)),
                  Text("Goal",
                      style: getAppTextStyle(14, Colors.grey[700], false))
                ]),
                Text("-", style: getAppTextStyle(16, Colors.black, false)),
                Column(children: [
                  Text(food.toString(),
                      style: getAppTextStyle(16, Colors.black, false)),
                  Text("Food",
                      style: getAppTextStyle(14, Colors.grey[700], false))
                ]),
                Text("+", style: getAppTextStyle(16, Colors.black, false)),
                Column(children: [
                  Text(exercise.toString(),
                      style: getAppTextStyle(16, Colors.black, false)),
                  Text("Exercise",
                      style: getAppTextStyle(14, Colors.grey[700], false))
                ]),
                Text("=", style: getAppTextStyle(16, Colors.black, false)),
                Column(children: [
                  Text(
                    remaining.toString(),
                    style: getAppTextStyle(16, Colors.green, false),
                  ),
                  Text("Remaining",
                      style: getAppTextStyle(14, Colors.grey[700], false))
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
