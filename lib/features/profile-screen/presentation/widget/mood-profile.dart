import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import 'linear-mood-chart.dart';


class MoodProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
          spaceing: 21,
        ).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
                spaceing: 11,
              ).value),
              child: Text(tr('mood'),
                textScaleFactor: textScaleFactor,
                style: AppTextStyle.titleL.copyWith(fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 40,
              ).value,
            ),
            SizedBox(
                width: Get.width-20,
                height:ScaleManager.spaceScale(
                  spaceing: 170,
                ).value,child: LinearChart()),

            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            Padding(
              padding:  EdgeInsets.only(left:ScaleManager.spaceScale(
                spaceing: 27,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 39,
              ).value),
              child: Container(
                width: Get.width,
                height: 1,
                color: greyline,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 29,
              ).value,
            ),
            Text(
              tr('weekly pattern'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 28,
              ).value,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 180,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 377,
              ).value,
              child: Image.asset(ImagePath.chartLock,
                scale: imageScaleFactor,
              ),
            )
          ],
        ),
      ),
    );
  }
}


/// Sample linear data type.
class MoodWithDay {
  final int day;
  final double mood;

  MoodWithDay(this.day, this.mood);
}






