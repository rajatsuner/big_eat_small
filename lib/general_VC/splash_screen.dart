import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getbase/general_VC/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashScreenController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 13, 41, 54),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 12, 39, 61),
                      Color.fromARGB(255, 13, 41, 54),
                    ]),
              ),
              child: Center(
                child: FittedBox(
                  child: Image.asset(
                    fit: BoxFit.scaleDown,
                    "assets/logo2.png",
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    //    height: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
