import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/info.dart';
import 'package:dms_project/pages/game.dart';
import 'package:dms_project/pages/more.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/settings.dart';
import 'package:dms_project/pages/welcom.dart';
import 'package:dms_project/pages/gifts.dart';
import 'package:dms_project/pages/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dms_project/pages/stories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';




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

  final user = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> allImages = {};
  List docs = [];

  bool _showObject = false;

  void getAllImages() async {
    final result =
    FirebaseFirestore.instance.collection(" Истории");
    result.get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          allImages[docSnapshot.id] = docSnapshot.data();
          docs.add(FirebaseFirestore.instance.collection(" Истории").doc(docSnapshot.id).collection('Контент'));
        }
        _showObject = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1250), () {
      setState(() {
        _showObject = true;
      });
    });
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllImages();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
              onTap: (){
                if (user == null){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Welcom(),
                      transitionDuration: Duration(milliseconds: 700),
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
                            Icon(Icons.account_circle, color: Color(0xF4494949), size:30),
                            Padding(padding: EdgeInsets.fromLTRB(25, 11, 50, 10),
                                child: Text("Профиль", style: TextStyle(color: Color(
                                    0xF41E1E1E), fontFamily: "SF", fontSize: 18, fontWeight: FontWeight.w600
                                ))),
                          ],
                        ), Row(
                          children: [
                            IconButton(onPressed: () => {
                              if (user == null) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) =>
                                        Welcom(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) =>
                                        FadeTransition(opacity: a, child: c),
                                  ),
                                ),
                              }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) =>
                                          Gifts(),
                                      transitionDuration: Duration(milliseconds: 300),
                                      transitionsBuilder: (_, a, __, c) =>
                                          FadeTransition(opacity: a, child: c),
                                    ),
                                  ),
                                }
                            },
                                icon: Icon(Icons.card_giftcard, color: Color(0xF4494949), size:30)),
                            Padding(padding: EdgeInsets.only(left: 10),),
                            IconButton(onPressed: () => {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      Notifications(),
                                  transitionDuration: Duration(milliseconds: 300),
                                  transitionsBuilder: (_, a, __, c) =>
                                      FadeTransition(opacity: a, child: c),
                                ),
                              ),
                            },
                                icon: Icon(Icons.notifications_rounded, color: Color(0xF4494949), size:30))
                          ],
                        )
                      ]
                  ))),),

        body: Padding(padding: EdgeInsets.only(top: 10), child: Column(
          children: [_showObject
              ?
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Story(data: docs[index + 1]),
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Container(
                        height:150,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xF4494949),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: AssetImage("assets/master.png"),
                              image: NetworkImage(allImages["${index + 1}"]['url']),
                              fit: BoxFit.fill,
                            )
                        )
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10);
              },
              itemCount: allImages.length,
            ),) : Container(height: 150, child: Center(child: CircularProgressIndicator(color: Colors.black,),)),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Наши социальные сети', style: TextStyle(color: Colors.black, fontSize: 19, fontFamily: "Inter", fontWeight: FontWeight.w500),),
              ),
            ),
            SizedBox(height: 10,),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 75,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://vk.com/dental_technician_76');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/vk.png')
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://t.me/master_stomatologiya');
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/telegram.png')
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://wa.me/89622087777');
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/whatsapp.png')
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://www.instagram.com/master_dental_studio/');
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/inst.png')
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://youtube.com/@MASTERstom-76?si=0f-i18S0jNqPT3EC');
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/youtube.png')
                        )
                    ),
                    SizedBox(width: 10),
                  ],
                )
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Помогите нам стать лучше', style: TextStyle(color: Colors.black, fontSize: 19, fontFamily: "Inter", fontWeight: FontWeight.w500),),
              ),
            ),
            SizedBox(height: 10,),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://yandex.ru/maps/org/master/195214923875');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xF4494949), // Цвет границы
                                width: 2.0, // Ширина границы
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/yandex.png'),
                          ),
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL('https://2gis.ru/yaroslavl/firm/70000001033341570/39.840471%2C57.640445?m=39.839993%2C57.640385%2F19.96%2Fp%2F50%2Fr%2F-154.55');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xF4494949), // Цвет границы
                              width: 2.0, // Ширина границы
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/2gis.png'),
                          ),
                        )
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                          onTap: () {
                            _launchURL(
                                'https://www.google.com/maps/place/Master+Dental+Studio/@57.657044,39.8448181,18.21z/data=!4m6!3m5!1s0x46b291975ff08481:0x147a1d7e9d8cb30d!8m2!3d57.6569464!4d39.8458057!16s%2Fg%2F11h53wl2kt?hl=ru&entry=ttu');
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xF4494949), // Цвет границы
                              width: 2.0, // Ширина границы
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/googlemaps.png'),
                          ),
                        )
                    ),
                    SizedBox(width: 10),
                  ],
                )
            ),
            SizedBox(height: 25,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child:
              Builder(
                builder: (BuildContext innerContext) {
                  return GestureDetector(
                      onTap: () async {
                        if (user == null){
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  Welcom(),
                              transitionDuration: Duration(milliseconds: 700),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        }
                        else {
                          DocumentSnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                          Map<String, dynamic> data = dataRef.data() as Map<String, dynamic>;
                          String name = data['ФИО'];
                          String email = data['E-mail'];
                          String birthday = data['День рождения'];
                          String gender = data['Пол'];
                          bool flag = true;
                          if (name == "Введите свое ФИО" || email == "Введите свой E-mail" || birthday == "Выберите дату рождения" || gender == "Укажите муж/жен") {
                            flag = false;
                          }
                          if (flag) {
                            // успешное создание карты
                          }
                          else {
                            final snackBar = SnackBar(content: Text('Пожалуйста, заполните все поля в свом профиле\n'));
                            ScaffoldMessenger.of(innerContext).showSnackBar(snackBar);
                          }
                        }
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/card.png')
                      )
                  );
                },
              ),
            )
          ],
        ),),
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

