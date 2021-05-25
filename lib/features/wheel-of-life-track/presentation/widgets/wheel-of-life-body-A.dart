import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../controllers/wheel-of-life-controller.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/textfield.dart';

class WheelOfLifeBodyA extends StatelessWidget {
  final WheelOfLifeController controller;

  const WheelOfLifeBodyA({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
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
        Text(
          tr('hub nothing answeres text', namedArgs: {'name': 'Deepak'}),
          style: AppTextStyle.lightbold,
          textScaleFactor: textScale,
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: ScaleManager.spaceScale(
                spaceing: 55,
              ).value,
              top: ScaleManager.spaceScale(
                spaceing: 16,
              ).value),
          width: Get.width,
          height: Get.height * 0.76,
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      final lifeArea = controller.lifeAreas[index];
                      return WheelOfLifeAreaHolder(
                        title: lifeArea.name,
                        subtitle: lifeArea.description,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
