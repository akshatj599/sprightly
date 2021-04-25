import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sprightly/widgets/dateSwitcher.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class ExpandedCaloriesView extends StatefulWidget {
  @override
  _ExpandedCaloriesViewState createState() => _ExpandedCaloriesViewState();
}

class _ExpandedCaloriesViewState extends State<ExpandedCaloriesView> {
  DateTime curr;
  var dt;
  int counter = 0;
  bool isLoading = true;
  Map<String, double> mealMap = {};
  double breakFastCalories = 0;
  double lunchCalories = 0;
  double dinnerCalories = 0;
  double snackCalories = 0;
  double totalCalories = 0;
  int goal = 0;
  double remainingCalories = 0;
  double exerciseCalories = 0;
  DateSwitcher dateSwitcher;
  bool runFunc = true;

  _ExpandedCaloriesViewState() {
    dateSwitcher = DateSwitcher(getMealCaloriesFromFirebase);
  }

  void getMealCaloriesFromFirebase() async {
    setState(() {
      isLoading = true;
    });
    breakFastCalories = 0;
    lunchCalories = 0;
    dinnerCalories = 0;
    snackCalories = 0;
    exerciseCalories = 0;
    mealMap = {
      'Breakfast': breakFastCalories,
      "Lunch": lunchCalories,
      "Dinner": dinnerCalories,
      "Snacks": snackCalories
    };
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();
    Map<String, dynamic> dtDiary = doc.data()['Diary'][dateSwitcher.dtMain];
    print(dateSwitcher.dtMain.toString());
    if (dtDiary != null) {
      print("Entering here from CaloriesRemaining");
      if (dtDiary["Breakfast"] != null) {
        dtDiary["Breakfast"].forEach((key, value) {
          breakFastCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Lunch"] != null) {
        dtDiary["Lunch"].forEach((key, value) {
          lunchCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Dinner"] != null) {
        dtDiary["Dinner"].forEach((key, value) {
          dinnerCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Snack"] != null) {
        dtDiary["Snack"].forEach((key, value) {
          snackCalories += value["Total Energy"];
        });
      }
      if (dtDiary["Exercise"] != null) {
        dtDiary["Exercise"].forEach((key, value) {
          exerciseCalories += value;
        });
      }
    }

    goal = doc['Details']['Target Calories'];
    totalCalories =
        breakFastCalories + lunchCalories + dinnerCalories + snackCalories;
    remainingCalories = goal - totalCalories + exerciseCalories;
    if (remainingCalories < 0) {
      remainingCalories = 0;
    }
    mealMap = {
      'Breakfast': breakFastCalories,
      "Lunch": lunchCalories,
      "Dinner": dinnerCalories,
      "Snacks": snackCalories
    };
    setState(() {
      isLoading = false;
    });
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
    if (runFunc) {
      runFunc = false;
      getMealCaloriesFromFirebase();
    }
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
            dateSwitcher,
            isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))),
                  )
                : SizedBox(height: 0),
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
                  legendTextStyle: getAppTextStyle(
                      14,
                      glb.dark_theme
                          ? glb.main_foreground_header
                          : glb.main_foreground_dimmer,
                      false),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    makeCard("Breakfast", breakFastCalories.toStringAsFixed(1),
                        false, false),
                    makeCard("Lunch", lunchCalories.toStringAsFixed(1), false,
                        false),
                    makeCard("Dinner", dinnerCalories.toStringAsFixed(1), false,
                        false),
                    makeCard("Snacks", snackCalories.toStringAsFixed(1), false,
                        false),
                    makeCard("Exercise", exerciseCalories.toStringAsFixed(1),
                        false, false),
                    makeCard("Total Calories", totalCalories.toStringAsFixed(1),
                        false, false),
                    makeCard("Goal", goal.toString(), false, true),
                    makeCard("Calories Remaining",
                        remainingCalories.toStringAsFixed(1), true, true),
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
