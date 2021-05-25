import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

class WheelOfLifeAreaHolder extends StatelessWidget {
  const WheelOfLifeAreaHolder({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return Container(
      padding: EdgeInsets.only(
        left: ScaleManager.spaceScale(
          spaceing: 28,
        ).value,
        right: ScaleManager.spaceScale(
          spaceing: 30,
        ).value,
        bottom: ScaleManager.spaceScale(
          spaceing: 6,
        ).value,
        top: ScaleManager.spaceScale(
          spaceing: 6,
        ).value,
      ),
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 9,
        ).value,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: greyboxshade),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScaleManager.spaceScale(
              spaceing: 30,
            ).value,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.suggestionononwol,
            textScaleFactor: textScale,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 4,
            ).value,
          ),
          Text(
            subtitle,
            style: AppTextStyle.greyTapText,
            textScaleFactor: textScale,
          ),
        ],
      ),
    );
  }
}
