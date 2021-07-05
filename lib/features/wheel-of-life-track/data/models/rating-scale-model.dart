// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/rating-scale.dart';

class RatingScaleModel extends RatingScale {
  RatingScaleModel({
    required int? min,
    required int? max,
    required int? ratingValue,
    required String? ratingScaleName,
  }) : super(
          ratingScaleName: ratingScaleName,
          ratingValue: ratingValue,
          max: max,
          min: min,
        );

  factory RatingScaleModel.fromJson(Map<String, dynamic> jsonMap) {
    return RatingScaleModel(
      min: jsonMap['minValue'] as int?,
      max: jsonMap['maxValue'] as int?,
      ratingValue: jsonMap['ratingValue'] as int?,
      ratingScaleName: jsonMap['ratingScaleName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ratingValue": ratingValue,
      "ratingScaleName": ratingScaleName,
      "minValue": min,
      "maxValue": max,
    };
  }
}
