import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComputerGameController extends GetxController {
  RxMap<int, Color> pColor =
      {1: Colors.deepPurpleAccent, 2: Colors.deepOrange}.obs;

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

  var playerTurn = 2.obs;
  var numOfMoves = 0.obs;

  var playerName = {1: "Computer", 2: "User"};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
      {required int player, required int ringType, required int blockNumber}) {
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

    if (playerTurn.value == 2) {
      playerTurn.value = 1;
      computerMove();
    } else {
      playerTurn.value = 2;
    }

    return 0;
  }

  computerMove() {}

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
                  Get.close(2);
                },
                child: Text(
                  "Exit",
                )),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  newGame();
                  Get.back();
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
          content: GetX<ComputerGameController>(builder: (nameController) {
            return Text(
              '${playerName[winnerId]} - won this turn',
              style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
            );
          }),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  Get.close(2);
                },
                child: Text(
                  "Exit",
                )),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  newGame();
                  Get.back();
                },
                child: Text(
                  "Continue Play",
                )),
          ],
        )),
        barrierDismissible: false);
  }

  void newGame() {
    playerTurn.value = 2;
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
}
