// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animator/animator.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../controller/choose-path-controller.dart';
import '../widget/journey-details-widget.dart';
import '../widget/journey-path-options-widget.dart';

class ChoosePathScreen extends StatelessWidget {
  final ChoosePathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: blueDarkShade,
                size: ScaleManager.spaceScale(
                  spaceing: 26,
                ).value,
              ),
              onPressed: () {
                _controller.isJourneySelected.value
                    ? _controller.navigateBack()
                    : Navigator.of(context).pop();
              },
            )),
        body: Animator<double>(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ),
          duration: const Duration(
            milliseconds: 600,
          ),
          builder: (context, animatorState, child) => FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(animatorState.value),
            child: Stack(
              children: [
                Obx(
                  () => _controller.isJourneySelected.value
                      ? JourneyDetails(
                          journey: _controller.selectedJourney.value,
                          startJourneyFunction: () async {
                            await _controller.startJourneyAndProceed();
                          },
                        )
                      : WhatPathToChoose(),
                ),
                Obx(
                  () => _controller.isProcessing.value
                      ? const LinearProgressIndicator()
                      : EmptySpacePlaceHolder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
