import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
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
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 27,
        ).value,
      ),
      child: Column(
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
              divisions: 40,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toInt()}',
                style: AppTextStyle.sliderValue,
                textScaleFactor: textScale,
              ),
              Text(
                '${value.toInt()}',
                style: AppTextStyle.sliderValue,
                textScaleFactor: textScale,
              ),
              Text(
                '${max.toInt()}',
                style: AppTextStyle.sliderValue,
                textScaleFactor: textScale,
              ),
            ],
          )
        ],
      ),
    );
  }
}
