import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  List<FlSpot> graphPoints;

  void createPointListFromFB() {
    //TODO: Get chart points from FB
    graphPoints = [
      FlSpot(0, 1.5),
      FlSpot(1, 1.2),
      FlSpot(2, 1.9),
      FlSpot(3, 0.7),
      FlSpot(4, 0.5),
      FlSpot(5, 2.3),
      FlSpot(6, 2.1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    createPointListFromFB();
    return Container(
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: glb.main_background),
      child: Column(
        children: [
          Text("Performance this week",
              style: getAppTextStyle(18, glb.main_foreground_header, true)),
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
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
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
