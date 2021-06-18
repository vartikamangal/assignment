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

class SliderTile extends StatelessWidget {
  const SliderTile({
    Key key,
    @required this.index,
    @required this.max,
    @required this.min,
    @required this.onChanged,
    @required this.value,
    @required this.emotionValue,
    @required this.label,
  }) : super(key: key);

  final int index;
  final String label;
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
      height: ScaleManager.spaceScale(
        spaceing: 80,
      ).value,
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 27,
        ).value,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.titleMDark,
                    textScaleFactor: textScale,
                  ),
                  Image.asset(
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
                ],
              ),
              SizedBox(
                height: Get.height * 0.004,
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
              Row(
                children: [
                  if (value<(min.round()+max.round())/2) SizedBox(width: ScaleManager.spaceScale(
                    spaceing: 6,
                  ).value) else Container(),
                  if (value>(min.round()+max.round())/2) SizedBox(
                    width: (ScaleManager.spaceScale(
                      spaceing: 325,
                    ).value *
                        ((value - min) / (max - min)))-ScaleManager.spaceScale(
                      spaceing: 6,
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
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
                spaceing: 10,
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
    );
  }
}
