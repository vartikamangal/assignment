import 'package:flutter/foundation.dart';
import '../../domain/entities/question-info.dart';

class QuestionInfoModel extends QuestionInfo {
  const QuestionInfoModel({
    @required int id,
    @required String questionText,
    @required String questionExplanation,
  }) : super(
          questionExplanation: questionExplanation,
          id: id,
          questionText: questionText,
        );

  factory QuestionInfoModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionInfoModel(
      id: jsonMap['id'] as int,
      questionText: jsonMap['questionText'] as String,
      questionExplanation: jsonMap['questionExplanation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "questionText": questionText,
      "questionExplanation": questionExplanation
    };
  }
}
