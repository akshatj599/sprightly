import 'package:flutter/material.dart';
import 'package:sprightly/widgets/widgets.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label, this.iconColor});

  final IconData icon;
  final String label;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 50.0,
          color: iconColor,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          style: getAppTextStyle(14, iconColor, false),
        )
      ],
    );
  }
}
