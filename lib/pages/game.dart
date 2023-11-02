import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/home.dart';

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
        appBar: AppBar(
          backgroundColor: Color(0xFFC4E3B0),
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Padding(padding: EdgeInsets.only(left: 25),),
              Text("Tetris game", style: TextStyle(color: Colors.black38),),
            ],
          ),
        ),
        body: Center(
          child: Text("Game Screen", style: TextStyle(color: Colors.black)),
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
