import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sprightly/views/Library_API.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:sprightly/backend/keys.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  double size = 80;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 15,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(
              "What do you wish to read about?",
              style: getAppTextStyle(16, glb.main_foreground_header, true),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: glb.main_background),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Health",
                            Image.asset(
                              'images/healthcare.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/healthcare.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Health",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Fitness",
                            Image.asset(
                              'images/fitness.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/fitness.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Fitness",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Food",
                            Image.asset(
                              'images/food.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/food.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Food",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Sports",
                            Image.asset(
                              'images/sports.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/sports.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sports",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Yoga",
                            Image.asset(
                              'images/yoga.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/yoga.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Yoga",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LibraryAPI(
                            "Covid",
                            Image.asset(
                              'images/covid.png',
                            ),
                          ),
                        ),
                      ).then((value) {
                        glb.bnb.onTap(glb.bnb.currentIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/covid.png',
                              height: size,
                              width: size,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "COVID-19",
                              style: getAppTextStyle(
                                  16, glb.main_foreground_header, true),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: glb.main_background,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
