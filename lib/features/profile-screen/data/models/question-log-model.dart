import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';

class QuestionLogModel extends QuestionLog {
  const QuestionLogModel({
    @required int id,
    @required DateTime answeredWhen,
    @required QuestionModel question,
    @required List<QuestionOptionModel> optionChosen,
    @required String additionalInformation,
  }) : super(
          answeredWhen: answeredWhen,
          id: id,
          additionalInformation: additionalInformation,
          optionChosen: optionChosen,
          question: question,
        );

  factory QuestionLogModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionLogModel(
      id: jsonMap['id'] as int,
      answeredWhen: jsonMap['answeredWhen'] as DateTime,
      question: QuestionModel.fromJson(
        jsonMap['question'] as Map<String, dynamic>,
      ),
      optionChosen: (jsonMap['optionChosen'] as List)
          .map(
            (rawOption) =>
                QuestionOptionModel.fromJson(rawOption as Map<String, dynamic>),
          )
          .toList(),
      additionalInformation: jsonMap['additionalInformation'] as String,
    );
  }
}
