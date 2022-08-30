import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controllers/player_controller.dart';

class TicTacToeBoard extends StatelessWidget {
  var playerController = Get.put(PlayerController());

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
                  return data![1] > playerController.blockRingType[index];
                },
                onAccept: (List data) {
                  print('ACCEPTED $data');
                  playerController.setBlockRing(
                      player: data[0], ringType: data[1], blockNumber: index);
                  print(playerController.blockPlayerId);
                  print(playerController.blockRingType);
                  print(playerController.blockRingColor);
                },
                builder: (BuildContext context, List<dynamic> accepted,
                    List<dynamic> rejected) {
                  return GetX<PlayerController>(builder: (controller) {
                    return controller.blockPlayerId[index] != 0
                        ? CircleAvatar(
                            backgroundColor: controller.blockRingColor[index],
                            radius: size.height *
                                0.04 *
                                controller.ringScale[
                                    controller.blockRingType[index]]!,
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
