// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animator/animator.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';

class UpperLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple circle on thegreen ring
        Positioned(
          top: ScaleManager.spaceScale(
            spaceing: 100.0,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 125.0,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            cycles: 0,
            curve: Curves.fastOutSlowIn,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  animatorState.value * 0.5,
                  -animatorState.value,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 15.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 15.0,
                  ).value,
                  decoration: BoxDecoration(
                    color: purpleDarkerShade,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
        // light sky blue circle near hand
        Positioned(
          top: ScaleManager.spaceScale(
            spaceing: 35.0,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 307.0,
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
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  animatorState.value * 0.1,
                  animatorState.value,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 27.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 27.0,
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
        //Drak green round
        Positioned(
          top: ScaleManager.spaceScale(
            spaceing: 155.0,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 270.0,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            curve: Curves.fastOutSlowIn,
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  -animatorState.value * 0.2,
                  -animatorState.value * 1.5,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 11.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 11.0,
                  ).value,
                  decoration: BoxDecoration(
                    color: greenDarkShade,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
        //dark green circle near mountain
        Positioned(
          bottom: ScaleManager.spaceScale(
            spaceing: 250,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 180,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            curve: Curves.fastOutSlowIn,
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  -animatorState.value * 2,
                  -animatorState.value * 0.2,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 11.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 11.0,
                  ).value,
                  decoration: BoxDecoration(
                    color: greenDarkShade,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: ScaleManager.spaceScale(
            spaceing: 100,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 350,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            curve: Curves.fastOutSlowIn,
            cycles: 0,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  -animatorState.value * 1.3,
                  -animatorState.value * 1.3,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 15.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 15.0,
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
        Positioned(
          bottom: ScaleManager.spaceScale(
            spaceing: 220,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 150,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            duration: const Duration(
              milliseconds: 1800,
            ),
            cycles: 0,
            curve: Curves.fastOutSlowIn,
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  -animatorState.value * 1.1,
                  animatorState.value * 1.1,
                ),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 24.0,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 24.0,
                  ).value,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: purpleDarkerShade,
                      width: ScaleManager.spaceScale(
                        spaceing: 3,
                      ).value,
                    ),
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
