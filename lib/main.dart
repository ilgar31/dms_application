import 'package:flutter/material.dart';
import 'package:dms_project/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';



void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(MaterialApp(
        initialRoute: '/',
        routes: {
            '/': (context) => Home(),
        }
    ));
}
