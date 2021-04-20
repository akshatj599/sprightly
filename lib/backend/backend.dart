import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprightly/views/Recipe_main.dart';
import 'package:sprightly/widgets/globals.dart' as glb;

Future<void> getUserDetailsFromFB() async {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser.email)
      .get()
      .then((DocumentSnapshot doc) {
    glb.currentUserDetails = doc['Details'];
    glb.currentUserDetails['Email'] = doc.id;
  });
}
