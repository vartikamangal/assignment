import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

class AnsweredQuestionDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
          spaceing: 32,
        ).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('choices'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(fontSize: 24,
              fontWeight: FontWeight.w600),
            ),
            SizedBox(height: ScaleManager.spaceScale(
              spaceing: 39,
            ).value,),
            AnsweredQuestion(
              question: 'How many hours a week do you spend on workout?',
              answer: '1 Hour ',
            ),
            AnsweredQuestion(
              question: 'How many hours a week do you spend on workout?',
              answer: '1 Hour ',
            )
          ],
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class AnsweredQuestion extends StatelessWidget {
  String question;
  String answer;
  AnsweredQuestion({this.question, this.answer});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Padding(
      padding:  EdgeInsets.only(bottom:  ScaleManager.spaceScale(
        spaceing: 21,
      ).value,left: ScaleManager.spaceScale(
        spaceing: 10,
      ).value ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,textScaleFactor: textScaleFactor,style: AppTextStyle.lightbold.copyWith(color: blueDarkerShade),),
          SizedBox(height: ScaleManager.spaceScale(
            spaceing: 8,
          ).value,),
          Text(answer,textScaleFactor: textScaleFactor,style: AppTextStyle.lightbold.copyWith(fontSize: 14),)
        ],
      ),
    );
  }
}
