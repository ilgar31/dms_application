import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/info.dart';
import 'package:dms_project/pages/game.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/pages/settings.dart';
import 'package:dms_project/pages/price.dart';

void main() => runApp(More());

class More extends StatefulWidget {
  const More({Key, key}): super(key: key);

  @override
  _More createState() => _More();
}

class _More extends State {

  Widget ServiceButton(service) {
    return ElevatedButton(onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              Price(service: service),
          transitionDuration: Duration(milliseconds: 700),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    }, child: Align(
        alignment: Alignment.centerLeft,
        child:
            Padding(padding: EdgeInsets.only(left: 25),
            child:  Text(service, style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600)),),),
        style: ElevatedButton.styleFrom(
        primary: Color(0xff494949),
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // <-- Radius
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.85, 40),
        maximumSize: Size(MediaQuery.of(context).size.width * 0.85, 50)
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 80,
              title:
                  Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    child:
                        Padding(padding: EdgeInsets.only(top: 15),
                    child: Text("Оказываемые услуги и их цены", maxLines: 2, style: TextStyle(fontFamily: "Inter", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),),)
                  )
              ),
          body: Column(children: [Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.06),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 30),),
                  ServiceButton('Лечение зубов'),
                  Padding(padding: EdgeInsets.only(top: 12),),
                  ServiceButton('Имплантация'),
                  Padding(padding: EdgeInsets.only(top: 12),),
                  ServiceButton('Протезирование'),
                  Padding(padding: EdgeInsets.only(top: 12),),
                  ServiceButton('Хирургия'),
                  Padding(padding: EdgeInsets.only(top: 12),),
                  ServiceButton('Ортодонтия'),
                  Padding(padding: EdgeInsets.only(top: 12),),
                  ServiceButton('Профессиональная чистка'),
                  Padding(padding: EdgeInsets.only(top: 80),),
                ],
              )
          ),
          Center(child:
          ElevatedButton(onPressed: () {},
            child: Text("Связаться с нами", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.85, 40),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.85, 60)
            ),),),],),
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
              initialActiveIndex: 3,
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
