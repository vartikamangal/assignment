// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/inactive-bottom-right-button.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottomRightButton.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../hub/presentation/controller/hub-controller.dart';
import '../../data/models/question-model.dart';
import '../controller/question-controller.dart';
import '../widgets/multiple-choice-question-tile.dart';
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
          padding:EdgeInsets.only(left: ScaleManager.spaceScale(
            spaceing: 10,
          ).value,
              top: ScaleManager.spaceScale(
                spaceing: 10,
              ).value,
              bottom: 0),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            ImagePath.backButton,
            height: ScaleManager.spaceScale(
              spaceing: 26,
            ).value,
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 42,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 41,
            ).value,
          ),
          child: Column(
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
                constraints: BoxConstraints(minHeight: Get.height*0.63),
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                    shrinkWrap: true,
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
                                        .roundToDouble(),
                                  );
                          },
                          itemCount:
                              controller.questionToAnswerMap.keys.toList().length,
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
                          if (controller.isAllQuestionAnswered.value == true)
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
          ),
        ),
      ),
    );
  }
}
