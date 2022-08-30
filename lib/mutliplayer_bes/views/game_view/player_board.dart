import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';

class PlayerBoard extends StatelessWidget {
  MultiPlayerRoomController gameController = Get.find();

  int playerId;
  PlayerBoard({required this.playerId});

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return GetX<MultiPlayerRoomController>(builder: (controller) {
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
                    color: gameController.pColor[playerId],
                  ),
                  title: GetX<MultiPlayerRoomController>(
                      builder: (nameController) {
                    return Text(
                      "${gameController.roomData['players'][playerId - 1]['nickname']} " +
                          ((gameController.playerTurn.value == playerId)
                              ? '✋'
                              : ''),
                      style: TextStyle(
                          color: gameController.pColor[playerId],
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 40, color: Colors.blue)
                          ]),
                    );
                  }),
                  trailing:
                      GetX<MultiPlayerRoomController>(builder: (controller) {
                    return Text(
                      'wins: ${gameController.winnerCount[playerId - 1]}',
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
      radius: size.height * 0.04 * gameController.ringScale[ringType]!,
    );
  }

  Widget Rings(int ringType, {required int pos}) {
    return GetX<MultiPlayerRoomController>(
      builder: ((controller) {
        return gameController.ringAvailability[playerId - 1][pos - 1] == 1
            ? gameController.playerTurn == playerId &&
                    gameController.playerType == playerId
                ? Draggable<List>(
                    data: [playerId, ringType, pos],
                    onDragCompleted: () {
                      gameController.ringAvailability[playerId - 1][pos - 1] =
                          0;
                    },
                    feedback: CircleAvatar(
                      backgroundColor: gameController.pColor[playerId],
                      radius: size.height *
                          0.04 *
                          gameController.ringScale[ringType]!,
                      child: Image.asset('assets/ring.png'),
                    ),
                    child: CircleAvatar(
                      backgroundColor: gameController.pColor[playerId],
                      radius: size.height *
                          0.04 *
                          gameController.ringScale[ringType]!,
                      child: Image.asset('assets/ring.png'),
                    ),
                    childWhenDragging: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      radius: size.height *
                          0.04 *
                          gameController.ringScale[ringType]!,
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: gameController.pColor[playerId],
                    radius: size.height *
                        0.04 *
                        gameController.ringScale[ringType]!,
                    child: Image.asset('assets/ring.png'),
                  )
            : CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.2),
                radius:
                    size.height * 0.04 * gameController.ringScale[ringType]!,
              );
      }),
    );
    ;
  }
}
