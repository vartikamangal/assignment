import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../domain/entities/question-log.dart';
import '../controller/profile-controller.dart';
import 'answered-questionnaire-widget.dart';

class AnsweredQuestionDiary extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.questionLogs.isEmpty
          ? _buildUnAnsweredScreen(context)
          : _buildAnsweredScreen(controller.questionLogs),
    );
  }

  Widget _buildUnAnsweredScreen(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    final ProfileController _controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value),
            child: Text(
              tr('choices'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 41,
            ).value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed(RouteName.questionTrackScreen)
                      .then((value) => _controller.fetchQuestionLogs());
                },
                child: SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 80,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 80,
                    ).value,
                    child: Image.asset(
                      ImagePath.lockImage,
                      scale: imageScaleFactor,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 10,
            ).value,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value),
            child: Text(
              tr('answered question to help'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleM.copyWith(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnsweredScreen(final List<QuestionLog> questionLogs) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SingleChildScrollView(
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

            /// Build the Question-Answer's UI collectivly
            _buildQuestionnaire(questionLogs),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionnaire(List<QuestionLog> questionLogs) {
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
}
