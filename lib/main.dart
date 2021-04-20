import 'package:flutter/material.dart';
import 'package:sprightly/views/AppHomeScreen.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprightly/backend/backend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    glb.switchTheme();
    if (FirebaseAuth.instance.currentUser != null) {
      glb.isUserSignedIn = true;
      getUserDetailsFromFB();
    } else {
      glb.isUserSignedIn = false;
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sprightly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppHomeScreen());
  }
}
