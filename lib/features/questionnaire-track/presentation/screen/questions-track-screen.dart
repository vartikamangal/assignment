// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottomRightButton.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/inactive-bottom-right-button.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/presentation/widgets/multiple-choice-question-tile.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/presentation/widgets/question-slider-tile.dart';

import '../../../../core/responsive/scale-manager.dart';
import '../../../hub/presentation/controller/hub-controller.dart';
import '../controller/question-controller.dart';

class QuestionsTrackScreen extends StatelessWidget {
  final controller = Get.find<QuestionnaireConroller>();
  final hubController = Get.find<HubController>();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Scaffold(
      appBar: AppBar(
        leading: TopAppBar(onPressed: () {
          Navigator.of(context).pop();
        }),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              left: ScaleManager.spaceScale(spaceing: 42).value,
              right: ScaleManager.spaceScale(spaceing: 41).value,
            ),
            child: Obx(() {
              switch (controller.pageState.value) {
                case PageState.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case PageState.LOADED:
                  return _QuestionnaireView(
                    textScaleFactor: textScaleFactor,
                    controller: controller,
                  );
                case PageState.FAILURE:
                  return const Center(
                    child: EmptyState(text: "Oops! No questionnaire found"),
                  );
              }
            })),
      ),
    );
  }
}

class _QuestionnaireView extends StatelessWidget {
  const _QuestionnaireView({
    Key? key,
    required this.textScaleFactor,
    required this.controller,
  }) : super(key: key);

  final double textScaleFactor;
  final QuestionnaireConroller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tr('question screen title'),
          style: AppTextStyle.titleLM,
          textScaleFactor: textScaleFactor,
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 35,
          ).value,
        ),
        Container(
          constraints: BoxConstraints(minHeight: Get.height * 0.63),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final question =
                    controller.questionToAnswerMap.keys.toList()[index];
                final questionType = controller.questionToAnswerMap.keys
                    .toList()[index]
                    .questionType;
                // Find a way for dynamic rendering both types of fetched questions
                return questionType == 'SINGLE_CHOICE'
                    ? MultipleChoiceTypeQuestionTile(
                        index: index,
                        question: question as QuestionModel,
                        conroller: controller,
                      )
                    : ScaleTypeQuestionTile(
                        question: question.questionText,
                        // 0 is used because in Scale Type questions, there is only one scale scale possible in response
                        min: question
                            .questionOptionVO[0].additionalInformation[0].min!
                            .toDouble(),
                        max: question
                            .questionOptionVO[0].additionalInformation[0].max!
                            .toDouble(),
                        onChanged: (double newVal) {
                          controller.updateQuizValues(
                            question: question,
                            option: newVal,
                          );
                        },
                        emotionValue:
                            (controller.questionToAnswerMap[question] as num)
                                .toDouble(),
                        index: 1,
                        value: (controller.questionToAnswerMap[question] as num)
                            .roundToDouble(),
                      );
              },
              itemCount: controller.questionToAnswerMap.keys.toList().length,
            ),
          ),
        ),
        Obx(() => Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.allQuestionAnswered.value == true)
                      BottomRightButton(
                        onPressed: () async {
                          await controller.attempQuestionsTrigger();
                        },
                        title: '',
                      )
                    else
                      InactiveBottomRightButton(
                        title: '',
                        onPressed: () {},
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
