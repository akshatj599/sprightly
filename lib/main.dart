import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sprightly/views/AppHomeScreen.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    glb.backgroundImage = Image.asset(
      "images/back_main.jpg",
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
    glb.switchTheme();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sprightly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppHomeScreen());
  }
}
