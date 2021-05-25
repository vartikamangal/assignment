import 'package:flutter/cupertino.dart';
import 'rating-scale-model.dart';
import '../../domain/entities/satisfaction-rating-map-for-time-provision-scale.dart';

import 'life-area-model.dart';

class SatisfactionRatingMapForTimeProvisionModel
    extends SatisfactionRatingMapForTimeProvision {
  SatisfactionRatingMapForTimeProvisionModel({
    @required RatingScaleModel rating,
    @required LifeAreaModel lifeArea,
  }) : super(rating: rating, lifeArea: lifeArea);

  Map<String, dynamic> toJson() {
    return {
      lifeArea.areaCode: {
        {
          "ratingValue": rating.ratingValue,
          "ratingScaleName": rating.ratingScaleName,
          "minValue": rating.min,
          "maxValue": rating.max
        }
      },
    };
  }
}
