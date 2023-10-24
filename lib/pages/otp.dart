import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/functions/otp_controller.dart';



class OTP extends StatelessWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Введите смс код",
              style: TextStyle(color: Colors.black, fontFamily: "SF", fontSize: 17),
            ),
            SizedBox(height: 40.0,),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: true,
              onChanged: (String value) {
                otp = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(height: 40.0,),
            ElevatedButton(onPressed: () async {
              OTPController.instance.verifyOTP(otp);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      Profile(),
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              );
            }, child: Text("Отправить"),
            ),
          ],
        ),
      ),
    );
  }
}