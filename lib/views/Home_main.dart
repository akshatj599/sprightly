import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/screens/input_page.dart';
import 'package:sprightly/backend/backend.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  bool runFn = true;

  _HomeState() {
    print("Constructor of Home called "+runFn.toString());

  }

  Future<void> fnInitial() async {
    setState(() {
      isLoading = true;
    });
    await getUserDetailsFromFB();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (runFn) {
      runFn = false;
      fnInitial();
    }

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))))
        : Column(
            children: [
              CaloriesRemaining(glb.goal, glb.foodCaloriesToday.round(),
                  glb.exerciseCaloriesToday.round()),
              Divider(
                color: Colors.grey[800],
                endIndent: 20,
                indent: 20,
              ),
              InputPage() //BMI
            ],
          );
  }
}
