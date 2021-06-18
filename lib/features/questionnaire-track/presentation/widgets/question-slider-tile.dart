// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/app-themes/app-custom-widget-themes.dart';
import '../../../../core/utils/helper_functions/getSliderEmotionImage.dart';

class ScaleTypeQuestionTile extends StatelessWidget {
  const ScaleTypeQuestionTile({
    Key key,
    @required this.index,
    @required this.max,
    @required this.min,
    @required this.onChanged,
    @required this.value,
    @required this.emotionValue,
    @required this.question,
  }) : super(key: key);

  final int index;
  final String question;
  final double emotionValue;
  final double min;
  final double max;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    return Container(
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 37,
        ).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Expanded(
                child: SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: Get.width,
                  ).value,
                  child: Text(
                    question,
                    style: AppTextStyle.suggestionononwol,
                    textScaleFactor: textScale,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.004,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: ScaleManager.spaceScale(
                    spaceing: 2,
                  ).value,
                ),
                child: Image.asset(
                  getSliderEmotion(
                    value: emotionValue,
                    lowerLimit: min,
                    upperLimit: max,
                  ),
                  height: ScaleManager.spaceScale(
                    spaceing: 21,
                  ).value,
                  scale: imageScale,
                ),
              ),
              SliderTheme(
                data: CustomWidgetThemes.sliderTheme,
                child: Slider(
                  min: min,
                  max: max,
                  value: value,
                  divisions: 60,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Row(
                children: [
                  if (value<(min.round()+max.round())/2) SizedBox(width: ScaleManager.spaceScale(
                    spaceing: 6,
                  ).value) else Container(),
                  if (value>(min.round()+max.round())/2) SizedBox(
                    width: (ScaleManager.spaceScale(
                      spaceing: 320,
                    ).value *
                        ((value - min) / (max - min)))-ScaleManager.spaceScale(
                      spaceing: 4,
                    ).value,
                  ) else SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 325,
                    ).value *
                        ((value - min) / (max - min)),
                  ),
                  if (value <= min.round() + 0.4 || value >= max - 0.4)
                    Container()
                  else
                    Text(
                      '${value.round()}',
                      style: AppTextStyle.sliderValue,
                      textScaleFactor: textScale,
                    ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
                    spaceing: 13,
                  ).value),
                  child: Text(
                    '${min.round()}',
                    style: AppTextStyle.sliderValue,
                    textScaleFactor: textScale,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(right: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value),
                  child: Text(
                    '${max.round()}',
                    style: AppTextStyle.sliderValue,
                    textScaleFactor: textScale,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}