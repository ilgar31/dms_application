import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/otp.dart';
import 'package:dms_project/functions/function.dart';


class MyAuth extends StatelessWidget {
  const MyAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phone;
    TextEditingController _controller = TextEditingController();
    return MaterialApp(
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding( padding: const EdgeInsets.only(left: 35.0),
               child: Text("Введите номер телефона", style: TextStyle(color: Color(
                   0xff7c7c7c), fontSize: 17, fontFamily: "SF"), textAlign: TextAlign.left,),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 7.5),
                child: TextField(
                  maxLength: 16,
                  cursorColor: Colors.black,
                  inputFormatters: [PhoneInputFormatter()],
                  onChanged: (String value) {
                    phone = value;
                  },
                  controller: _controller,
                  onTap: () {
                    if (_controller.text.length < 2) {
                      _controller.text = '+7';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    counterText: '',
                    hintText: '+7',
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Inter", fontWeight: FontWeight.w900),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5),),
              Center(
                child: ElevatedButton(onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Functions.instance.phoneAuth(phone);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        OTP(),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              }, child: Text("Войти по номеру телефона", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff494949),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // <-- Radius
                ),
              ),
              ),
              )
            ],
        ),
      ),
    );
  }
}


class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digitsOnly = newValue.text.replaceAll(" ", '');
    final dititsOnlyChars = digitsOnly.split('');

    var newString = <String>[];
    for (var i = 0; i < dititsOnlyChars.length; i++) {
      if (i == 2 || i == 5 || i == 8 || i == 10) newString.add(" ");
      newString.add(dititsOnlyChars[i]);
    }
    if (newString.length < 2) {
      newString = ['+', '7'];
    }

    var resultString = newString.join('');


    return TextEditingValue(
      text: resultString,
      selection: TextSelection.collapsed(offset: resultString.length),
    );
  }
}