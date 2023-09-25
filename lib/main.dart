import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key, key}): super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {

  var _currentPage = 0;

  var _pages = [
    Text("1 страница"),
    Text("2 страница"),
    Text("3 страница"),
    Text("4 страница"),
    Text("5 страница"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom navigation",
      home: Scaffold(
        appBar: AppBar(title: Text("Bottom navigation"),),
        body: Center(
          child: _pages.elementAt(_currentPage),
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
            initialActiveIndex: 1,
            onTap: (int i) {
              if (i == 2) {
                print('$i');
              }
              setState(() {
                _currentPage = i;
              });
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
