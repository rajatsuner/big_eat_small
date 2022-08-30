import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';

import '../../controllers/room_controller.dart';

class TicTacToeBoard extends StatelessWidget {
  MultiPlayerRoomController gameController = Get.find();
  MainControllers mainControllers = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height * 0.4,
            maxHeight: MediaQuery.of(context).size.height * 0.4),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                //   color: Colors.blue.withOpacity(0.05),
                border: Border.all(
                  color: Colors.white24,
                ),
              ),
              child: Center(
                  child: DragTarget<List>(
                onWillAccept: (data) {
                  return data![1] > gameController.blockRingType[index];
                },
                onAccept: (List data) {
                  print('ACCEPTED $data');
                  mainControllers.socketMethods.move(
                      playerType: data[0],
                      ringType: data[1],
                      blockNumber: index,
                      ringPos: data[2],
                      roomId: gameController.roomData['_id']);
                  gameController.setBlockRingLocal(
                      player: data[0], ringType: data[1], blockNumber: index);

                  // print(gameController.blockPlayerId);
                  // print(gameController.blockRingType);
                  // print(gameController.blockRingColor);
                  // MainControllers mainControllers = Get.find();
                  // mainControllers.socketMethods.move(
                  //     playerType: data[0],
                  //     ringType: data[1],
                  //     blockNumber: index);
                },
                builder: (BuildContext context, List<dynamic> accepted,
                    List<dynamic> rejected) {
                  return GetX<MultiPlayerRoomController>(builder: (controller) {
                    return gameController.blockPlayerId[index] != 0
                        ? CircleAvatar(
                            backgroundColor:
                                gameController.blockRingColor[index],
                            radius: size.height *
                                0.04 *
                                gameController.ringScale[
                                    gameController.blockRingType[index]]!,
                            child: Image.asset('assets/ring.png'),
                          )
                        : Container();
                  });
                },
              )),
            );
          },
        ));
  }
}
