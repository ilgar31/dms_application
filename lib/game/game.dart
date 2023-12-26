import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dms_project/pages/home.dart';
import 'tooth.dart';
import 'values.dart';
import 'piece.dart';


List<List<Tetromino?>> gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));


class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _Game();
}

class _Game extends State<Game> {
  Piece currentPiece = Piece(type: Tetromino.Z);

  int currentScore = 0;

  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 200);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          clearLines();
          checkLanding();

          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          currentPiece.movePlace(Direction.down);
        });
      }
    );
  }

  void showGameOverDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Игра окончена"),
      content: Text("Вы набрали ${currentScore} очков"),
      actions: [
        TextButton(onPressed: () {
          resetGame();
          Navigator.pop(context);
        }, child: Text("Играть сначала"))
      ],
    ));
  }

  void resetGame() {
    gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    gameOver = false;
    currentScore = 0;

    createNewPiece();

    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i=0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right){
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();

    Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }



  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePlace(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePlace(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r-1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);
        currentScore += 100;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffededed),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 40),),
            ElevatedButton(onPressed: () {
              resetGame();
              Navigator.pop(context);
            }, child:  Row(
              children: [
                Icon(Icons.keyboard_backspace, color: Colors.black),
                Padding(padding: EdgeInsets.only(left: 10),),
                Text("Назад", style: TextStyle(fontFamily: "SF", color: Colors.black)),
              ]),
              style: ElevatedButton.styleFrom(
                  maximumSize: Size(100, 50),
                  primary: Color(0xffcccccc),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Установка радиуса скругления
                  ),),
            ),
            Padding(padding: EdgeInsets.only(top: 10),),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xff494949),// Установка радиуса скругления углов
              ),
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Равномерное распределение между дочерними элементами
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ваш рекорд:',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600))
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      currentScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ),),
            Padding(padding: EdgeInsets.only(top: 10),),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.61 + 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: Color(0xff494949), // Цвет границы
                  width: 3.0, // Ширина границы
                ),
                color: Color(0x9b9e9fa3),// Установка радиуса скругления углов
              ),
              alignment: Alignment.topCenter,
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! > 0) {
                      moveRight();
                    } else if (details.primaryVelocity! < 0) {
                      moveLeft();
                    }
                  },
                  onTap: () {
                    rotatePiece();
                  },
                  child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rowLength * colLength,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;
                    if (currentPiece.position.contains(index)) {
                        return Tooth(color: currentPiece.color, child: '');
                    }
                    else if (gameBoard[row][col] != null) {
                        final Tetromino? tetrominoType = gameBoard[row][col];
                        return Tooth(color: tetrominoColors[tetrominoType], child: '');
                    }
                    else {
                        return Tooth(color: Colors.grey[900], child: '');
                    }
                  }
                )
              )
            ))
          ],
        )
      ),
      ),
    );
  }
}
