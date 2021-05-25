import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/animations/fade-animation-y-axis.dart.dart';
import '../controllers/wheel-of-life-controller.dart';
import 'slider-tile.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class WheelOfLifeBodyD extends StatelessWidget {
  final WheelOfLifeController controller;

  const WheelOfLifeBodyD({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
             Text(
                tr('wol slider title'),
                style: AppTextStyle.titleL,
                textScaleFactor: textScaleFactor,
              ),
            Obx(
                () => Container(
                  height: Get.height*0.76,
                  width: Get.width,
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: ScaleManager.spaceScale(
                      spaceing: 18,
                    ).value,
                  ),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final lifeAreaToBeChanged = controller
                          .uiHelperListForTimeProvision.keys
                          .toList()[index];
                      return SliderTile(
                        index: index,
                        onChanged: (double newVal) {
                          controller.settSlidervalue(newVal, index);
                        },
                        max: (controller.ratingScale.value.max).toDouble(),
                        min: (controller.ratingScale.value.min).toDouble(),
                        value: controller
                            .uiHelperListForTimeProvision[lifeAreaToBeChanged],
                        label: controller.uiHelperListForTimeProvision.keys
                            .toList()[index]
                            .name,
                        emotionValue: controller
                            .uiHelperListForTimeProvision[lifeAreaToBeChanged],
                      );
                    },
                    itemCount: controller.uiHelperListForTimeProvision.keys
                        .toList()
                        .length,
                  ),
                ),
              ),
          ],
        ),
    );
  }
}
