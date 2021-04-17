import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class ShowFoodDetailsView extends StatefulWidget {
  int currItemIndex;
  List<dynamic> initialItems;
  String currItemName;
  List<dynamic> nutrientList;
  Map<String, double> nutrientMap;

  ShowFoodDetailsView(this.currItemIndex, this.initialItems) {
    var currItemMap = this.initialItems[this.currItemIndex];
    currItemName = capitalizeEachWord(currItemMap['description'], true);
    nutrientList = currItemMap['foodNutrients'];
    nutrientMap = {
      "Calories: " +
              nutrientList[3]['value'].toString() +
              " " +
              nutrientList[3]['unitName'].toString().toLowerCase():
          nutrientList[3]['value'] + 0.0,
      "Carbs: " +
              nutrientList[2]['value'].toString() +
              " " +
              nutrientList[2]['unitName'].toString().toLowerCase():
          nutrientList[2]['value'] + 0.0,
      "Fat: " +
              nutrientList[1]['value'].toString() +
              " " +
              nutrientList[1]['unitName'].toString().toLowerCase():
          nutrientList[1]['value'] + 0.0,
      "Protein: " +
              nutrientList[0]['value'].toString() +
              " " +
              nutrientList[0]['unitName'].toString().toLowerCase():
          nutrientList[0]['value'] + 0.0,
    };
  }

  @override
  _ShowFoodDetailsViewState createState() => _ShowFoodDetailsViewState();
}

class _ShowFoodDetailsViewState extends State<ShowFoodDetailsView> {
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
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
                          child: Text(widget.currItemName,
                              style: getAppTextStyle(18, Colors.black, true)),
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
                                onPressed: () {},
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 12.0),
                                    child: Text("Add",
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
              ),
            )));
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
