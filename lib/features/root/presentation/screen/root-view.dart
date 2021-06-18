import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/splash-screen-elements.dart';
import '../controller/root-controller.dart';

class RootView extends GetWidget<RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: ScaleManager.spaceScale(spaceing: 411).value,
        child: Stack(
          children: [
            const SplashScreenElements(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 23,
                  ).value,
                ),
                child: const MiniLoader(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
