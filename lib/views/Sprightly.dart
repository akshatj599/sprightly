import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/views/Account_main.dart';
import 'package:sprightly/views/Diary_main.dart';
import 'package:sprightly/views/Home_main.dart';
import 'package:sprightly/views/Recipe_main.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SprightlyHome extends StatefulWidget {
  bool newUserCreated;

  SprightlyHome(this.newUserCreated);

  @override
  _SprightlyHomeState createState() => _SprightlyHomeState();
}

class _SprightlyHomeState extends State<SprightlyHome> {
  int _navigationBarCurrIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget changeView() {
    Widget newPage;
    if (_navigationBarCurrIndex == 0) {
      newPage = Home();
    } else if (_navigationBarCurrIndex == 1) {
      glb.diary_runFbFunc = true;
      newPage = Diary();
    } else if (_navigationBarCurrIndex == 2) {
      newPage = Recipe();
    } else if (_navigationBarCurrIndex == 3) {
      newPage = Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: glb.main_foreground_dimmer,
            size: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Under Construction",
            style: getAppTextStyle(16, glb.main_foreground_dimmer, false),
          ),
        ],
      ));
    } else {
      newPage = AccountView();
    }
    return Container(child: newPage);
  }

  @override
  Widget build(BuildContext context) {
    glb.bnb = BottomNavigationBar(
      selectedLabelStyle: getAppTextStyle(12, Colors.orange[400], true),
      unselectedLabelStyle: getAppTextStyle(12, Colors.white, false),
      currentIndex: _navigationBarCurrIndex,
      onTap: (index) {
        setState(() {
          _navigationBarCurrIndex = index;
          glb.counter = 0;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff232d37),
      selectedItemColor: Colors.orange[400],
      unselectedItemColor: Colors.white,
      iconSize: 25,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined), label: "Diary"),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage_outlined), label: "Recipes"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Plans"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined), label: "Account"),
      ],
    );

    var container = Container(
      child: Scaffold(
          backgroundColor: glb.main_scaffold_background,
          appBar: glb.appBar_Sprightly(() {
            setState(() {
              glb.switchTheme();
            });
          }),
          body: SafeArea(
            child: changeView(),
          ),
          bottomNavigationBar: glb.bnb),
    );
    if (widget.newUserCreated) {
      widget.newUserCreated = false;
      Future.delayed(Duration(seconds: 3), () {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Registration Successful",
            textStyle: getAppTextStyle(16, Colors.white, true),
          ),
          displayDuration: Duration(seconds: 1),
        );
      });
    }
    return container;
  }
}
