import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';
import '3t_board.dart';
import 'player_board.dart';

class MultiGamePage extends StatelessWidget {
  MultiPlayerRoomController gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        var isExit = false;
        await Get.dialog(
            Center(
                child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 13, 41, 54).withOpacity(0.9),
              title: Text(
                "Are you Sure!!",
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Do you want to quit game ? ',
                style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent)),
                    onPressed: () {
                      isExit = true;
                      Get.back();
                    },
                    child: Text(
                      "Exit",
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      isExit = false;
                      Get.back();
                    },
                    child: Text(
                      "Continue Play",
                    )),
              ],
            )),
            barrierDismissible: true);
        return isExit;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 41, 54),
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PlayerBoard(
              playerId: gameController.playerType.value == 1 ? 2 : 1,
            ),
            TicTacToeBoard(),
            PlayerBoard(
              playerId: gameController.playerType.value,
            ),
          ],
        ))),
      ),
    );
  }
}
