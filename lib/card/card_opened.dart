import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home.dart';




class CardOpened extends StatelessWidget {
  const CardOpened({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Image.asset('assets/card_opened.png')
              ),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Home(),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                  ),
                );
              },
                child: Text("Далее", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w500),),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3b3b3b),
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // <-- Radius
                  ),
                ),
              ),
              SizedBox(height: 70,)
            ],
          ),
        )

      ),);
  }
}