import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(Game());

class Game extends StatefulWidget {
  const Game({Key, key}): super(key: key);

  @override
  _Game createState() => _Game();
}

class _Game extends State {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom navigation",
      home: Scaffold(
        appBar: AppBar(title: Text("Bottom navigation"),),
        body: Center(
          child: Text("Game Screen", style: TextStyle(color: Colors.black)),
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
              TabItem(icon: Icons.photo),
              TabItem(icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF8D09C),
                  ),
                  child: Image.asset("assets/tooth2.png", color: Color(0xFF8C561C))
              )),
              TabItem(icon: Icons.calendar_today),
              TabItem(icon: Icons.assessment),
            ],
            initialActiveIndex: 2,
            onTap: (int i) {
              if (i == 0) {
                Navigator.pushReplacementNamed(context, '/');
              }
              if (i == 2) {
                Navigator.pushReplacementNamed(context, '/game');
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
