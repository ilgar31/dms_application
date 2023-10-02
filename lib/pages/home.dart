import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/info.dart';
import 'package:dms_project/pages/game.dart';
import 'package:dms_project/pages/more.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/settings.dart';
import 'package:dms_project/pages/login.dart';


void main() => runApp(Home());

class Home extends StatefulWidget {
  const Home({Key, key}): super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => Auth(),
                        transitionDuration: Duration(milliseconds: 300),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );}, icon: Icon(Icons.perm_contact_calendar_rounded, color: Colors.black, size:30)),
                    Padding(padding: EdgeInsets.fromLTRB(5, 13, 50, 10), child: TextButton(
                        onPressed: () {Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => Auth(),
                            transitionDuration: Duration(milliseconds: 300),
                            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                          ),
                        );}, child: Text("Профиль >", style: TextStyle(color: Colors.black, fontFamily: "SF", fontSize: 17
                    ))),),
                  ],
                ), Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.airplane_ticket_outlined, color: Colors.black, size:30)),
                    Padding(padding: EdgeInsets.only(left: 10),),
                    IconButton(onPressed: () {}, icon: Icon(Icons.turned_in, color: Colors.black, size:30))
                  ],
                )
              ]
          ),),
        body: Center(
          child: Text("Main Screen", style: TextStyle(color: Colors.black)),
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            style: TabStyle.fixedCircle,
            backgroundColor: Color(0xFFF3F3F3),
            color: Color(0xFF8A7B7B),
            activeColor: Color(0xFF795959),
            height: 55,
            curveSize: 90,
            items: [
              TabItem(icon: Icons.person),
              TabItem(icon: Icons.info),
              TabItem(icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF8D09C),
                  ),
                  child: Image.asset("assets/tooth2.png", color: Color(0xFF8C561C))
              )),
              TabItem(icon: Icons.more_horiz),
              TabItem(icon: Icons.settings),
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
                    pageBuilder: (context, animation1, animation2) => Settings(),
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
