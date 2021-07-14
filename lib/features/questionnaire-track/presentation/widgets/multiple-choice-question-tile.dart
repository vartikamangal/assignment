// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../data/models/question-model.dart';
import '../../data/models/question-option-model.dart';
import '../controller/question-controller.dart';
import 'dropdown-assist.dart';

class MultipleChoiceTypeQuestionTile extends StatelessWidget {
  const MultipleChoiceTypeQuestionTile({
    Key? key,
    required this.index,
    required this.question,
    required this.conroller,
  }) : super(key: key);

  final int index;
  final QuestionModel question;
  final QuestionnaireConroller conroller;
  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return Container(
      margin: EdgeInsets.only(
        bottom: ScaleManager.spaceScale(
          spaceing: 27,
        ).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Expanded(
                child: SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: Get.width,
                  ).value,
                  child: Text(
                    question.questionText!,
                    style: AppTextStyle.suggestionononwol,
                    textScaleFactor: textScale,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 12,
            ).value,
          ),
          Obx(
            () => dropDownAssistor(
              options: [
                for (var option in question.questionOptionVO) option.optionText,
              ],
              isExpanded: conroller.dropDownStatus[question],
              label:
                  conroller.questionToAnswerMap[question].toString() == 'Select'
                      ? "Select"
                      : (conroller.questionToAnswerMap[question]
                              as QuestionOptionModel)
                          .optionText,
              color: blueDarkShade,
              onTap: () {
                conroller.toggleDropdown(
                  questionModel: question,
                );
              },
              conroller: conroller,
              questionIdModel: question,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
