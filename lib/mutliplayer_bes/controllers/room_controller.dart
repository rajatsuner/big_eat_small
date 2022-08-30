import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/views/waiting_loby_page.dart';

import 'socket_methods.dart';

class MultiPlayerRoomController extends GetxController {
  RxMap<String, dynamic> roomData = <String, dynamic>{}.obs;

  RxMap<int, Color> pColor = {
    1: Colors.deepOrange,
    2: Colors.deepPurpleAccent,
  }.obs;

  var isGame = false.obs;

  RxInt playerType = 0.obs;

  RxMap<num, num> ringScale = {3: 1, 2: 0.8, 1: 0.6}.obs;

  var winnerId = 0.obs;
  var winnerCount = [0, 0].obs;

  var blockPlayerId = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  var blockRingColor = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ].obs;
  var blockRingType = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;

  var ringAvailability = [
    [1, 1, 1, 1, 1, 1].obs,
    [1, 1, 1, 1, 1, 1].obs
  ].obs;

  var playerTurn = 1.obs;

  var numOfMoves = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    print("MULTIPLAY DELETE HOLARE");
    return super.onDelete;
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   roomIdController.dispose();
  //   super.dispose();
  // }

  var winningLines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  void setBlockRing(
      {required int player,
      required int ringType,
      required int blockNumber,
      required int ringPos}) {
    blockRingColor[blockNumber] = pColor[player]!;
    blockRingType[blockNumber] = ringType;
    blockPlayerId[blockNumber] = player;
    ringAvailability[player - 1][ringPos - 1] = 0;
    checkMove();
  }

  void setBlockRingLocal({
    required int player,
    required int ringType,
    required int blockNumber,
  }) {
    blockRingColor[blockNumber] = pColor[player]!;
    blockRingType[blockNumber] = ringType;
    blockPlayerId[blockNumber] = player;
  }

  int checkMove() {
    numOfMoves += 1;
    for (int i = 0; i < 8; i++) {
      int count1 = 0;
      int count2 = 0;
      for (var j = 0; j < 3; j++) {
        if (blockPlayerId[winningLines[i][j]] == 1) {
          count1++;
        } else if (blockPlayerId[winningLines[i][j]] == 2) {
          count2++;
        }
        if (count1 == 3) {
          count1 = 0;
          winnerId.value = 1;
          winnerCount[0] += 1;
          showWinner();
          return 0;
        } else if (count2 == 3) {
          count2 = 0;
          winnerId.value = 2;
          winnerCount[1] += 1;

          showWinner();
          return 0;
        }
      }
    }

    int res = checkTie(); //1 for tie //0 for no tie
    if (res == 1) {
      showTieDialog();
    }

    if (playerTurn.value == 1) {
      playerTurn.value = 2;
    } else {
      playerTurn.value = 1;
    }
    return 0;
  }

  int checkTie() {
    if (numOfMoves >= 12) {
      return 1;
    }

    for (var element in blockPlayerId) {
      if (element == 0) {
        return 0;
      }
    }

    return 1;
  }

  showTieDialog() {
    Get.dialog(
        Center(
            child: AlertDialog(
          backgroundColor: Color.fromARGB(255, 13, 41, 54).withOpacity(0.9),
          title: Text(
            "Hurray",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Its TIE',
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  MainControllers mainControllers = Get.find();
                  mainControllers.socketMethods
                      .endGame(roomId: roomData['_id']);
                },
                child: Text(
                  "Exit",
                )),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  MainControllers mainControllers = Get.find();
                  mainControllers.socketMethods
                      .newGame(roomId: roomData['_id']);
                },
                child: Text(
                  "Continue Play",
                )),
          ],
        )),
        barrierDismissible: false);
  }

  void showWinner() {
    Get.dialog(
        Center(
            child: AlertDialog(
          backgroundColor: Color.fromARGB(255, 13, 41, 54).withOpacity(0.9),
          title: Text(
            "Congratulations",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Player - ${roomData["players"][winnerId.value - 1]['nickname']} won this turn',
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  MainControllers mainControllers = Get.find();
                  mainControllers.socketMethods
                      .endGame(roomId: roomData['_id']);
                },
                child: Text(
                  "Exit",
                )),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  MainControllers mainControllers = Get.find();
                  mainControllers.socketMethods
                      .newGame(roomId: roomData['_id']);
                },
                child: Text(
                  "Continue Play",
                )),
          ],
        )),
        barrierDismissible: false);
  }

  void newGame() {
    Get.back();
    numOfMoves.value = 0;
    blockRingColor.value = [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent
    ];
    blockPlayerId.value = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    blockRingType.value = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    for (var i = 0; i < 6; i++) {
      ringAvailability[0][i] = 1;
      ringAvailability[1][i] = 1;
    }
  }

  void resetGame() {
    newGame();
    playerTurn.value = 1;
    numOfMoves.value = 0;
    isGame.value = false;
    winnerId.value = 0;
    winnerCount.value = [0, 0];
  }
}
