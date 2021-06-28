// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/auth/presentation/controller/auth-controller.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/splash-screen-elements.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/RoundButton.dart';

class OpeningScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: ScaleManager.spaceScale(spaceing: 411).value,
        child: Stack(
          children: [
            const SplashScreenElements(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScaleManager.spaceScale(
                  spaceing: 55,
                ).value,
                margin: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 55,
                  ).value,
                ),
                child: Obx(
                  () => _authController.isProcessing.value
                      ? EmptySpacePlaceHolder()
                      : RoundButton(
                          color: Colors.white,
                          onPressed: () async {
                            await _authController.signup(
                              redirectRoute: RouteName.rapportPages,
                            );
                          },
                          title: "LET'S START",
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 23,
                  ).value,
                ),
                child: Obx(
                  () => _authController.isProcessing.value
                      ? const MiniLoader()
                      : InkWell(
                          onTap: () async {
                            // DO LOGIN HERE
                            await _authController.login();
                          },
                          child: Text(
                            "LOG IN",
                            style: GoogleFonts.zillaSlab(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.height * 0.022,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
