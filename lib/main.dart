import 'package:flutter/material.dart';
import 'package:dms_project/pages/home.dart';
import 'package:dms_project/pages/game.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
    '/': (context) => Home(),
    // '/info': (context) => MainScreen(),
    '/game': (context) => Game(),
    // '/more': (context) => MainScreen(),
    // '/setting': (context) => MainScreen(),
    }
));
