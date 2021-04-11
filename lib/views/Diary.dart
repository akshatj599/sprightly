import 'package:flutter/material.dart';
import 'package:sprightly/widgets/caloriesRemaining.dart';
import 'package:date_format/date_format.dart';
import 'package:sprightly/widgets/widgets.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DateTime curr;
  var dt;
  int counter=0;

  void changeDate(){
    curr= DateTime.now();
    var temp= curr.add(Duration(days: counter));
    dt = formatDate(temp, [D, ', ', M, ' ', dd, ' \'', yy]);
  }

  @override
  Widget build(BuildContext context) {
    changeDate();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {
                setState(() {
                  counter--;
                });
              }, child: Text("<", style: getAppTextStyle(16, Colors.red[400], false))),
              Text(dt, style: getAppTextStyle(16, Colors.black, false)),
              TextButton(onPressed: () {
                setState(() {
                  counter++;
                });
              }, child: Text(">", style: getAppTextStyle(16, Colors.red[400], false)))
            ],
          ),
        ),
        CaloriesRemaining()
      ],
    );
  }
}
