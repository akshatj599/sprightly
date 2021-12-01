import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
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
              "What do you wish to read?",
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
                            height: 70,
                            width: 70,
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
                Expanded(
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
                            height: 70,
                            width: 70,
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
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/food.png',
                            height: 70,
                            width: 70,
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
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(5, 5, 10, 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/sports.png',
                            height: 70,
                            width: 70,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
