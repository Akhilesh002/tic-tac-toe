import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/common/common.dart';
import 'package:tic_tac_toe/controllers/board_controller.dart';
import 'package:tic_tac_toe/screens/board_screen.dart';

class Box extends StatelessWidget {
  Box({required this.index, Key? key}) : super(key: key);
  final int index;

  BoardController thisController = Get.put(BoardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white38),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        ),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.blue)),
          child: InkWell(
            child: Center(
              child: Text(
                thisController.board[index].toUpperCase(),
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        onPressed: () {
          if (thisController.board[index] == '') {
            if (!thisController.isVsBot.value) {
              if (thisController.currentMoves.value % 2 == 0) {
                thisController.board[index] = 'x';
              } else {
                thisController.board[index] = 'o';
              }
            } else if (!thisController.loading.value) {
              thisController.loading.value = true;
              thisController.board[index] = 'o';
              if (thisController.currentMoves.value >= 8) {
              } else {
                _bestMove(thisController.board);
              }
              //print(_board);
            }
            //print(vsBot);
            pressed();
          }
        }));
  }

  void pressed() async {
    print(thisController.currentMoves.value);
    thisController.currentMoves.value++;
    if (_checkGame()) {
      var res = await showAlertBox(
          title: '${Common.winner} won!',
          content: 'Start a new Game?',
          btn1: 'Exit',
          btn2: 'New Game');
      resetGame();
    } else if (thisController.currentMoves.value >= 9) {
      var res = await showAlertBox(
          title: 'It\'s a Draw',
          content: 'Want to try again?',
          btn1: 'See Board',
          btn2: 'New Game');
      if (res!) {
        resetGame();
      }
    }
    if (thisController.currentMoves.value % 2 == 0) {
      thisController.turn.value = 'Turn: O';
    } else {
      thisController.turn.value = 'Turn: X';
    }
  }

  bool _checkGame() {
    for (int i = 0; i < 9; i += 3) {
      if (thisController.board[i] != '' &&
          thisController.board[i] == thisController.board[i + 1] &&
          thisController.board[i + 1] == thisController.board[i + 2]) {
        Common.winner = thisController.board[i];
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (thisController.board[i] != '' &&
          thisController.board[i] == thisController.board[i + 3] &&
          thisController.board[i + 3] == thisController.board[i + 6]) {
        Common.winner = thisController.board[i];
        return true;
      }
    }
    if (thisController.board[0] != '' &&
            (thisController.board[0] == thisController.board[4] &&
                thisController.board[4] == thisController.board[8]) ||
        (thisController.board[2] != '' &&
            thisController.board[2] == thisController.board[4] &&
            thisController.board[4] == thisController.board[6])) {
      Common.winner = thisController.board[4];
      return true;
    }
    return false;
  }

  int _bestMove(List<String> _board) {
    int bestMove = -1000;
    int moveVal;
    int i;
    int? bi;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        moveVal = -1000;
        _board[i] = Common.player;
        moveVal = Common.minMax(_board, 0, false);
        _board[i] = '';
        if (moveVal > bestMove) {
          bestMove = moveVal;
          bi = i;
        }
      }
    }
    _board[bi!] = Common.player;
    thisController.loading.value = false;
    thisController.turn.value = 'Turn: X';
    thisController.currentMoves.value++;
    return bestMove;
  }
}
