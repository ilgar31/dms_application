import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/functions/otp_controller.dart';

class Gifts extends StatelessWidget {
  const Gifts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar:
      AppBar(backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
        children: [
          IconButton(onPressed: () => {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    Home(),
                transitionDuration: Duration(milliseconds: 300),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            ),
          },
          icon: Icon(Icons.keyboard_backspace), color: Colors.black),
          Padding(padding: EdgeInsets.only(left: 10),),
          Text("Подарки", style: TextStyle(fontFamily: "SF", color: Colors.black),),
      ],
      )),
      body: Center(child: Text('В данный момент у Вас нет подарков', style: TextStyle(fontFamily: "SF", fontSize: 18),))
    ),
    );
  }
}