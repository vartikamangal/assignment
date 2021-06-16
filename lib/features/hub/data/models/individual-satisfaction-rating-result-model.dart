// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../domain/entities/individual-satisfaction-rating-result.dart';
import 'default-rating-scale-model.dart';

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
