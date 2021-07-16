// Dart imports:
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../controllers/wheel-of-life-controller.dart';

class WheelOfLifeScreen extends StatelessWidget {
  final _controller = Get.find<WheelOfLifeController>();
  bool isBack = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => _controller.isProcessing.value
                  ? CustomizedLinearProgressIndicator()
                  : Container(),
            ),
            CustomScrollView(
                physics: Platform.isIOS
                    ? const BouncingScrollPhysics()
                    : const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    leading: TopAppBar(
                      onPressed: () {
                        _controller.currentOnBoardPageCounter.value == 0
                            ? Navigator.of(context).pop()
                            : _controller.navigateBack();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
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
                      child: Obx(() => _controller.currentSelectedPage.value!),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: ScaleManager.spaceScale(
                            spaceing: 16,
                          ).value,
                          right: ScaleManager.spaceScale(
                            spaceing: 41,
                          ).value,
                        ),
                        child: Obx(() {
                          if (_controller.isLoading.value) {
                            return Container();
                          }
                          if (_controller.currentOnBoardPageCounter.value ==
                              0) {
                            return AnimatedSwitcher(
                              switchInCurve: Curves.easeIn,
                              duration: const Duration(milliseconds: 700),
                              child: _controller.isLoading.value
                                  ? Container()
                                  : BottomMiddleButton(
                                      title: 'MAKES SENSE',
                                      onPressed: () =>
                                          _controller.changeScreen(),
                                    ),
                            );
                          } else if (_controller
                                  .currentOnBoardPageCounter.value ==
                              1) {
                            return TweenAnimationBuilder(
                                tween: Tween<double>(
                                    begin: 0, end: _controller.angle.value),
                                duration: Duration(
                                    milliseconds: 600 +
                                        (_controller.lifeAreas.length + 1) *
                                            100),
                                builder:
                                    (BuildContext context, double val, __) {
                                  if (val >= (pi / 2)) {
                                    isBack = false;
                                  } else {
                                    isBack = true;
                                  }
                                  return Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.001)
                                      ..rotateY(val),
                                    child: isBack
                                        ? BottomMiddleButton(
                                            title: 'DONE',
                                            onPressed: () =>
                                                _controller.changeScreen(),
                                          )
                                        : Container(),
                                  );
                                });
                          } else {
                            return BottomMiddleButton(
                              title: 'DONE',
                              // ignore: avoid_print
                              onPressed: () async =>
                                  _controller.rateSatisfactionAndMoveAhead(),
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
