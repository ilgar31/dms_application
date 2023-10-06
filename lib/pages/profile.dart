import 'package:flutter/material.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(Profile());

class Profile extends StatefulWidget {
  const Profile({Key, key}): super(key: key);

  @override
  _Profile createState() => _Profile();
}


class MyInput extends StatefulWidget {

  var input_name;
  var input_value;

  MyInput({ super.key, required this.input_name, required this.input_value});
  @override
  _MyInput createState() => _MyInput(this.input_name, this.input_value);
}
class _MyInput extends State<MyInput>{

  var input_name;
  var input_value;
  var _user_input;

  _MyInput(this.input_name, this.input_value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(input_name),
                  content: TextField(
                    onChanged: (String value) {
                      _user_input = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(onPressed: () {
                      setState(() {
                        input_value = _user_input;
                      });
                      Navigator.of(context, rootNavigator: true).pop();
                      }, child: Text("Сохранить"))
                  ],
                );
              });
        },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.white, // Set border color
                    width: 1.0),   // Set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // Set rounded corner radius
                boxShadow: [BoxShadow(blurRadius: 3,color: Colors.grey,offset: Offset(1,3))] // Make rounded corner of border
            ),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(input_name,
                        style: TextStyle(color: Colors.blueAccent),),
                      Text(
                        input_value, style: TextStyle(color: Colors.blueGrey),),
                    ]
                ),
              ],
            )
        )
    );
  }
}

void printOnClick(string) {
  print(string);
}


class _Profile extends State {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => Home(),
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(onPressed: () {Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => Home(),
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                ),
              );}, icon: Icon(Icons.arrow_back), color: Colors.blueAccent),
              Padding(padding: EdgeInsets.only(left: 25),),
              Text("Профиль", style: TextStyle(color: Colors.blueAccent),),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50),),
              Icon(Icons.person_rounded, size: 150,),
              Padding(padding: EdgeInsets.only(top: 20),),
              MyInput(input_name: 'Телефон', input_value: '+79066344367'),
              MyInput(input_name: 'E-mail', input_value: 'ilgar.bagishev@gmail.com'),
              MyInput(input_name: 'День рождения', input_value: '31/03/2006'),
              MyInput(input_name: 'Пол', input_value: 'Мужской'),
              TextButton(
                onPressed: () => signOut(),
                child: const Text('Выйти'),
              ),
            ]
          )
        ),
      ),
    );
  }
}
