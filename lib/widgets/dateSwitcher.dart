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
      ),
      width: double.infinity,
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
          TextButton(
            onPressed: () {
              showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 10, 1, 1),
                  lastDate: DateTime.now(),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData(
                        primaryColor: glb.main_appBar,
                        colorScheme: glb.dark_theme
                            ? ColorScheme.dark(
                                primary: glb.main_secondary,
                                surface: glb.main_appBar)
                            : ColorScheme.light(
                                primary: glb.main_appBar,
                                surface: glb.main_appBar),
                        // buttonTheme:
                        //     ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  }).then((datetime) {
                if (datetime == null) return;
                glb.counter = datetime.difference(DateTime.now()).inDays;
                print(glb.counter);
                setState(() {
                  changeDate();
                });
              });
            },
            child: Text(widget.dtToDisplay,
                style: getAppTextStyle(16, glb.main_foreground_header, false)),
          ),
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
