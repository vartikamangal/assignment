import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

class InfoBottomSheet extends StatelessWidget {
  final String selectedArea;
  final String description;
  const InfoBottomSheet({
    Key key,
   @required this.selectedArea,
    @required this.description
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return  ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(ScaleManager.spaceScale(
        spaceing: 59,
      ).value),topRight: Radius.circular(ScaleManager.spaceScale(
        spaceing: 59,
      ).value)),
        child: Container(
          height: Get.height*0.75,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left:ScaleManager.spaceScale(
              spaceing: 53,
            ).value ,
            top: ScaleManager.spaceScale(
              spaceing: 43,
            ).value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(selectedArea,
                style: AppTextStyle.titlel.copyWith(
                  fontSize: 18
                ),
                textScaleFactor: textScaleFactor,),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value,
                ),
                Padding(
                  padding:  EdgeInsets.only(right:  ScaleManager.spaceScale(
                    spaceing: 46,
                  ).value),
                  child: Text(
                    description,
                    style: AppTextStyle.titlel.copyWith(
                      fontSize: 18,
                      color: greyLightShade,
                    ),
                    textScaleFactor: textScaleFactor,
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
