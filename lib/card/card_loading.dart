import 'package:flutter/material.dart';
import 'card_opened.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';





class CardLoading extends StatefulWidget {
  const CardLoading({super.key});

  @override
  State<CardLoading> createState() => _CardLoading();
}

class _CardLoading extends State<CardLoading> {

  @override
  void initState() {
    super.initState();

    String polis = '';
    for (int i = 0; i < 16; i++) {
      polis += Random().nextInt(9).toString();
    }
    final docRef = FirebaseFirestore.instance.collection(
        'users').doc(
        FirebaseAuth.instance.currentUser?.uid);
    docRef.get().then(
            (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          data["Полис"] = polis;
          FirebaseFirestore.instance.collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .set(data);
        }
    );

    Future.delayed(Duration(milliseconds: 1750), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => CardOpened(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.black,),
                SizedBox(height: 20,),
                Text("Полис создается", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w500)),
              ],
          )

          ),),);
  }
}