import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed,
  @required this.onLongPressed});

  final IconData icon;
  final Function onPressed;
  final Function onLongPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 2.0,
      child: Icon(
        icon,
        color: Colors.grey[800],
        size: 15,
      ),
      onPressed: onPressed,
      onLongPress: onLongPressed,
      constraints: BoxConstraints.tightFor(
        width: 40.0,
        height: 40.0,
      ),
      shape: CircleBorder(),
      fillColor: Colors.orange[300],

    );
  }
}
