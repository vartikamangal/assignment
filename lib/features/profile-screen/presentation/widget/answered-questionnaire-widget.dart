import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

class AnsweredQuestion extends StatelessWidget {
  final String? question;
  final String? answer;
  const AnsweredQuestion({this.question, this.answer});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 21,
        ).value,
        left: ScaleManager.spaceScale(
          spaceing: 10,
        ).value,
        right: ScaleManager.spaceScale(
          spaceing: 40,
        ).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question!,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.lightbold.copyWith(color: blueDarkerShade),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Text(
            answer!,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.lightbold.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
