import 'package:flutter/material.dart';
import 'package:sprightly/views/ExpandedCaloriesView.dart';
import 'package:sprightly/views/Sprightly.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'globals.dart' as glb;

class CaloriesRemaining extends StatefulWidget {
  int goal;
  int foodCalories;
  int exerciseCalories;
  int remainingCalories;

  CaloriesRemaining(this.goal, this.foodCalories, this.exerciseCalories) {
    this.remainingCalories = (goal - foodCalories) + exerciseCalories;
    if (this.remainingCalories < 0) {
      this.remainingCalories = 0;
    }
  }

  @override
  _CaloriesRemainingState createState() => _CaloriesRemainingState();
}

class _CaloriesRemainingState extends State<CaloriesRemaining> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context)
            .push(PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return ExpandedCaloriesView();
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
      child: Container(
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
        // color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Calories Remaining",
                style: getAppTextStyle(18, glb.main_foreground_header, true),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text(widget.goal.toString(),
                      style: getAppTextStyle(
                          16, glb.main_foreground_header, false)),
                  Text("Goal",
                      style: getAppTextStyle(
                          14, glb.main_foreground_dimmer, false))
                ]),
                Text("-",
                    style:
                        getAppTextStyle(16, glb.main_foreground_header, false)),
                Column(children: [
                  Text(widget.foodCalories.toString(),
                      style: getAppTextStyle(
                          16, glb.main_foreground_header, false)),
                  Text("Food",
                      style: getAppTextStyle(
                          14, glb.main_foreground_dimmer, false))
                ]),
                Text("+",
                    style:
                        getAppTextStyle(16, glb.main_foreground_header, false)),
                Column(children: [
                  Text(widget.exerciseCalories.toString(),
                      style: getAppTextStyle(
                          16, glb.main_foreground_header, false)),
                  Text("Exercise",
                      style: getAppTextStyle(
                          14, glb.main_foreground_dimmer, false))
                ]),
                Text("=",
                    style:
                        getAppTextStyle(16, glb.main_foreground_header, false)),
                Column(children: [
                  Text(
                    widget.remainingCalories.toString(),
                    style: getAppTextStyle(16, Colors.green, false),
                  ),
                  Text("Remaining",
                      style: getAppTextStyle(
                          14, glb.main_foreground_dimmer, false))
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
