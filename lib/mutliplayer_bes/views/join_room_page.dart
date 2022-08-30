import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/controllers/socket_methods.dart';

import '../controllers/room_controller.dart';

class JoinRoomScreen extends StatelessWidget {
  //var createRoomController = Get.put(JoinRoomController());
  // var socketMethods = SocketMethods();
  JoinRoomScreen();
  var nameController = TextEditingController();
  var roomIdController = TextEditingController();
  MainControllers mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Join Room',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        blurRadius: 40,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.08),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter your nickname',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.045),
                TextFormField(
                  controller: roomIdController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter your RoomID',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    prefixIcon: Icon(
                      Icons.meeting_room,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.045),
                ElevatedButton(
                  onPressed: () {
                    print(mainController.playerType);
                    mainController.socketMethods
                        .joinRoom(nameController.text, roomIdController.text);
                  },
                  // onPressed: () => mpRoomController.socketMethods.joinRoom(
                  //     mpRoomController.nameController.text,
                  //     mpRoomController.roomIdController.text),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurpleAccent)),
                  child: Text(" JOIN "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
