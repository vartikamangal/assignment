// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animator/animator.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

class Rounds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Green ring near hand
        Positioned(
          top: ScaleManager.spaceScale(
            spaceing: -90.0,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 69.0,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            resetAnimationOnRebuild: true,
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  animatorState.value,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value),
                  child: Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 216.0,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 216.0,
                    ).value,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: greenLightShade,
                        width: ScaleManager.spaceScale(
                          spaceing: 4,
                        ).value,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Sun like object
        Positioned(
          bottom: ScaleManager.spaceScale(
            spaceing: 78.0,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 160.0,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            curve: Curves.fastOutSlowIn,
            duration: const Duration(
              milliseconds: 1800,
            ),
            resetAnimationOnRebuild: true,
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  animatorState.value,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 177.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 177.0,
                  ).value,
                  decoration: BoxDecoration(
                    color: aquashade,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
