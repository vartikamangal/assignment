// Flutter imports:
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
    return QuestionOptionModel(
      id: jsonMap['id'] as String,
      optionText: jsonMap['optionText'] as String,
      optionCategory: jsonMap['optionCategory'] as String,
      additionalInformation: jsonMap['additionalInformation'] == null
          ? null
          : (jsonMap['additionalInformation'] as List)
              .map(
                (addnInfo) => RatingScaleModel.fromJson(
                  addnInfo['RatingScale'] as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
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
