import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';

class NotAnsweredQuestionDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value),
            child: Text(tr('choices'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: ScaleManager.spaceScale(
            spaceing: 41,
          ).value,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 80,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 80,
                  ).value,
                  child: Image.asset(ImagePath.lockImage,
                  scale: imageScaleFactor,)),
            ],
          ),
          SizedBox(height: ScaleManager.spaceScale(
            spaceing: 10,
          ).value,),
          Padding(
            padding:   EdgeInsets.only(left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value),
            child: Text(tr('answered question to help'),
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.titleM.copyWith(fontSize: 18),),
          )
        ],
      ),
    );
  }
}
