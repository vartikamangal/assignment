import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/wheel-of-life-controller.dart';

class WheelOfLifeScreen extends StatelessWidget {
  final _controller = Get.find<WheelOfLifeController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
        leading: IconButton(
         onPressed: () {
           _controller.currentOnBoardPageCounter.value == 0
               ? Navigator.popAndPushNamed(context, RouteName.hubScreen)
               : _controller.navigateBack();
           },
          icon: const Icon(Icons.arrow_back_ios,),
          color: blueDarkShade,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
              top: ScaleManager.spaceScale(
                spaceing: 0,
              ).value,
              child: Container(
                padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 42,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 38,
                  ).value,
                ),
                width: Get.width,
                child: Obx(() => _controller.currentSelectedPage.value),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: ScaleManager.spaceScale(
                      spaceing: 10,
                    ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: Get.width * 0.075,
                    ).value,
                  ),
                  child: Obx(() {
                    if (_controller.currentOnBoardPageCounter.value == 0) {
                      return BottomMiddleButton(
                        title: 'MAKES SENSE',
                        onPressed: () => _controller.changeScreen(),
                      );
                    } else if (_controller.currentOnBoardPageCounter.value ==
                        1) {
                      return BottomMiddleButton(
                        title: 'DONE',
                        onPressed: () => _controller.changeScreen(),
                      );
                    } else {
                      return _controller.showBottomButton.value
                          ? BottomMiddleButton(
                              title: 'DONE',
                              // ignore: avoid_print
                              onPressed: () async =>
                                  _controller.rateSatisfactionAndMoveAhead(),
                            )
                          : Container();
                    }
                  }),
                ),
              ),
            ),
            Obx(
              () => _controller.isProcessing.value
                  ? const LinearProgressIndicator()
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
