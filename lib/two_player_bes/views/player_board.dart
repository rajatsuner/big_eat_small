import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controllers/name_controller.dart';
import '../controllers/player_controller.dart';

import '../models/rings.dart';

class PlayerBoard extends StatelessWidget {
  PlayerController playerController = Get.put(PlayerController());

  int playerId;
  PlayerBoard({required this.playerId});

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return GetX<PlayerController>(builder: (controller) {
      return Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: size.width * 0.9, maxHeight: size.height * 0.12),
            child: Container(
                padding: EdgeInsets.all(size.height * 0.01),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: size.height * 0.05,
                    color: controller.pColor[playerId],
                  ),
                  title: GetX<PlayerName>(builder: (nameController) {
                    return Text(
                      '${playerId == 1 ? nameController.player1Name : nameController.player2Name}' +
                          ((controller.playerTurn.value == playerId)
                              ? '✋'
                              : ''),
                      style: TextStyle(
                          color: controller.pColor[playerId],
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 40, color: Colors.blue)
                          ]),
                    );
                  }),
                  trailing: GetX<PlayerController>(builder: (controller) {
                    return Text(
                      'wins: ${controller.winnerCount[playerId - 1]}',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 40, color: Colors.blue)
                          ]),
                    );
                  }),
                )),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: size.width * 0.9, maxHeight: size.height * 0.12),
            child: Container(
                padding: EdgeInsets.all(size.height * 0.01),
                decoration: BoxDecoration(
                    color: Colors.blue.shade500.withOpacity(0.1),
                    // border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Rings(1, pos: 1),
                    Rings(1, pos: 2),
                    Rings(2, pos: 3),
                    Rings(2, pos: 4),
                    Rings(3, pos: 5),
                    Rings(3, pos: 6)
                  ],
                )),
          ),
        ],
      );
    });
    ;
  }

  Widget ringEmpty(int ringType) {
    return CircleAvatar(
      backgroundColor: Colors.blue.withOpacity(0.2),
      radius: size.height * 0.04 * playerController.ringScale[ringType]!,
    );
  }

  Widget Rings(int ringType, {required int pos}) {
    return GetX<PlayerController>(
      builder: ((controller) {
        return controller.ringAvailability[playerId - 1][pos - 1] == 1
            ? controller.playerTurn == playerId
                ? Draggable<List>(
                    data: [playerId, ringType],
                    onDragCompleted: () {
                      controller.ringAvailability[playerId - 1][pos - 1] = 0;
                      playerController.checkMove();
                    },
                    feedback: CircleAvatar(
                      backgroundColor: controller.pColor[playerId],
                      radius: size.height *
                          0.04 *
                          playerController.ringScale[ringType]!,
                      child: Image.asset('assets/ring.png'),
                    ),
                    child: CircleAvatar(
                      backgroundColor: controller.pColor[playerId],
                      radius: size.height *
                          0.04 *
                          playerController.ringScale[ringType]!,
                      child: Image.asset('assets/ring.png'),
                    ),
                    childWhenDragging: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      radius:
                          size.height * 0.04 * controller.ringScale[ringType]!,
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: controller.pColor[playerId],
                    radius: size.height *
                        0.04 *
                        playerController.ringScale[ringType]!,
                    child: Image.asset('assets/ring.png'),
                  )
            : CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.2),
                radius: size.height * 0.04 * controller.ringScale[ringType]!,
              );
      }),
    );
    ;
  }
}
