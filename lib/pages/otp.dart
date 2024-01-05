import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/functions/otp_controller.dart';
import 'package:flutterotpfield/flutterotpfield.dart';


class OTP extends StatefulWidget {

  dynamic phone;

  OTP({ super.key, required this.phone});
  @override
  _OTP createState() => _OTP(this.phone);
}


class _OTP extends State<OTP> {
  dynamic phone;

  _OTP(this.phone);


  void CheckOtp(context, otp) {
    {
      FocusManager.instance.primaryFocus?.unfocus();
      debugPrint("before!!!!!!!!!!!!!!!!!!!!!!!!!!!  ${otp}");
      Future<bool> ans = OTPController.instance.verifyOTP(otp);
      ans.then((value) async {
        debugPrint("after!!!!!!!!!!!!!!!!!!!!!!!!!!!  ${otp}");
        bool flag = true;
        await FirebaseFirestore.instance.collection("users")
            .get()
            .then((event) {
          for (var doc in event.docs) {
            if (FirebaseAuth.instance.currentUser!.uid == doc.id) {
              flag = false;
              break;
            }
          }
        });
        if (flag) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            "Телефон": FirebaseAuth.instance.currentUser!.phoneNumber,
            "ФИО": "Введите свое ФИО",
            "E-mail": "Введите свой E-mail",
            "День рождения": "Выберите дату рождения",
            "Пол": "Укажите муж/жен",
            "Рекорд в игре": 0,
            "Полис": "-",
          });
        }
        debugPrint("too!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var otp = '';
    return MaterialApp(
        theme: ThemeData(
        textTheme: const TextTheme(
        titleMedium: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600, fontFamily: "Inter"),
      ),
    ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                Text("Вход", style: TextStyle(fontFamily: "Inter", color: Colors.black),),
              ],
            )),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding( padding: const EdgeInsets.only(left: 35.0),
                child: Text("Введите код из смс", style: TextStyle(color: Color(
                    0xff7c7c7c), fontSize: 17, fontFamily: "SF"), textAlign: TextAlign.left,),),
              Padding(padding: EdgeInsets.only(top: 15),),
              Center(child: FlutterOtpField(
                inputFieldLength: 6,
                spaceBetweenFields: 10,
                inputFieldHeight: 40,
                inputFieldWidth: 49,
                inputDecoration: InputDecoration(
                    fillColor: Color(0xffEAEAEA),
                    filled: true,
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffEAEAEA),
                            width: 2.0),
                        borderRadius:
                        BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffa8a8a8),
                            width: 3.0),
                        borderRadius:
                        BorderRadius.circular(10))),
                onValueChange: (String value) {
                  otp = value;
                },
                onCompleted: (String value) {
                  otp = value;
                  CheckOtp(context, otp);
                },),),
              Padding(padding: EdgeInsets.only(top: 25),),
              Center(child: ElevatedButton(onPressed: () => CheckOtp(context, otp), child: Text("Далее"),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff494949),
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 12.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // <-- Radius
                  ),
                ),
              ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("На ваш номер ${phone} отправлено СМС с кодом подтверждения", textAlign: TextAlign.center, style: TextStyle(color: Color(
                    0xff7c7c7c), fontSize: 15, fontFamily: "SF"))
              )
            ],
          ),
        ),
      ),
    );
  }
}