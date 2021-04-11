import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';

class SprightlyHome extends StatefulWidget {
  @override
  _SprightlyHomeState createState() => _SprightlyHomeState();
}

class _SprightlyHomeState extends State<SprightlyHome> {
  int _navigationBarCurrIndex = 0;

  Column changeView() {
    List<Widget> list;
    if(_navigationBarCurrIndex==0){
      list= [CaloriesRemaining(), Text("Home")];
    } else if (_navigationBarCurrIndex==1){
      list= [Text("Diary")];
    }else if (_navigationBarCurrIndex==2){
      list= [Text("Recipes")];
    }else if (_navigationBarCurrIndex==3){
      list= [Text("Plans")];
    }else if (_navigationBarCurrIndex==4){
      list= [Text("Account")];
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          title: Image.asset('images/sprightly_logo.png', height: 40),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: changeView(),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
  }
}
