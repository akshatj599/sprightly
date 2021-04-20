import 'package:flutter/material.dart';
import 'package:sprightly/Home_BMI/screens/input_page.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CaloriesRemaining(),
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
