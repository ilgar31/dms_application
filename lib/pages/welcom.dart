import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/login.dart';


class Welcom extends StatelessWidget {
  const Welcom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                Text("Назад", style: TextStyle(fontFamily: "Inter", color: Colors.black),),
              ],
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/welcom.png", width: 300,),
              Padding(padding: EdgeInsets.only(top: 50),),
              Text("Войдите в профиль", style: TextStyle(fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w900)),
              Padding(padding: EdgeInsets.only(top: 8),),
              Text("чтобы получить", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w400)),
              Text("медицинский полис", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w400)),
              Padding(padding: EdgeInsets.only(top: 2),),
              Text("MASTER", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w400)),
              Padding(padding: EdgeInsets.only(top: 50),),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        MyAuth(),
                    transitionDuration: Duration(milliseconds: 700),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Text("Вход | Регистрация", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w500),),
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
        ),
      ),
    );
  }
}
