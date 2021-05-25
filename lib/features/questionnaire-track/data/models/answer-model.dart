import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-id-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/answer.dart';

class AnswerModel extends Answer {
  const AnswerModel({
    @required QuestionIdModel question,
    @required List<QuestionOptionModel> optionChosen,
    @required String additionalInformation,
  }) : super(
          additionalInformation: additionalInformation,
          optionChosen: optionChosen,
          question: question,
        );

  factory AnswerModel.fromJson(Map<String, dynamic> jsonMap) {
    return AnswerModel(
      question: QuestionIdModel.fromJson(
        jsonMap['question'] as Map<String, dynamic>,
      ),
      optionChosen: (jsonMap['optionChosen'] as List)
          .map(
            (option) => QuestionOptionModel.fromJson(
              option as Map<String, dynamic>,
            ),
          )
          .toList(),
      additionalInformation: jsonMap['additionalInformation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "question": {"id": "04ca410e-5188-4d09-8802-b61d5ac3b357"},
      "optionChosen": optionChosen.map((option) => null).toList(),
      "additionalInformation": additionalInformation,
    };
  }
}
