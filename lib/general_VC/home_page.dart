import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';
import 'package:getbase/mutliplayer_bes/views/create_room_page.dart';
import 'package:getbase/player_vs_computer_bes/views/game_page.dart';

import '../mutliplayer_bes/views/join_room_page.dart';
import '../two_player_bes/controllers/name_controller.dart';

class HomePage extends StatelessWidget {
  var nameController = Get.put(PlayerName());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 1,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              'assets/logo2.png',
              scale: 1,
              errorBuilder: (context, error, stackTrace) => Text('3t'),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 13, 41, 54),
          title: Text(
            'Big Eat Small',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  exit(0);
                },
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.redAccent,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            gameTile(0),
            gameTile(1),
            gameTile(2)
          ],
        ));
  }

  var typeDataList = [
    {
      "id": 0,
      "title": "Big Eat Small",
      "type1": "2 Player Single Device",
      "type2": "Offline game",
    },
    {
      "id": 1,
      "title": "Big Eat Small",
      "type1": "2 Player Multi Device",
      "type2": "Online game",
    },
    {
      "id": 2,
      "title": "Big Eat Small",
      "type1": "User Vs Computer",
      "type2": "Offline game"
    }
  ];
  var type2Color = [
    Colors.deepOrangeAccent,
    Colors.greenAccent,
    Colors.deepOrangeAccent
  ];

  openOnlineMulti() {
    Get.dialog(
        AlertDialog(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 13, 41, 54).withOpacity(0.9),
          title: Text(
            "MultiPlayer Online",
            style: TextStyle(color: Colors.white),
          ),
          content: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: Get.width * 0.9,
                  minWidth: Get.width * 0.9,
                  minHeight: Get.height * 0.2,
                  maxHeight: Get.height * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 25, 129, 177).withOpacity(1),
                            )),
                        onPressed: () {
                          Get.back();

                          var mainController = Get.put(MainControllers());
                          mainController.playerType.value = 1;

                          Get.to(CreateRoomScreen())?.whenComplete(() {
                            print("HOME PAGE HOLERA :::::");
                          }).whenComplete(
                              () => print("HOMEPAGE HOLERA ::loby"));
                        },
                        child: Text(
                          "Create Room",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    width: Get.width * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 25, 129, 177).withOpacity(1),
                            )),
                        onPressed: () {
                          Get.back();

                          var mainController = Get.put(MainControllers());
                          mainController.playerType.value = 2;

                          Get.to(JoinRoomScreen());
                        },
                        child: Text(
                          "Join Room",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
        ),
        barrierDismissible: true);
  }

  openOfflineMulti() {
    Get.dialog(
        AlertDialog(
          backgroundColor: Color.fromARGB(255, 13, 41, 54).withOpacity(0.9),
          title: Text(
            "Enter players name",
            style: TextStyle(color: Colors.white),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: Get.height * 0.2, maxHeight: Get.height * 0.3),
            child: Container(
              child: Center(
                child: Form(
                  key: nameController.nameFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: nameController.player1NameController,
                        style: TextStyle(color: Colors.white),
                        onSaved: (value) {
                          nameController.player1Name.value = value!;
                        },
                        decoration: InputDecoration(
                          labelText: 'Player 1',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        validator: (value) {
                          return nameController.player1Validate(value!);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: nameController.player2NameController,
                        style: TextStyle(color: Colors.white),
                        onSaved: (value) {
                          nameController.player2Name.value = value!;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Player 2',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        validator: (value) {
                          return nameController.player2Validate(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  // newGame();
                  // Get.back(canPop: true);
                  Get.back();
                },
                child: Text(
                  "Back",
                )),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  //  Get.back();
                  nameController.checkNames();
                },
                child: Text(
                  "Start Game",
                )),
          ],
        ),
        barrierDismissible: true);
  }

  openUserVsComputer() {
    Get.to(ComputerGamePage());
  }

  void gameChoice(int index) {
    switch (index) {
      case 0:
        openOfflineMulti();
        break;
      case 1:
        openOnlineMulti();
        break;
      case 2:
        openUserVsComputer();
        break;
      default:
        break;
    }
  }

  Widget gameTile(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 1, color: Color.fromARGB(255, 32, 84, 100)),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/type_banner.png"))),
      height: Get.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
              title: Text(
                '${typeDataList[index]['title']}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text("~ ${typeDataList[index]['type1']}",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold))),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("~ ${typeDataList[index]['type2']}",
                    style: TextStyle(
                        color: type2Color[index], fontWeight: FontWeight.bold)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      gameChoice(index);
                    },
                    child: Text("Play Now")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
