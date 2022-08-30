import 'dart:async';
import 'package:get/get.dart';
import 'home_page.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GoToHome();
  }

  void GoToHome() {
    Timer(Duration(seconds: 3), () {
      Get.off(HomePage());
    });
  }
}
