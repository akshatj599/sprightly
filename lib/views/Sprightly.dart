import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/views/Home_main.dart';
import 'package:sprightly/views/Diary_main.dart';
import 'package:sprightly/widgets/globals.dart' as globals;

class SprightlyHome extends StatefulWidget {
  @override
  _SprightlyHomeState createState() => _SprightlyHomeState();
}

class _SprightlyHomeState extends State<SprightlyHome> {
  int _navigationBarCurrIndex = 0;

  Widget changeView() {
    if (_navigationBarCurrIndex == 0) {
      return Container(child: Home());
    } else if (_navigationBarCurrIndex == 1) {
      return Container(child: Diary());
    } else if (_navigationBarCurrIndex == 2) {
      return Container(child: Text("Recipes"));
    } else if (_navigationBarCurrIndex == 3) {
      return Container(child: Text("Plans"));
    } else if (_navigationBarCurrIndex == 4) {
      return Container(child: Text("Account"));
    }
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          title: Image.asset('images/sprightly_logo.png', height: 40),
          centerTitle: true,
        ),
        body: SafeArea(
          child: changeView(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: getAppTextStyle(12, Colors.orange[400], true),
          unselectedLabelStyle: getAppTextStyle(12, Colors.white, false),
          currentIndex: _navigationBarCurrIndex,
          onTap: (index) {
            setState(() {
              _navigationBarCurrIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.orange[400],
          unselectedItemColor: Colors.white,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: "Diary"),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_food_beverage_outlined),
                label: "Recipes"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Plans"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined), label: "Account"),
          ],
        ),
      ),
    );
    globals.context = context;
    return container;
  }
}