import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/backend/backend.dart';

class LineChartSample2 extends StatefulWidget {
  Function funcToCall;
  LineChartSample2(this.funcToCall);
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  List<FlSpot> graphPoints = [];

  void createPointList() {
    print("createPointList() called");
    graphPoints = [];
    double index = 0;
    glb.chartMapList.forEach((map) {
      map.forEach((key, value) {
        graphPoints.add(FlSpot(index, double.parse((value/1000).toStringAsFixed(3))));
      });
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    createPointList();
    return Container(
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        // boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.1),
        //       // spreadRadius: 5,
        //       blurRadius: 5,
        //       offset: Offset(0, 3), // changes position of shadow
        //     ),
        //   ],
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: glb.main_background),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.refresh, color: Colors.transparent), onPressed: (){}),
              Text("Performance this week",
                  style:
                      getAppTextStyle(18, glb.main_foreground_header, true)),
              IconButton(
                  icon:
                      Icon(Icons.refresh, color: glb.main_foreground_header),
                  onPressed: () {
                    setState(() {
                      print("setState for chart called");
                    });
                    widget.funcToCall();
                  })
            ],
          ),
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              height: 250,
              width: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 16.0, top: 30, bottom: 20),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: glb.main_foreground_dimmer.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: glb.main_foreground_dimmer.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                {
                  String s;
                  glb.chartMapList[0].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 1:
                {
                  String s;
                  glb.chartMapList[1].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 2:
                {
                  String s;
                  glb.chartMapList[2].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 3:
                {
                  String s;
                  glb.chartMapList[3].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 4:
                {
                  String s;
                  glb.chartMapList[4].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 5:
                {
                  String s;
                  glb.chartMapList[5].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
              case 6:
                {
                  String s;
                  glb.chartMapList[6].forEach((key, value) {
                    s = key[0];
                  });
                  return s;
                }
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1000';
              case 2:
                return '2000';
              case 3:
                return '3000';
              case 4:
                return 'kcal';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: graphPoints,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
