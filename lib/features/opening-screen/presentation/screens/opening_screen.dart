import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/RoundButton.dart';
import '../widgets/images_positioning.dart';
import '../widgets/rings.dart';
import '../widgets/upper_layer.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Rounds(),
            ImagePositioning(),
            UpperLayer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 55,
                  ).value,
                ),
                child: RoundButton(
                  color: Colors.white,
                  onPressed: () {
                    // ignore: avoid_print
                    print("button is pressed");
                    Navigator.of(context).pushReplacementNamed(
                      RouteName.rapportPages,
                    );
                  },
                  title: "LET'S START",
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(spaceing: 23).value,
                ),
                child: InkWell(
                  onTap: () async {},
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
          ],
        ),
      )),
    );
  }
}
