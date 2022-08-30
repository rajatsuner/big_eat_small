import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../views/game_page.dart';

class PlayerName extends GetxController {
  late TextEditingController player1NameController, player2NameController;

  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();

  var player1Name = ''.obs;
  var player2Name = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    player1NameController = TextEditingController();
    player2NameController = TextEditingController();
  }

  @override
  void dispose() {
    player1NameController.dispose();
    player2NameController.dispose();
    super.dispose();
  }

  String? player1Validate(String value) {
    if (value.length < 3 || value.length > 10) {
      return "name be 3-10 characters";
    }
    return null;
  }

  String? player2Validate(String value) {
    if (value.length < 3 || value.length > 10) {
      return "name be 3-10 characters";
    }
    return null;
  }

  checkNames() {
    print("CHECK NAMES");
    var isValid = nameFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    nameFormKey.currentState!.save();
    Get.back();
    Get.to(GamePage());
  }
}
