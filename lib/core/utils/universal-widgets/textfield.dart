// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
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
      height: ScaleManager.spaceScale(
        spaceing: 55,
      ).value,
      padding: EdgeInsets.only(
        left: ScaleManager.spaceScale(
          spaceing: 28,
        ).value,
        right: ScaleManager.spaceScale(
          spaceing: 30,
        ).value,

      ),
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 9,
        ).value,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: hintshade),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.suggestionononwol,
            textScaleFactor: textScale,
          ),

          Text(
            subtitle,
            style: AppTextStyle.greyTapText.copyWith(color: hintshade),
            textScaleFactor: textScale,
          ),
        ],
      ),
    );
  }
}
