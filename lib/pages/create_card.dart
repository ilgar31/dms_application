import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/functions/otp_controller.dart';



class CreateCard extends StatelessWidget {
  const CreateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(onPressed: () => {
                    Navigator.pop(context),
                  },
                      icon: Icon(Icons.keyboard_backspace), color: Colors.black),
                  Padding(padding: EdgeInsets.only(left: 10),),
                  Text("Открытие полиса", style: TextStyle(fontFamily: "SF", color: Colors.black),),
                ],
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('test_card.png'),
              Padding(padding: EdgeInsets.only(top: 30),),
              Image.asset('card_text1.png'),
              Padding(padding: EdgeInsets.only(top: 25),),
              Image.asset('card_text2.png'),
              Padding(padding: EdgeInsets.only(top: 25),),
              ElevatedButton(onPressed: () {},
                child: Text("Открыть полис “MASTER”", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w600),),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3b3b3b),
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              )
            ],
          ),

      ),);
  }
}