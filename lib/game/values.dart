import 'dart:ui';

int rowLength = 10;
int colLength = 15;

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

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color(0xFF0048FF),
  Tetromino.I: Color(0xFFE807F8),
  Tetromino.O: Color(0xFFFFFC00),
  Tetromino.S: Color(0xFF007715),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color(0xFF6B006E),
};