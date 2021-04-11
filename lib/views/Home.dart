import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //TODO: BMI
    return Column(
      children: [
        CaloriesRemaining()
      ],
    );
  }
}
