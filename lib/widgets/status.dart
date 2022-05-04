import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controllers/board_controller.dart';

class Status extends StatelessWidget {
  Status({Key? key}) : super(key: key);

  BoardController thisController = Get.put(BoardController());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(40),
      child: Container(
        width: 220,
        height: 60,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          thisController.turn.value,
          style: const TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
