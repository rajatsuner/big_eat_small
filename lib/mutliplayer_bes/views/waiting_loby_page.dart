import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';

class WaitingLobyScreen extends StatelessWidget {
  // Map<String, dynamic> roomData;
  int playerType;

  WaitingLobyScreen({required this.playerType});

  MainControllers mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 1,
        title: Text(
          'Game Loby',
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 40,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GetX<MainControllers>(builder: (controller) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 10 + 10, right: 10 + 10, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.deepOrange, width: 3)),
                  child: ListTile(
                    onTap: () {
                      print(
                          "BAIT LOBY  PLAYER TYPE : ${mainController.playerType}");
                      print("ROOM DATA : : ${mainController.roomData}");
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                    ),
                    title: Text(
                      // '${mainController.roomData['players'][0]['nickname']}',
                      "${mainController.roomData['isP1Joined'] ? mainController.roomData['players'][0]['nickname'] : '-------'}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        mainController.roomData['isP1Joined']
                            ? 'Joined'
                            : 'Waiting',
                        style: TextStyle(
                          color: mainController.roomData['isP1Joined']
                              ? Colors.green
                              : Colors.redAccent,
                        )),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10 + 10, right: 10 + 10, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: Colors.deepPurpleAccent, width: 3)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    title: Text(
                      '${mainController.roomData['isP2Joined'] ? mainController.roomData['players'][1]['nickname'] : '-------'}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        mainController.roomData['isP2Joined']
                            ? 'Joined'
                            : 'Waiting',
                        style: TextStyle(
                          color: mainController.roomData['isP2Joined']
                              ? Colors.green
                              : Colors.redAccent,
                        )),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10 + 10, right: 10 + 10, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    //  border: Border.all(color: Colors.green, width: 1)
                  ),
                  child: ListTile(
                    onTap: () {},
                    // leading: CircleAvatar(
                    //   backgroundColor: Colors.transparent,
                    //   child: Icon(
                    //     Icons.meeting_room,
                    //     color: Colors.green,
                    //   ),
                    // ),
                    title: Text(
                      'Room ID ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${mainController.roomData['_id']}",
                        style: TextStyle(
                          color: Colors.green,
                        )),
                    trailing: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: mainController.roomData['_id']));
                      },
                      child: Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                mainController.roomData['isP1Joined'] &&
                        mainController.roomData['isP2Joined']
                    ? Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 40,
                        decoration: BoxDecoration(
                            // color: Colors.limeAccent,
                            shape: BoxShape.rectangle),
                        child: Center(
                            child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            mainController.socketMethods.startGame(
                                roomId: mainController.roomData['_id']);
                          },
                          child: Text(
                            " Play Game ",
                            style: TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        )),
                      )
                    : Container(),
              ],
            )),
          );
        }),
      ),
    );
  }
}
