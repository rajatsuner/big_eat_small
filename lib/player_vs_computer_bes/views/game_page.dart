import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '3t_board.dart';
import 'player_board.dart';

import '../controllers/computer_game_controller.dart';
import '../models/rings.dart';

class ComputerGamePage extends StatelessWidget {
  ComputerGameController playerController = Get.put(ComputerGameController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 41, 54),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlayerBoard(
            playerId: 1,
          ),
          TicTacToeBoard(),
          PlayerBoard(
            playerId: 2,
          ),
        ],
      ))),
    );
  }
}
