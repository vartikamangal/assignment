// Flutter imports:
import 'dart:convert';

import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../wheel-of-life-track/data/models/rating-scale-model.dart';
import '../../domain/entities/question-option.dart';

class QuestionOptionModel extends QuestionOption {
  const QuestionOptionModel({
    @required String id,
    @required String optionText,
    @required String optionCategory,
    @required List<RatingScaleModel> additionalInformation,
  }) : super(
          id: id,
          additionalInformation: additionalInformation,
          optionCategory: optionCategory,
          optionText: optionText,
        );

  factory QuestionOptionModel.fromJson(Map<String, dynamic> jsonMap) {
    //! Below mess is because of the differences between responses of questionLogs on profile & questionnaire screen
    // This case works for Profile screen
    try {
      final additionalInfo = jsonMap['additionalInformation'] != null
          ? jsonDecode(jsonMap['additionalInformation'] as String) as List
          : [];
      return QuestionOptionModel(
        id: jsonMap['id'] as String,
        optionText: jsonMap['optionText'] as String,
        optionCategory: jsonMap['optionCategory'] as String,
        additionalInformation: additionalInfo
            .map(
              (addnInfo) => RatingScaleModel.fromJson(
                addnInfo['RatingScale'] as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    } catch (e) {
      // This case works for Questionnaire screen
      return QuestionOptionModel(
        id: jsonMap['id'] as String,
        optionText: jsonMap['optionText'] as String,
        optionCategory: jsonMap['optionCategory'] as String,
        additionalInformation: (jsonMap['additionalInformation'] as List)
            .map(
              (addnInfo) => RatingScaleModel.fromJson(
                addnInfo['RatingScale'] as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "optionText": optionText,
      "optionCategory": optionCategory,
      // ignore: prefer_null_aware_operators
      "additionalInformation": additionalInformation == null
          ? null
          : additionalInformation
              .map(
                (addnInfo) => (addnInfo as RatingScaleModel).toJson(),
              )
              .toList(),
    };
  }
}
