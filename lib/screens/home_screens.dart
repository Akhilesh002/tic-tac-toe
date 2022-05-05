import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'board_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TicTacToe"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB3E5FC),
              Color(0xFF2196F3),
            ],
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.close,
                    size: 140,
                    color: Colors.lightBlue[800],
                  ),
                  Icon(
                    Icons.radio_button_unchecked,
                    size: 108,
                    color: Colors.lightBlue[800],
                  )
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white38),
                      ),
                      child: SizedBox(
                          width: 130,
                          child: Center(
                            child: Text(
                              'vs Bot',
                              style: TextStyle(
                                  color: Colors.lightBlue[800], fontSize: 30),
                            ),
                          )),
                      onPressed: () {
                        Get.to(() => const GamePage(isBot: true));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
