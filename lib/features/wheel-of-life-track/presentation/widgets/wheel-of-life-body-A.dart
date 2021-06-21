// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/textfield.dart';
import '../controllers/wheel-of-life-controller.dart';

class WheelOfLifeBodyA extends StatelessWidget {
  final WheelOfLifeController controller;

  const WheelOfLifeBodyA({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let’s take a look at these areas of your life",
          style: AppTextStyle.titleLM,
          textScaleFactor: textScale,
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 7,
          ).value,
        ),
        Obx(
              () => Text(
            tr('hub nothing answeres text',
                namedArgs: {'name': controller.userName.value}),
            style: AppTextStyle.lightbold,
            textScaleFactor: textScale,
          ),
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 7,
          ).value,
        ),
        Obx(
              () => AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            duration: const Duration(milliseconds: 700),
            child: controller.isLoading.value
                ? SizedBox(
              height: controller.lifeAreas.length*ScaleManager.spaceScale(
                spaceing: 67.0,
              ).value,
              child:  const Center(
                child: CircularProgressIndicator(),
              ),
            )
                : Container(
              padding: EdgeInsets.only(
                  top: ScaleManager.spaceScale(
                    spaceing: 16,
                  ).value),
              width: Get.width,
              height: controller.lifeAreas.length*ScaleManager.spaceScale(
                spaceing: 67.0,
              ).value,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.lifeAreas.length,
                itemBuilder: (BuildContext context, int index) {
                  final lifeArea = controller.lifeAreas[index];
                  return  WheelOfLifeAreaHolder(
                    title: lifeArea.name,
                    subtitle: lifeArea.description,
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}



