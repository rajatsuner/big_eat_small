import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getbase/constants.dart';
import 'package:getbase/general_VC/home_page.dart';
import 'package:getbase/mutliplayer_bes/controllers/all_main_controller.dart';
import 'package:getbase/mutliplayer_bes/controllers/room_controller.dart';
import 'package:getbase/mutliplayer_bes/views/waiting_loby_page.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../views/game_view/multi_game_page.dart';
import 'socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    print("PROROOROR $nickname");
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void startGame({required String roomId}) {
    _socketClient.emit('startGameEmit', {"roomId": roomId});
  }

  void move(
      {required int playerType,
      required int ringType,
      required int blockNumber,
      required int ringPos,
      required String roomId}) {
    _socketClient.emit('move', {
      'playerType': playerType,
      'ringType': ringType,
      'blockNumber': blockNumber,
      'ringPos': ringPos,
      'roomId': roomId
    });
    print("MOVE EMIT DONE :::  $playerType");
  }

  void newGame({required String roomId}) {
    _socketClient.emit('newGame', {'roomId': roomId});
  }

  void endGame({required String roomId}) {
    _socketClient.emit('endGame', {'roomId': roomId});
  }

  void playerLeaves({required String roomId, required int playerType}) {
    _socketClient
        .emit("playerLeaves", {"roomId": roomId, "playerType": playerType});
    MultiPlayerRoomController mprc = Get.find();
    mprc.resetGame();
  }

  // void tapGrid(int index, String roomId, List<String> displayElements) {
  //   if (displayElements[index] == '') {
  //     _socketClient.emit('tap', {
  //       'index': index,
  //       'roomId': roomId,
  //     });
  //   }
  // }

  // LISTENERS
  void createRoomSuccessListener() async {
    _socketClient.on('createRoomSuccess', (room) {
      print("HELLO BROTHER CREATE ROOM  :: ${room}");
      MainControllers controllers = Get.find();
      controllers.roomData.value = room;
      controllers.isPlayerLeftBetween = true;
      MultiPlayerRoomController gameController = Get.find();
      if (controllers.playerType == 1) {
        Get.off(WaitingLobyScreen(playerType: 1))?.whenComplete(() =>
            !gameController.isGame.value
                ? playerLeaves(
                    roomId: room["_id"],
                    playerType: controllers.playerType.value)
                : {});
      }
    });
  }

  void joinRoomSuccessListener() {
    _socketClient.on('joinRoomSuccess', (room) {
      MainControllers controllers = Get.find();
      controllers.roomData.value = room;
      controllers.isPlayerLeftBetween = true;
      MultiPlayerRoomController gameController = Get.find();
      if (controllers.playerType == 2) {
        Get.off(WaitingLobyScreen(playerType: 2))?.whenComplete(() =>
            !gameController.isGame.value
                ? playerLeaves(
                    roomId: room["_id"],
                    playerType: controllers.playerType.value)
                : {});
      }
    });
  }

  void startGameListener() {
    _socketClient.on('startGameListener', (data) {
      MultiPlayerRoomController gameController = Get.find();
      MainControllers mainController = Get.find();
      gameController.roomData = mainController.roomData;
      gameController.playerType.value = mainController.playerType.value;
      gameController.isGame.value = true;
      Get.off(MultiGamePage())?.whenComplete(() => playerLeaves(
          roomId: mainController.roomData["_id"],
          playerType: mainController.playerType.value));
    });
  }

  void moveListener() {
    MultiPlayerRoomController gameController = Get.find();
    _socketClient.on('moveSuccess', (moveDetail) {
      gameController.setBlockRing(
          player: moveDetail['playerType'],
          ringType: moveDetail['ringType'],
          blockNumber: moveDetail['blockNumber'],
          ringPos: moveDetail['ringPos']);
      //  gameController.setBlockRing();
      print("MOVE LISNETE ${moveDetail['playerType']}");
    });
  }

  startNewGameListener() {
    MultiPlayerRoomController gameController = Get.find();
    _socketClient.on('startNewGame', (data) {
      print("START NEW GAME LISTENER");
      gameController.newGame();
    });
  }

  endGameListener() {
    MultiPlayerRoomController gameController = Get.find();
    _socketClient.on('endGameDone', (data) {
      print("END GAME LISTENER");
      Get.close(2);
    });
  }

  // void errorOccuredListener(BuildContext context) {
  //   _socketClient.on('errorOccurred', (data) {
  //     showSnackBar(context, data);
  //   });
  // }

  // void updatePlayersStateListener(BuildContext context) {
  //   _socketClient.on('updatePlayers', (playerData) {
  //     Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
  //       playerData[0],
  //     );
  //     Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
  //       playerData[1],
  //     );
  //   });
  // }

  void updateRoomListener() {
    _socketClient.on('updateRoom', (data) {
      MainControllers controllers = Get.find();
      controllers.roomData.value = data;
      //controllers.startGameTimer();
    });
  }

  void playerLeaveListener() {
    _socketClient.on('allPlayerLeave', (data) {
      print("DISCONNECT LISTENER $data");
      MainControllers controllers = Get.find();
      if (data["playerType"] != controllers.playerType) {
        // Get.deleteAll(force: true);
        Get.off(HomePage());
      }
    });
  }

  void errorListener() {
    _socketClient.on('errorOccurred', (data) {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 2),
        icon: Icon(
          Icons.warning,
          color: Colors.redAccent,
        ),
        backgroundColor: bgColor,
        message: "",
        messageText: Text(""),
        title: data,
      ));
    });
  }
}
