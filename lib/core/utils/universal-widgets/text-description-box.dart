import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

// ignore: must_be_immutable
class TextDescriptionBox extends StatelessWidget {
  @required
  String title;
  @required
  String description;
  @required
  String week;
  @required
  String category;
  @required
  String suggestion1;
  @required
  String suggestion2;
  @required
  String suggestion3;
  @required
  String suggestion4;
  @required
  String suggestion5;

  TextDescriptionBox(
      {this.title,
      this.description,
      this.week,
      this.category,
      this.suggestion1,
      this.suggestion2,
      this.suggestion3,
      this.suggestion4,
      this.suggestion5});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    // ignore: avoid_unnecessary_SizedBoxs
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.choosePathOption,
                textScaleFactor: textScaleFactor,
              ),
              SizedBox(
                child: Text(
                  description,
                  style: AppTextStyle.descriptionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 10,
                ).value,
              )
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                category,
                style: AppTextStyle.textonwol,
                textScaleFactor: textScaleFactor,
              ),
            ),
            SizedBox(
              width: Get.width * 0.45,
            ),
            Text(
              week,
              style: AppTextStyle.dayText,
              textScaleFactor: textScaleFactor,
            )
          ],
        ),
        SizedBox(
          height: ScaleManager.spaceScale(spaceing: 2).value,
        ),
        Container(
          margin: EdgeInsets.only(
              bottom: ScaleManager.spaceScale(spaceing: 8).value),
          width: Get.width,
          height: ScaleManager.spaceScale(spaceing: 1).value,
          color: greyline,
        ),
        SizedBox(
          child: Wrap(
            spacing: ScaleManager.spaceScale(spaceing: 70).value,
            children: [
              SizedBox(
                width: ScaleManager.spaceScale(spaceing: 104).value,
                child: Text(
                  suggestion1,
                  style: AppTextStyle.suggestionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                width: ScaleManager.spaceScale(spaceing: 104).value,
                child: Text(
                  suggestion2,
                  style: AppTextStyle.suggestionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                width: ScaleManager.spaceScale(spaceing: 104).value,
                child: Text(
                  suggestion3,
                  style: AppTextStyle.suggestionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                width: ScaleManager.spaceScale(spaceing: 104).value,
                child: Text(
                  suggestion4,
                  style: AppTextStyle.suggestionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                width: ScaleManager.spaceScale(spaceing: 50).value,
                child: Text(
                  suggestion5,
                  style: AppTextStyle.suggestionText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
