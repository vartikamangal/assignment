// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/utils/animations/fade-animation-y-axis.dart.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../controller/Sign-Up-Controller.dart';

class SignUpScreen extends StatelessWidget {
  final Sign_Up_Controller _controller = Get.put(Sign_Up_Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/sign-up-screen/image.png')),
          Container(
            child: Obx(() => _controller.currentSelectedPage.value!),
          ),
          FadeAnimationYAxis(
            0.8,
            Container(
              margin: EdgeInsets.only(right: 55),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(top: Get.height * 0.25),
                  child: Obx(
                    () => AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      duration: Duration(milliseconds: 500),
                      child: _controller.pagecount.value == _controller.maxpage
                          ? BottomMiddleButton(
                              title: tr('done'),
                              onPressed: () {

                              }
                                )
                          : _controller.pagecount.value==1 ? BottomMiddleButton(
                              title: tr('confirm'),
                              onPressed: () => _controller.changeScreen(false),
                            ):BottomMiddleButton(
                        title: tr('done'),
                        onPressed: () => _controller.changeScreen(false),
                    ),)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
