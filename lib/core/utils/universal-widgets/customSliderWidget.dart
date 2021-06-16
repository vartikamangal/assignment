// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Router;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../app-text-style-components/app-text-styles.dart';
import '../app-themes/app-custom-widget-themes.dart';
import '../helper_functions/getSliderEmotionImage.dart';

class CustomSliderWidget extends StatefulWidget {
  final String title;
  // final double value;
  final double min;
  final double max;
  //final Map sliderToDictMapper;
  const CustomSliderWidget({
    Key key,
    this.title,
    //this.value,
    this.min,
    this.max,
    // this.sliderToDictMapper,
  }) : super(key: key);

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTextStyle.titleMDark,
              ),
              Image.asset(getSliderEmotion(
                value: _value,
                upperLimit: 5.0,
                lowerLimit: 0.0,
              )),
            ],
          ),
          SizedBox(
            height: Get.height * 0.004,
          ),
          SliderTheme(
            data: CustomWidgetThemes.sliderTheme,
            child: Slider(
                min: 1,
                max: 5,
                value: _value,
                label: "3",
                onChanged: (newVal) {
                  _value = newVal;
                  //todo
                }),
          ),
        ],
      ),
    );
  }
}
