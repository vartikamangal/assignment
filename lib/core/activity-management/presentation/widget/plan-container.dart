// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';

// ignore: must_be_immutable

class PlanContainer extends StatelessWidget {
  String title;
  String description;
  String image;
  Callback onPressed;
  bool isFaded;
  bool requireBottomSpacing;
  PlanContainer({
    this.description,
    this.title,
    this.image,
    this.onPressed,
    this.isFaded,
    @required this.requireBottomSpacing,
  });
  @override
  Widget build(BuildContext context) {
    title = '${title[0].toUpperCase()}${title.substring(1).toLowerCase()}';
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
                      color: hintshade,
                      width: ScaleManager.spaceScale(
                        spaceing: 1,
                      ).value,
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
                          InitCap(title),
                          style: isFaded
                              ? AppTextStyle.Darkblueheader.copyWith(
                                  color: greyboxshade,
                                )
                              : AppTextStyle.Darkblueheader,
                          textScaleFactor: textScaleFactor,
                        ),
                        if (isFaded || description == '')
                          EmptySpacePlaceHolder()
                        else
                          Padding(
                            padding:  EdgeInsets.only(top: ScaleManager.spaceScale(spaceing: 7).value),
                            child: Text(
                              description,
                              style: AppTextStyle.ligntbluedescription,
                              textAlign: TextAlign.center,
                              textScaleFactor: textScaleFactor,
                            ),
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
            if (requireBottomSpacing)
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 40,
                ).value,
              )
            else
              EmptySpacePlaceHolder(),
          ],
        ),
      ),
    );
  }
}

String InitCap(String title) {
  int count = title.split(' ').length;
  String result = '';
  for (int i = 0; i < count; i++) {
    result =
        '$result${'${title.split(' ')[i][0].toUpperCase()}${title.split(' ')[i].substring(1).toLowerCase()} '}';
  }
  return result;
}
