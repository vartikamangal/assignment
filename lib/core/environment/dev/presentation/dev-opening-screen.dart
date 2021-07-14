import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/RoundButton.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/splash-screen-elements.dart';
import 'package:tatsam_app_experimental/features/root/presentation/controller/root-controller.dart';

class DevOpeningScreen extends StatelessWidget {
  const DevOpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RootController _rootController = Get.find();

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
                child: RoundButton(
                  color: Colors.white,
                  onPressed: () async {
                    _rootController.performBasicNavigation();
                  },
                  title: "Continue",
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.listAllActivities);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: ScaleManager.spaceScale(
                      spaceing: 23,
                    ).value,
                  ),
                  child: Text(
                    "Goto Content Test Screen",
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
          ],
        ),
      ),
    );
  }
}
