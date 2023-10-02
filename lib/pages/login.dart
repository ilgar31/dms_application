import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Auth());
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAuth(),
    );
  }
}

class MyAuth extends StatelessWidget {
  const MyAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user_login;
    var user_password;
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/master.png", width: 300,),
            Padding(padding: EdgeInsets.only(top: 50),),
            Text("Добро пожаловать!", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: "SF")),
            Padding(padding: EdgeInsets.only(top: 50),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
              child: TextField(
                maxLength: 16,
                inputFormatters: [PhoneInputFormatter()],
                onChanged: (String value) {
                  user_login = value;
                },
                controller: _controller,
                onTap: () {
                  if (_controller.text.length < 2) {
                    _controller.text = '+7';
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  counterText: '',
                  hintText: '+7 999 999 99 99',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                obscureText: true,
                onChanged: (String value) {
                  user_password = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: 'Пароль',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: Text("Забыли пароль?", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "SF"))),
            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: user_login,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {},
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
              print(user_login.replaceAll(" ", ''));
            }, child: Text("Войти")),
            ElevatedButton(onPressed: () {
              print("$user_login    $user_password");
            }, child: Text("Зарегистрироваться"))
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

    var resultString = newString.join('');


    return TextEditingValue(
      text: resultString,
      selection: TextSelection.collapsed(offset: resultString.length),
    );
  }
}