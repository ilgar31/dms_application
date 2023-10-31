import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/pages/game.dart';
import 'package:dms_project/pages/more.dart';
import 'package:dms_project/pages/settings.dart';

void main() => runApp(Info());

class Info extends StatefulWidget {
  const Info({Key, key}): super(key: key);

  @override
  _Info createState() => _Info();
}

class _Info extends State {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom navigation",
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, title: Text("Информация о нас", style: TextStyle(fontFamily: "SF", color: Colors.black),),),
        body: Center(
          child: Text("Info Screen", style: TextStyle(color: Colors.black)),
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
            initialActiveIndex: 1,
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
                Navigator.pushReplacement(
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
