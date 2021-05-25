import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottomRightButton.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/controller/hub-controller.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/presentation/controller/question-controller.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/presentation/widgets/multiple-choice-question-tile.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../widgets/question-slider-tile.dart';

class QuestionsTrackScreen extends StatelessWidget {
  final controller = Get.find<QuestionnaireConroller>();
  final hubController = Get.find<HubController>();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: blueDarkShade,
          iconSize: ScaleManager.spaceScale(
            spaceing: 26,
          ).value,
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: ScaleManager.spaceScale(
            spaceing: 42,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 41,
          ).value,
        ),
        child: Stack(
          children: [
            Text(
              tr('question screen title'),
              style: AppTextStyle.titleLM,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 100,
              ).value,
            ),
            Container(
              margin: EdgeInsets.only(
                top: ScaleManager.spaceScale(
                  spaceing: 104,
                ).value,
              ),
              height: ScaleManager.spaceScale(
                spaceing: Get.height,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: Get.width,
              ).value,
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final question = controller.questionToAnswerMap.keys
                              .toList()[index];
                          final questionType = controller
                              .questionToAnswerMap.keys
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
                                  min: question.questionOptionVO[0]
                                      .additionalInformation[0].min
                                      .toDouble(),
                                  max: question.questionOptionVO[0]
                                      .additionalInformation[0].max
                                      .toDouble(),
                                  onChanged: (double newVal) {
                                    controller.updateQuizValues(
                                      question: question,
                                      option: newVal,
                                    );
                                  },
                                  emotionValue: (controller
                                          .questionToAnswerMap[question] as num)
                                      .toDouble(),
                                  index: 1,
                                  value: (controller
                                          .questionToAnswerMap[question] as num)
                                      .toDouble(),
                                );
                        },
                        itemCount:
                            controller.questionToAnswerMap.keys.toList().length,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BottomRightButton(
                      onPressed: () async {
                        await controller.attempQuestionsTrigger();
                      },
                      title: '',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
