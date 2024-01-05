import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'card_loading.dart';




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
              Image.asset('assets/test_card.png'),
              Padding(padding: EdgeInsets.only(top: 20),),
              Image.asset('assets/card_text1.png'),
              Padding(padding: EdgeInsets.only(top: 15),),
              Image.asset('assets/card_text2.png'),
              Padding(padding: EdgeInsets.only(top: 25),),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => CardLoading(),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                  ),
                );
              },
                child: Text("Открыть полис “MASTER”", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w500),),
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