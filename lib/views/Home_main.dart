import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/screens/input_page.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CaloriesRemaining(glb.goal, glb.foodCaloriesToday.round(), glb.exerciseCaloriesToday.round()),
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
