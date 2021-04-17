import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/views/Diary_showFoodDetailsView.dart';
import 'package:http/http.dart' as http;
import 'package:sprightly/widgets/globals.dart' as glb;

class SearchExerciseView extends StatefulWidget {
  @override
  _SearchExerciseViewState createState() => _SearchExerciseViewState();
}

class _SearchExerciseViewState extends State<SearchExerciseView> {
  List<dynamic> initialItems = [];
  List<Widget> finalItems = [];
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController calorieEditingController = TextEditingController();
  String searchItem;
  bool isLoading = false;
  bool initialState = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: glb.main_background,
          appBar: glb.appBar_Sprightly(() {
            setState(() {
              glb.switchTheme();
            });
          }),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  children: [
                    Center(
                      child: Text("Add An Exercise",
                          style: getAppTextStyle(
                              20, glb.main_foreground_header, true)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: searchEditingController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: InputBorder.none,
                                  hintText: 'Exercise Name',
                                  hintStyle: getAppTextStyle(
                                      16, Colors.grey[700], false))),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                              controller: calorieEditingController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: InputBorder.none,
                                  hintText: 'Calories',
                                  hintStyle: getAppTextStyle(
                                      16, Colors.grey[700], false))),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        initialState = false;
                        searchItem = searchEditingController.text;
                        if (searchItem.isEmpty) {
                          setState(() {
                            initialState = true;
                          });
                        } else {
                          //TODO: Add exercise to FB
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        child: Text("Add to your diary", style: getAppTextStyle(16, Colors.white, false),),
                      ),
                    ),
                    SizedBox(height: 20),
                    (isLoading == true)
                        ? Center(
                            child: Column(children: [
                              SizedBox(height: 40),
                              CircularProgressIndicator()
                            ]),
                          )
                        : (initialState == true)
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 40),
                                    Icon(
                                      Icons.add_circle_rounded,
                                      color: glb.main_foreground_dimmer,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "Which exercise made those calories burn?",
                                      style: getAppTextStyle(14,
                                          glb.main_foreground_dimmer, false),
                                    ),
                                    SizedBox(height: 2),
                                    Text("Add its details here.",
                                        style: getAppTextStyle(14,
                                            glb.main_foreground_dimmer, false))
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: finalItems.length,
                                    itemBuilder: (context, index) {
                                      return (index != 0 && index != 1)
                                          ? GestureDetector(
                                              onTap: () async {
                                                await Navigator.of(context)
                                                    .push(PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation,
                                                            anotherAnimation) {
                                                          return ShowFoodDetailsView(
                                                              index - 2,
                                                              initialItems);
                                                        },
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        transitionsBuilder:
                                                            (context,
                                                                animation,
                                                                anotherAnimation,
                                                                child) {
                                                          return SlideTransition(
                                                            position: Tween(
                                                                    begin:
                                                                        Offset(
                                                                            1.0,
                                                                            0.0),
                                                                    end: Offset(
                                                                        0.0,
                                                                        0.0))
                                                                .animate(
                                                                    animation),
                                                            child: child,
                                                          );
                                                        }))
                                                    .then((value) {
                                                  glb.bnb.onTap(
                                                      glb.bnb.currentIndex);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: glb.main_secondary),
                                                child: finalItems[index],
                                              ),
                                            )
                                          : (index == 0
                                              ? Text(" Results (per 100 g):",
                                                  style: getAppTextStyle(
                                                      18,
                                                      glb.main_foreground_header,
                                                      true))
                                              : finalItems[index]);
                                    }),
                              )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

//API Key:  sqLi8eWjX2iVjNW1X2GZC3fnJJqoKLbVsiCdYI5F
