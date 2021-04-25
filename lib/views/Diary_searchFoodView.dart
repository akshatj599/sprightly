import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sprightly/views/Diary_showFoodDetailsView.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class SearchFoodView extends StatefulWidget {
  final String mealType;
  final String dt;

  SearchFoodView(this.mealType, this.dt);

  @override
  _SearchFoodViewState createState() => _SearchFoodViewState();
}

class _SearchFoodViewState extends State<SearchFoodView> {
  List<dynamic> initialItems = [];
  List<Widget> finalItems = [];
  TextEditingController searchEditingController = TextEditingController();
  String searchItem;
  bool isLoading = false;
  bool initialState = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Add A " + widget.mealType + " Item",
                          style: getAppTextStyle(
                              20, glb.main_foreground_header, true)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              hintText: 'Search an item',
                              hintStyle:
                                  getAppTextStyle(16, Colors.grey[700], false),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            initialState = false;
                            searchItem = searchEditingController.text;
                            if (searchItem.isEmpty) {
                              setState(() {
                                initialState = true;
                              });
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              await getPostFoodDetails(context).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 0),
                            child: Icon(Icons.search),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    (isLoading == true)
                        ? Center(
                            child: Column(children: [
                              SizedBox(height: 40),
                              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A)))
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
                                      "What did you munch?",
                                      style: getAppTextStyle(14,
                                          glb.main_foreground_dimmer, false),
                                    ),
                                    SizedBox(height: 2),
                                    Text("Search for it in the search box.",
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
                                                              initialItems[
                                                                  index - 2],
                                                              widget.mealType,
                                                              true,
                                                              "100",
                                                              widget.dt);
                                                        },
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    150),
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
            )),
      ),
    );
  }

  Future getPostFoodDetails(BuildContext context) async {
    final url = Uri.parse(
        "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=sqLi8eWjX2iVjNW1X2GZC3fnJJqoKLbVsiCdYI5F");
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, String>{'query': searchItem, 'pageSize': '20'}));

    if (response.statusCode == 200) {
      initialItems = json.decode(response.body.toString())['foods'];
      List<Widget> temp = [];
      temp.add(Text(""));
      temp.add(SizedBox(height: 20));

      //loop
      for (int i = 0; i < initialItems.length; i++) {
        var currItemMap = initialItems[i];
        String currItemName =
            capitalizeEachWord(currItemMap['description'], true);

        String currItemCal = "0 kcal";
        currItemMap['foodNutrients'].forEach((value) {
          if(value['nutrientName'] == "Energy"){
            currItemCal = value['value'].toString() +" kcal";
          }
        });
        temp.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: (MediaQuery.of(context).size.width) / 2,
                child: Text(currItemName,
                    style: getAppTextStyle(16, Colors.black, false))),
            Text(currItemCal,
                style: getAppTextStyle(16, Colors.grey[600], false))
          ],
        ));
      }
      if (temp.length == 2) {
        temp = [];
        temp.add(Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Icon(
                Icons.error_rounded,
                color: glb.main_foreground_dimmer,
              ),
              SizedBox(height: 15),
              Text(
                "No results found.",
                style: getAppTextStyle(14, glb.main_foreground_dimmer, false),
              ),
            ],
          ),
        ));
      }
      setState(() {
        finalItems = temp;
      });
    } else {
      showSnackBar("An error occurred. Try again later.", context);
      print(response.statusCode);
      print(response.body);
    }
  }
}

//API Key:  sqLi8eWjX2iVjNW1X2GZC3fnJJqoKLbVsiCdYI5F
