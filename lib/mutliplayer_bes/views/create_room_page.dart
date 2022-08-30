import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';

import '../controllers/socket_methods.dart';

class CreateRoomScreen extends StatelessWidget {
  //SocketMethods socketMethods = SocketMethods();

  var nameController = TextEditingController();
  MainControllers mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Create Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  shadows: [
                    Shadow(
                      blurRadius: 40,
                      color: Colors.blue,
                    ),
                  ],
                )),
            SizedBox(height: size.height * 0.08),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter your nickname',
                labelStyle: TextStyle(color: Colors.white),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.045),
            ElevatedButton(
              onPressed: () {
                print(mainController.playerType);
                mainController.socketMethods.createRoom(nameController.text);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
              child: Text(" CREATE "),
            ),
          ],
        ),
      ),
    );
  }
}
