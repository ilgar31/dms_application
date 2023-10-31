import 'package:flutter/material.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



void main() => runApp(Profile());

class Profile extends StatefulWidget {
  const Profile({Key, key}): super(key: key);

  @override
  _Profile createState() => _Profile();
}

enum SingingCharacter { male, female }

class MyInput extends StatefulWidget {

  var input_name;
  var input_value;

  MyInput({ super.key, required this.input_name, required this.input_value});
  @override
  _MyInput createState() => _MyInput(this.input_name, this.input_value);
}
class _MyInput extends State<MyInput>{

  SingingCharacter? _character = SingingCharacter.male;

  var input_name;
  var input_value;
  var _user_input;

  _MyInput(this.input_name, this.input_value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (input_name == "Пол") {
            showDialog(
                context: context,
                builder: (context) => StatefulBuilder(builder: (context, state) {
                  return AlertDialog(
                    title: Text(input_name),
                    content: Container(
                      height: 113.0,
                      width: 300.0,
                      child: Column(
                      children: <Widget>[
                        RadioListTile<SingingCharacter>(
                          title: const Text('Мужчина'),
                          value: SingingCharacter.male,
                          groupValue: _character,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (SingingCharacter? value) {
                            state(() {
                              _character = value;
                            });
                          },
                        ),
                        RadioListTile<SingingCharacter>(
                          title: const Text('Женщина'),
                          value: SingingCharacter.female,
                          groupValue: _character,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (SingingCharacter? value) {
                            state(() {
                              _character = value;
                            });
                          },
                        ),
                      ],
                    ),
                    ),
                    actions: [
                      ElevatedButton(onPressed: () {
                        state(() {
                          if (_character == SingingCharacter.male) {input_value = "Мужчина";}
                          else {input_value = "Женщина";}
                        });
                        final docRef = FirebaseFirestore.instance.collection(
                            'users').doc(
                            FirebaseAuth.instance.currentUser?.uid);
                        docRef.get().then(
                                (DocumentSnapshot doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              data[input_name] = input_value;
                              FirebaseFirestore.instance.collection("users")
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .set(data);
                            }
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      }, child: Center(child: Text("Сохранить")),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff494949),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),)
                    ],
                  );
                }), );
          }
          else if (input_name != "Телефон") {
            showDialog(
                context: context,
                builder: (context) => StatefulBuilder(builder: (context, state) {
                  return AlertDialog(
                    title: Text(input_name),
                    content: TextFormField(
                      initialValue: input_value,
                      onChanged: (String value) {
                        _user_input = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(onPressed: () {
                        setState(() {
                          if (_user_input != null)
                          {input_value = _user_input;}
                        });
                        final docRef = FirebaseFirestore.instance.collection(
                            'users').doc(
                            FirebaseAuth.instance.currentUser?.uid);
                        docRef.get().then(
                                (DocumentSnapshot doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              data[input_name] = input_value;
                              FirebaseFirestore.instance.collection("users")
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .set(data);
                            }
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      }, child: Center(child: Text("Сохранить")),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff494949),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),)
                    ],
                  );
                }), );
          }
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
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(input_name,
                        style: TextStyle(color: Colors.black.withOpacity(1.0), fontSize: 16, fontFamily: 'SF'),),
                      Text(
                        input_value, style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 13, fontFamily: 'SF'),),
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
    );
  }


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
              );}, icon: Icon(Icons.keyboard_backspace), color: Colors.black),
              Padding(padding: EdgeInsets.only(left: 10),),
              Padding(padding: EdgeInsets.only(bottom: 20),),
              Text("Профиль", style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.data!.exists) {
              return Center(
                  child: Column(
                      children: [
                        Image.asset("assets/profileFoto.png", width: 300, height: 300,),
                        MyInput(input_name: 'Телефон',
                            input_value: (snapshot
                                .data as DocumentSnapshot)['Телефон']),
                        MyInput(input_name: 'ФИО',
                            input_value: (snapshot
                                .data as DocumentSnapshot)['ФИО']),
                        MyInput(input_name: 'E-mail',
                            input_value: (snapshot
                                .data as DocumentSnapshot)['E-mail']),
                        MyInput(input_name: 'День рождения',
                            input_value: (snapshot
                                .data as DocumentSnapshot)['День рождения']),
                        MyInput(input_name: 'Пол',
                            input_value: (snapshot
                                .data as DocumentSnapshot)['Пол']),
                  GestureDetector(
                      onTap: () => signOut(),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                              color: Color(0xffe43d3d),
                              border: Border.all(
                                  color: Color(0xffe43d3d), // Set border color
                                  width: 1.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 3,color: Colors.grey,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 5.0),
                          child: Center(
                            child: Text('Выйти', style: TextStyle(color: Colors.white)),)
                      ),
                  )
                ]
              )
              );
            }
            else {
              return Center();
            }
          }
        ),
      )
    );
  }
}


