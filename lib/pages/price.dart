import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/functions/otp_controller.dart';



class Price extends StatefulWidget {

  dynamic service;

  Price({ super.key, required this.service});
  @override
  _Price createState() => _Price(this.service);
}
class _Price extends State<Price>{

  dynamic service;

  _Price(this.service);


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
                  Text(service, style: TextStyle(fontFamily: "Inter", color: Colors.black),),
                ],
              )),
          body: Center(child: Text('Прайс', style: TextStyle(fontFamily: "Inter", fontSize: 18),))

      ),);
  }
}