import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/info.dart';
import 'package:dms_project/pages/game.dart';
import 'package:dms_project/pages/more.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/settings.dart';
import 'package:dms_project/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

    runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key, key}): super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State {

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: (){
                if (user == null){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Auth(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                } else {
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
                }
            },
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.black, size:30),
                      Padding(padding: EdgeInsets.fromLTRB(25, 11, 50, 10),
                      child: Text("Профиль", style: TextStyle(color: Colors.black, fontFamily: "SF", fontSize: 18
                      ))),
                    ],
                  ), Row(
                    children: [
                      IconButton(onPressed: () => signOut(), icon: Icon(Icons.card_giftcard, color: Colors.black, size:30)),
                      Padding(padding: EdgeInsets.only(left: 10),),
                      IconButton(onPressed: () => debugPrint(FirebaseAuth.instance.currentUser!.uid), icon: Icon(Icons.notifications_rounded, color: Colors.black, size:30))
                    ],
                  )
                ]
          ))),),
        body: Center(
          child: Text("Main Screen", style: TextStyle(color: Colors.black)),
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            style: TabStyle.fixedCircle,
            backgroundColor: Color(0xFFF3F3F3),
            color: Color(0xFF696969),
            activeColor: Color(0xFF424242),
            height: 55,
            curveSize: 90,
            items: [
              TabItem(icon: Icons.home_filled),
              TabItem(icon: Icons.info),
              TabItem(icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF494949),
                  ),
                  child: Image.asset("assets/tooth2.png", color: Colors.white)
              )),
              TabItem(icon: Icons.work),
              TabItem(icon: Icons.maps_home_work_outlined),
            ],
            initialActiveIndex: 0,
            onTap: (int i) {
              if (i == 0) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Home(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
              if (i == 1) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Info(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
              if (i == 2) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Game(),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                  ),
                );
              }
              if (i == 3) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => More(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
              if (i == 4) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => SettingsApp(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 20, color: color);
  }
}

