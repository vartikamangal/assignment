import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/wol-pie-chart.dart';

class WheelOfLifeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
          spaceing: 32,
        ).value,
            right: ScaleManager.spaceScale(
              spaceing: 29,
            ).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('my wheel of life'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: ScaleManager.spaceScale(
              spaceing: 5,
            ).value,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 240,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 240,
                    ).value,
                    child: PiChart()),
              ],
            ),
            SizedBox(height: ScaleManager.spaceScale(
              spaceing: 5,
            ).value,),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                  8, (index) {
                return WheelOfLifeArea(
                  wolAreaImage: 'assets/profile-icon/user-image.png',
                  title: 'Fun and recreation',
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}

class WheelOfLifeArea extends StatelessWidget {
  String wolAreaImage;
  String title;
  WheelOfLifeArea({this.wolAreaImage,this.title});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 52,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 52,
              ).value,
              child: Image.asset(wolAreaImage,scale: imageScaleFactor,)),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: ScaleManager.spaceScale(
                spaceing: 17,
              ).value
            ),
            width: ScaleManager.spaceScale(
              spaceing: 87,
            ).value,
            child: Text(
              title,
              style: AppTextStyle.hintStyleXS.copyWith(
                fontSize: 14
              ),
              textScaleFactor: textScaleFactor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 20,
            ).value,
          )
        ],
      ),
    );
  }
}
