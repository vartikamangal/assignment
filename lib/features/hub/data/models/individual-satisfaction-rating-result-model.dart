import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/individual-satisfaction-rating-result.dart';

class IndividualSatisfactionRatingResultModel
    extends IndividualSatisfactionRating {
  const IndividualSatisfactionRatingResultModel({
    @required int id,
    @required int rating,
    @required DefaultRatingScaleModel scale,
  }) : super(
          scale: scale,
          rating: rating,
          id: id,
        );

  factory IndividualSatisfactionRatingResultModel.fromJson(
      Map<String, dynamic> jsonMap) {
    return IndividualSatisfactionRatingResultModel(
      id: jsonMap['id'] as int,
      rating: jsonMap['rating'] as int,
      scale: DefaultRatingScaleModel.fromJson(
        jsonMap['scale'] as Map<String, dynamic>,
      ),
    );
  }
}
