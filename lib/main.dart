import 'package:flutter/material.dart';
import 'package:sprightly/views/Sprightly.dart';
import 'package:flutter/services.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    glb.switchTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sprightly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SprightlyHome()
    );
  }
}
