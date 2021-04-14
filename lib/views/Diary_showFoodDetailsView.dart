import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class ShowFoodDetailsView extends StatelessWidget {
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
              nutrientList[3]['value'].toString() + " "+
              nutrientList[3]['unitName'].toString().toLowerCase():
          nutrientList[3]['value'] + 0.0,
      "Carbs: " +
              nutrientList[2]['value'].toString() + " "+
              nutrientList[2]['unitName'].toString().toLowerCase():
          nutrientList[2]['value'] + 0.0,
      "Fat: " +
              nutrientList[1]['value'].toString() + " "+
              nutrientList[1]['unitName'].toString().toLowerCase():
          nutrientList[1]['value'] + 0.0,
      "Protein: " +
              nutrientList[0]['value'].toString() + " "+
              nutrientList[0]['unitName'].toString().toLowerCase():
          nutrientList[0]['value'] + 0.0,
    };
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange[50]),
                        child: Text(currItemName,
                            style: getAppTextStyle(18, Colors.grey[800], true)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Serving",
                                style:
                                    getAppTextStyle(16, Colors.black, false)),
                            Text("100 g",
                                style: getAppTextStyle(
                                    16, Colors.grey[600], false))
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: PieChart(
                          dataMap: nutrientMap,
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
                              legendTextStyle:
                                  getAppTextStyle(14, Colors.grey[600], false)),
                        ),
                      ),
                      makeNutrientListColumn(context)
                    ],
                  ),
                ),
              ),
            )));
  }

  Column makeNutrientListColumn(BuildContext context) {
    List<Container> ls = [];
    nutrientList.forEach((element) {
      ls.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(capitalizeEachWord(element['nutrientName'], false),
                  style: getAppTextStyle(16, Colors.black, false)),
            ),
            Text(
                element['value'].toString() + " "+
                    element['unitName'].toString().toLowerCase(),
                style: getAppTextStyle(16, Colors.grey[600], false))
          ],
        ),
      ));
    });
    return Column(children: ls);
  }
}
