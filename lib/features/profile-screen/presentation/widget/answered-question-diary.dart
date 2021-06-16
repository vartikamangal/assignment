import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-controller.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/not-answered-question-diary.dart';

class AnsweredQuestionDiary extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return controller.questionLogs.isEmpty
        ? NotAnsweredQuestionDiary()
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                spaceing: 32,
              ).value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('choices'),
                    textScaleFactor: textScaleFactor,
                    style: AppTextStyle.titleL
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 39,
                    ).value,
                  ),
                  _buildQuestions(controller.questionLogs),
                ],
              ),
            ),
          );
  }
}

Widget _buildQuestions(List<QuestionLog> questionLogs) {
  final List<AnsweredQuestion> questionLogWidgets = [];
  questionLogs.forEach(
    (questionLog) {
      questionLogWidgets.add(
        AnsweredQuestion(
          question: questionLog.question.questionInformation.questionText,
          answer: questionLog.optionChosen.isEmpty
              ? 'N/A'
              : questionLog.optionChosen.first.optionText,
        ),
      );
    },
  );
  return Column(
    children: questionLogWidgets,
  );
}

class AnsweredQuestion extends StatelessWidget {
  final String question;
  final String answer;
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
            question,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.lightbold.copyWith(color: blueDarkerShade),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Text(
            answer,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.lightbold.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
