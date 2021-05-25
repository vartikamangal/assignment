import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

// ignore: must_be_immutable

class PlanContainer extends StatelessWidget {
  String title;
  String description;
  String image;
  Callback onPressed;
  bool isFaded;
  PlanContainer({
    this.description,
    this.title,
    this.image,
    this.onPressed,
    this.isFaded,
  });
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: isFaded ? () {} : onPressed,
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 85,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: Get.width,
                  ).value,
                  margin: EdgeInsets.only(
                      top: ScaleManager.spaceScale(
                        spaceing: 4,
                      ).value,
                      left: ScaleManager.spaceScale(
                        spaceing: 25,
                      ).value),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: greyLightShade,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        ScaleManager.spaceScale(
                          spaceing: 42.5,
                        ).value,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 70).value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: isFaded
                              ? AppTextStyle.Darkblueheader.copyWith(
                                  color: Colors.grey,
                                )
                              : AppTextStyle.Darkblueheader,
                          textScaleFactor: textScaleFactor,
                        ),
                        if (isFaded || description == '')
                          EmptySpacePlaceHolder()
                        else
                          SizedBox(
                            height: ScaleManager.spaceScale(spaceing: 7).value,
                          ),
                        if (isFaded || description == '')
                          EmptySpacePlaceHolder()
                        else
                          Text(
                            description,
                            style: AppTextStyle.ligntbluedescription,
                            textAlign: TextAlign.center,
                            textScaleFactor: textScaleFactor,
                          )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    image,
                    height: ScaleManager.spaceScale(spaceing: 91).value,
                    scale: imageScaleFactor,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScaleManager.spaceScale(spaceing: 40).value)
          ],
        ),
      ),
    );
  }
}
