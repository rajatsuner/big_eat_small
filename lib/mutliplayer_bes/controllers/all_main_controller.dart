import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getbase/mutliplayer_bes/controllers/socket_methods.dart';
import 'package:getbase/mutliplayer_bes/views/game_view/multi_game_page.dart';

import 'room_controller.dart';

class MainControllers extends GetxController {
  var isPlayerLeftBetween = false;

  var playerType = 0.obs;
  var timerValue = 5.obs;

  var createRoomController, joinRoomController, waitingLobyController;

  var socketMethods = SocketMethods();

  RxMap<String, dynamic> roomData = <String, dynamic>{}.obs;

  MultiPlayerRoomController gameController =
      Get.put(MultiPlayerRoomController());

  @override
  void onClose() {
    // TODO: implement onClose
    print("CLOSE HOLERA");

    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    print("DELETE HOLERA finally ");

    return super.onDelete;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("READY HOLERA :: ");
  }

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("PLAYER TYPE  :: $playerType");
    socketMethods.createRoomSuccessListener();
    socketMethods.joinRoomSuccessListener();
    socketMethods.updateRoomListener();
    socketMethods.startGameListener();
    socketMethods.moveListener();
    socketMethods.startNewGameListener();
    socketMethods.endGameListener();
    socketMethods.playerLeaveListener();
    socketMethods.errorListener();
  }

  // startGameTimer() {
  //   gameController.roomData = roomData;
  //   gameController.playerType.value = playerType.value;
  //   timerValue.value = 5;
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     timerValue.value -= 1;
  //     if (timerValue.value == 0) {
  //       timer.cancel();
  //       Get.off(MultiGamePage());
  //     }
  //   });
  // }

  // static MainControllers get instance {
  //   return _instance!;
  // }
}
