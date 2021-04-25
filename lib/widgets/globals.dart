library my_prj.globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BuildContext context;
BottomNavigationBar bnb;
Map<String, Map<String, Map<String, dynamic>>> allCategories =
    Map(); //For Recipes

bool dark_theme = true;
Color main_background;
Color main_foreground_header;
Color main_foreground_dimmer;
Color main_scaffold_background;
Color main_appBar;
Color main_secondary;
Map<String, dynamic> currentUserDetails = {};
List<Map<String, num>> chartMapList = [];
bool diary_runFbFunc = true;
Image backgroundImage;
int counter = 0;
bool resetCounter = true;

int goal = 0;
double foodCaloriesToday = 0;
double exerciseCaloriesToday = 0;

void switchTheme() {
  if (!dark_theme) {
    //dark colors
    dark_theme = true;
    main_background = Color(0xff232d37);
    main_foreground_header = Colors.white.withOpacity(0.8);
    main_foreground_dimmer = Colors.white.withOpacity(0.6);
    main_scaffold_background = Colors.grey[500];
    main_appBar = Colors.purple[900];
    main_secondary = Colors.deepPurple[50];
  } else {
    //light colors
    dark_theme = false;
    main_background = Colors.white;
    main_foreground_header = Colors.grey[900];
    main_foreground_dimmer = Colors.grey[700];
    main_scaffold_background = Colors.grey[350];
    main_appBar = Colors.orange[400];
    main_secondary = Colors.orange[50];
  }
}

AppBar appBar_Sprightly(Function fn) {
  return AppBar(
    backgroundColor: main_appBar,
    title: Image.asset('images/sprightly_logo.png', height: 40),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
            onTap: fn,
            child: Transform.rotate(
                angle: 7,
                child: dark_theme
                    ? Transform.scale(
                        scale: 0.8,
                        child: Icon(
                          Icons.brightness_2_outlined,
                          size: 25,
                          color: Color(0xFFEC407A),
                        ))
                    : Icon(
                        Icons.wb_sunny_outlined,
                        size: 25,
                        color: Color(0xFFEC407A),
                      ))),
      ),
    ],
  );
}
