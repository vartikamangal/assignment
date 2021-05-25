import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controller/path-controller.dart';

class PlaySection1 extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    final bool _isSmallWinsActivity =
        Get.find<ChoosePathController>().selectedJourney.value.pathName ==
            'SMALL_WINS';
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: ScaleManager.spaceScale(spaceing: 60).value,
            left: ScaleManager.spaceScale(spaceing: 17).value),
        child: Column(
          children: [
            Text(
              'Awesome!',
              style: AppTextStyle.appreciationtext,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(spaceing: 10).value,
            ),
            Text(
              'You just finished your first practice!',
              style: AppTextStyle.actiontoperform,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(spaceing: 20).value,
            ),
            Image.asset(
              '${ImagePath.selfDrivenOption}physical.png',
              height: ScaleManager.spaceScale(spaceing: 140).value,
              width: ScaleManager.spaceScale(spaceing: 138).value,
              scale: imageScaleFactor,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScaleManager.spaceScale(spaceing: 40).value),
              child: Text(
                _isSmallWinsActivity
                  ? _controller.selectedActivity.value.activity.title
                  : _controller.selectedDayPlan.value.title,
                style: AppTextStyle.Askfeeling,
                textScaleFactor: textScaleFactor,
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: ScaleManager.spaceScale(spaceing: 20).value,
                    left: ScaleManager.spaceScale(spaceing: 40).value,
                    right: ScaleManager.spaceScale(spaceing: 56).value),
                child: Text(
                  tr('play section message1'),
                  style: AppTextStyle.growthtext,
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                ))
          ],
        ),
      ),
    );
  }
}
