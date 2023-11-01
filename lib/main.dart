import 'package:flutter/material.dart';
import 'package:dms_project/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
        if (user == null) {
            debugPrint('User is currently signed out!');
        } else {
            debugPrint('User is signed in!');
        }
    });


    runApp(GetMaterialApp(
        initialRoute: '/',
        routes: {
            '/': (context) => Home(),
        }
    ));
}
