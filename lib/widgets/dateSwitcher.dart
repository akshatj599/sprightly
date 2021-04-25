import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class DateSwitcher extends StatefulWidget {
  DateTime curr;
  String dtToDisplay;
  String dtMain;
  Function funcToCall;

  DateSwitcher(this.funcToCall);

  @override
  _DateSwitcherState createState() => _DateSwitcherState();
}

class _DateSwitcherState extends State<DateSwitcher> {
  void changeDate() {
    widget.curr = DateTime.now().add(Duration(days: glb.counter));
    if (glb.counter == 0)
      widget.dtToDisplay = 'Today';
    else if (glb.counter == 1)
      widget.dtToDisplay = 'Tomorrow';
    else if (glb.counter == -1)
      widget.dtToDisplay = 'Yesterday';
    else
      widget.dtToDisplay =
          formatDate(widget.curr, [D, ', ', M, ' ', dd, ' \'', yy]);

    widget.dtMain = formatDate(widget.curr, [D, ', ', M, ' ', dd, ' \'', yy]);
  }

  @override
  Widget build(BuildContext context) {
    changeDate();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: glb.main_background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            // spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                widget.funcToCall();
                setState(() {
                  glb.counter--;
                });
              },
              child: Text("<",
                  style: getAppTextStyle(16, Colors.red[400], false))),
          Text(widget.dtToDisplay,
              style: getAppTextStyle(16, glb.main_foreground_header, false)),
          TextButton(
              onPressed: () {
                if (glb.counter < 0) {
                  widget.funcToCall();
                  setState(() {
                    glb.counter++;
                  });
                }
              },
              child:
                  Text(">", style: getAppTextStyle(16, Colors.red[400], false)))
        ],
      ),
    );
  }
}
