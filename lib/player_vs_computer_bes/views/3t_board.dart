import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controllers/computer_game_controller.dart';

class TicTacToeBoard extends StatelessWidget {
  ComputerGameController comGameController = Get.find();

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
                  return data![1] > comGameController.blockRingType[index];
                },
                onAccept: (List data) {
                  print('ACCEPTED $data');
                  comGameController.setBlockRing(
                      player: data[0], ringType: data[1], blockNumber: index);
                },
                builder: (BuildContext context, List<dynamic> accepted,
                    List<dynamic> rejected) {
                  return GetX<ComputerGameController>(builder: (controller) {
                    return comGameController.blockPlayerId[index] != 0
                        ? CircleAvatar(
                            backgroundColor:
                                comGameController.blockRingColor[index],
                            radius: size.height *
                                0.04 *
                                comGameController.ringScale[
                                    comGameController.blockRingType[index]]!,
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
