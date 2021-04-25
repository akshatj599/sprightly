import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class ShowFoodDetailsView extends StatefulWidget {
  Map currItemMap;
  String currItemName;
  List<dynamic> nutrientList;
  Map<String, double> nutrientMap;
  String foodCategory;
  bool fromSearchFoodView; //true -> searchFoodView, false -> diary
  String weight;
  String dt;

  ShowFoodDetailsView(this.currItemMap, this.foodCategory,
      this.fromSearchFoodView, this.weight, this.dt) {
    currItemName = capitalizeEachWord(currItemMap['description'], true);
    nutrientList = currItemMap['foodNutrients'];
    String calories = "0";
    double caloriesValue = 0.0;
    String carbs = "0";
    double carbsValue = 0.0;
    String fat = "0";
    double fatValue = 0.0;
    String protein = "0";
    double proteinValue = 0.0;
    nutrientList.forEach((element) {
      if (element['nutrientName'] == "Energy") {
        calories = element['value'].toString() +
            " " +
            element['unitName'].toString().toLowerCase();
        caloriesValue = element['value'] + 0.0;
      } else if (element['nutrientName'] == "Carbohydrate, by difference") {
        carbs = element['value'].toString() +
            " " +
            element['unitName'].toString().toLowerCase();
        carbsValue = element['value'] + 0.0;
      } else if (element['nutrientName'] == "Total lipid (fat)") {
        fat = element['value'].toString() +
            " " +
            element['unitName'].toString().toLowerCase();
        fatValue = element['value'] + 0.0;
      } else if (element['nutrientName'] == "Protein") {
        protein = element['value'].toString() +
            " " +
            element['unitName'].toString().toLowerCase();
        proteinValue = element['value'] + 0.0;
      }
    });
    nutrientMap = {
      "Calories: " + calories: caloriesValue,
      "Carbs: " + carbs: carbsValue,
      "Fat: " + fat: fatValue,
      "Protein: " + protein: proteinValue,
    };
  }

  @override
  _ShowFoodDetailsViewState createState() => _ShowFoodDetailsViewState();
}

class _ShowFoodDetailsViewState extends State<ShowFoodDetailsView> {
  TextEditingController quantityController = TextEditingController();
  bool flag = true;

  Future<void> addFoodItemToDiaryFB() async {
    if (RegExp("^[0-9]{0,5}(\.[0-9]{1}){0,1}\$")
        .hasMatch(quantityController.text)) {
      double finalWeight;
      if (quantityController.text.isNotEmpty) {
        finalWeight = double.parse(quantityController.text);
      } else {
        finalWeight = 100.0;
      }
      widget.currItemMap["Weight"] = finalWeight;
      double calories = 0;
      widget.currItemMap['foodNutrients'].forEach((value) {
        if (value['nutrientName'] == "Energy") {
          calories = double.parse(value['value'].toString());
        }
      });
      calories = (calories * (finalWeight / 100));
      widget.currItemMap["Total Energy"] =
          double.parse(calories.toStringAsFixed(1));
      FirebaseFirestore fb = FirebaseFirestore.instance;
      await fb
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.email)
          .update({
        'Diary.' +
            widget.dt +
            '.' +
            widget.foodCategory +
            '.' +
            widget.currItemName: widget.currItemMap
      });
      showSnackBar(
          "Item Added / Updated: " +
              widget.currItemName +
              " - " +
              finalWeight.toString() +
              "g",
          context);
    } else
      showSnackBar("Please enter a valid weight", context);
  }

  @override
  Widget build(BuildContext context) {
    if (flag && !widget.fromSearchFoodView) {
      flag = false;
      quantityController.text = widget.weight;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
          child: Scaffold(
              backgroundColor: glb.main_scaffold_background,
              appBar: glb.appBar_Sprightly(() {
                setState(() {
                  glb.switchTheme();
                });
              }),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: glb.main_secondary),
                          child: (!widget.fromSearchFoodView)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.currItemName,
                                        style: getAppTextStyle(
                                            18, Colors.black, true)),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          Alert(
                                            onWillPopActive: true,
                                            style: AlertStyle(
                                                titleStyle: getAppTextStyle(
                                                    18, Colors.black, true),
                                                descStyle: getAppTextStyle(16,
                                                    Colors.grey[800], true)),
                                            context: context,
                                            type: AlertType.warning,
                                            title: "Are you sure?",
                                            desc:
                                                "This item will be deleted from your diary",
                                            buttons: [
                                              DialogButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: getAppTextStyle(16,
                                                        Colors.white, false),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  color: Colors.grey),
                                              DialogButton(
                                                child: Text(
                                                  "Delete",
                                                  style: getAppTextStyle(
                                                      16, Colors.white, false),
                                                ),
                                                color: Color(0xFFEC407A),
                                                onPressed: () async {
                                                  FirebaseFirestore fb =
                                                      FirebaseFirestore
                                                          .instance;
                                                  await fb
                                                      .collection('Users')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser.email)
                                                      .update({
                                                    'Diary.' +
                                                            widget.dt +
                                                            '.' +
                                                            widget.foodCategory +
                                                            '.' +
                                                            widget.currItemName:
                                                        FieldValue.delete()
                                                  });
                                                  showSnackBar(
                                                      "Item Deleted: " +
                                                          widget.currItemName,
                                                      context);
                                                  glb.diary_runFbFunc = true;
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ).show();
                                        })
                                  ],
                                )
                              : Text(widget.currItemName,
                                  style:
                                      getAppTextStyle(18, Colors.black, true)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: glb.main_background),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Serving",
                                  style: getAppTextStyle(
                                      16, glb.main_foreground_header, false)),
                              Text("100 g",
                                  style: getAppTextStyle(
                                      16, glb.main_foreground_dimmer, false))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: glb.main_background),
                          child: PieChart(
                            dataMap: widget.nutrientMap,
                            chartType: ChartType.ring,
                            animationDuration: Duration(milliseconds: 2000),
                            initialAngleInDegree: 0,
                            colorList: [
                              Color(0xFF74b9ff),
                              Color(0xFF55efc4),
                              Color(0xFFff7675),
                              Color(0xFFffeaa7),
                            ],
                            chartRadius: MediaQuery.of(context).size.width / 4,
                            chartValuesOptions:
                                ChartValuesOptions(showChartValues: false),
                            legendOptions: LegendOptions(
                                legendTextStyle: getAppTextStyle(
                                    14,
                                    glb.dark_theme
                                        ? glb.main_foreground_header
                                        : glb.main_foreground_dimmer,
                                    false)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: glb.main_background),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      controller: quantityController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          hintText: 'Weight',
                                          hintStyle: getAppTextStyle(
                                              16, Colors.grey[700], false),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 1),
                                          )),
                                    ),
                                  ),
                                  Text("  grams",
                                      style: getAppTextStyle(16,
                                          glb.main_foreground_header, false)),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  addFoodItemToDiaryFB();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10.0),
                                    child: Text(
                                        (widget.fromSearchFoodView)
                                            ? "Add"
                                            : "Update",
                                        style: getAppTextStyle(
                                            16, Colors.white, false))),
                              ),
                            ],
                          ),
                        ),
                        makeNutrientListColumn(context)
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  Column makeNutrientListColumn(BuildContext context) {
    List<Container> ls = [];
    widget.nutrientList.forEach((element) {
      ls.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: glb.main_background),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(capitalizeEachWord(element['nutrientName'], false),
                  style:
                      getAppTextStyle(16, glb.main_foreground_header, false)),
            ),
            Text(
                element['value'].toString() +
                    " " +
                    element['unitName'].toString().toLowerCase(),
                style: getAppTextStyle(16, glb.main_foreground_dimmer, false))
          ],
        ),
      ));
    });
    return Column(children: ls);
  }
}
