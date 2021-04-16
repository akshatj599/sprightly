import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class ExpandedCaloriesView extends StatefulWidget {
  @override
  _ExpandedCaloriesViewState createState() => _ExpandedCaloriesViewState();
}

class _ExpandedCaloriesViewState extends State<ExpandedCaloriesView> {
  DateTime curr;
  var dt;
  int counter = 0;
  Map<String, double> mealMap;
  double breakFastCalories;
  double lunchCalories;
  double dinnerCalories;
  double snackCalories;
  double totalCalories;
  double goal;
  double remainingCalories;

  void getMealCaloriesFromFirebase() {
    //TODO: Get values from cloud
    breakFastCalories = 200;
    lunchCalories = 300;
    dinnerCalories = 100;
    snackCalories = 50;
    totalCalories =
        breakFastCalories + lunchCalories + dinnerCalories + snackCalories;
    goal = 1500;
    remainingCalories = goal - totalCalories;
    mealMap = {
      'Breakfast': breakFastCalories,
      "Lunch": lunchCalories,
      "Dinner": dinnerCalories,
      "Snacks": snackCalories
    };
  }

  void changeDate() {
    curr = DateTime.now();
    var temp = curr.add(Duration(days: counter));
    if (counter == 0)
      dt = 'Today';
    else if (counter == 1)
      dt = 'Tomorrow';
    else if (counter == -1)
      dt = 'Yesterday';
    else
      dt = formatDate(temp, [D, ', ', M, ' ', dd, ' \'', yy]);
  }

  Container makeCard(
      String title, String value, bool flag_green, bool flag_bold) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: glb.main_background),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: getAppTextStyle(16, glb.main_foreground_header, false),
            ),
            Text(
              value + " kcal",
              style: getAppTextStyle(
                  16,
                  flag_green ? Colors.green : glb.main_foreground_dimmer,
                  flag_bold ? true : false),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    getMealCaloriesFromFirebase();
    changeDate();
    return Container(
        child: Scaffold(
      backgroundColor: glb.main_scaffold_background,
      appBar: glb.appBar_Sprightly(() {
          setState(() {
            glb.switchTheme();
          });
        }),
      body: SafeArea(
        child: Column(
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
                      style: getAppTextStyle(
                          16, glb.main_foreground_header, false)),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: glb.main_background),
              child: PieChart(
                dataMap: mealMap,
                animationDuration: Duration(milliseconds: 2000),
                initialAngleInDegree: 0,
                colorList: [
                  Color(0xFF74b9ff),
                  Color(0xFF55efc4),
                  Color(0xFFff7675),
                  Color(0xFFffeaa7),
                ],
                chartRadius: MediaQuery.of(context).size.width / 2,
                chartValuesOptions: ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    chartValueStyle: getAppTextStyle(14, Colors.black, false),
                    showChartValueBackground: false),
                legendOptions: LegendOptions(
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  legendTextStyle:
                      getAppTextStyle(14, glb.main_foreground_header, false),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    makeCard("Breakfast", breakFastCalories.toString(), false,
                        false),
                    makeCard("Lunch", lunchCalories.toString(), false, false),
                    makeCard("Dinner", dinnerCalories.toString(), false, false),
                    makeCard("Snacks", snackCalories.toString(), false, false),
                    makeCard("Total Calories", totalCalories.toString(), false,
                        false),
                    makeCard("Goal", goal.toString(), false, true),
                    makeCard("Calories Remaining", remainingCalories.toString(),
                        true, true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
