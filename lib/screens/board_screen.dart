import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:tic_tac_toe/common/common.dart';
import 'package:tic_tac_toe/controllers/board_controller.dart';
import 'package:tic_tac_toe/widgets/box.dart';
import 'package:tic_tac_toe/widgets/status.dart';

BoardController thisController = Get.put(BoardController());

class GamePage extends StatefulWidget {
  final bool isBot;

  const GamePage({required this.isBot, Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    thisController.isVsBot.value = widget.isBot;
    resetGame();
    if (thisController.isVsBot.value) {
      thisController.turn.value = 'First Move: O';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(thisController.isVsBot.value
            ? 'Playing vs Bot'
            : 'Playing vs Friend')),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue[200]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_BoxContainer(), Status()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await showAlertBox(
              title: 'Reset?',
              content: 'Want to reset the current game?',
              btn1: 'See Board',
              btn2: 'Reset');
          if (res!) {
            resetGame();
          }
        },
        tooltip: 'Restart',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue),
        boxShadow: const [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(7.0, 7.0),
          )
        ],
      ),
      child: Center(
        child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Box(index: index);
          }),
        ),
      ),
    );
  }
}

//-------------------------------------TicTacToe game fns ---------------------------

void resetGame() {
  thisController.currentMoves.value = 0;
  thisController.board.assignAll(['', '', '', '', '', '', '', '', '']);
  thisController.turn.value = 'First Move: X';
  thisController.loading.value = false;
}
//------------------------------ Alerts Dialog --------------------------------------

Future<bool?> showAlertBox(
    {String title = "",
    String content = "",
    String btn1 = "",
    String btn2 = ""}) async {
  return showDialog<bool>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext _context) => AlertDialog(
      title: Text(title.toUpperCase()),
      content: Text(content),
      actions: [
        ElevatedButton(
          child: Text(btn1),
          onPressed: () {
            Navigator.of(Get.context!).pop(false);
          },
        ),
        ElevatedButton(
          child: Text(btn2),
          onPressed: () {
            Navigator.of(Get.context!).pop(true);
          },
        )
      ],
    ),
  );
}
