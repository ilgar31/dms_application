// import 'package:flutter/material.dart';
// import 'package:dms_project/pages/home.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:dms_project/firebase_options.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseAuth.instance
//       .authStateChanges()
//       .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
// }
