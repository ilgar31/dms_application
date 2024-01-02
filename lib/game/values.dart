import 'dart:ui';

import 'package:flutter/cupertino.dart';

int rowLength = 10;
int colLength = 17;

String record = "";

enum Direction {
  left,
  right,
  down,
}

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T
}

Map<Tetromino, Image> tetrominoImages = {
  Tetromino.L: Image.asset("assets/tooth_orange.png"),
  Tetromino.J: Image.asset("assets/tooth_blue.png"),
  Tetromino.I: Image.asset("assets/tooth_white_blue.png"),
  Tetromino.O: Image.asset("assets/tooth_yellow.png"),
  Tetromino.S: Image.asset("assets/tooth_green.png"),
  Tetromino.Z: Image.asset("assets/tooth_red.png"),
  Tetromino.T: Image.asset("assets/tooth_purple.png"),
};

