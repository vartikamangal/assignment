// Package imports:
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-rating-map-for-time-provision-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-rating-map-for-time-provision-scale.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tLifeAreasWithTimeProvision =
      SatisfactionRatingMapForTimeProvisionModel(
          rating: RatingScaleModel(
            min: 1,
            max: 5,
            ratingValue: 2,
            ratingScaleName: 'WOL_SATISFACTION_RATING',
          ),
          lifeArea: const LifeAreaModel(
            areaCode: "CAREER",
            name: "Career",
            description: "Your job, business and aspirations",
          ));

  group("Model SatisfactionRatingMapForTimeProvisionModel", () {
    test('should be a SatisfactionRatingMapForTimeProvision', () async {
      //assert
      expect(tLifeAreasWithTimeProvision,
          isA<SatisfactionRatingMapForTimeProvision>());
    });
    test(
        'toJson should convert SatisfactionRatingMapForTimeProvision into  Json format',
        () async {
      //arrange
      final expectedJson = {
        "CAREER": {
          {
            "ratingValue": 2,
            "ratingScaleName": "WOL_SATISFACTION_RATING",
            "minValue": 1,
            "maxValue": 5
          }
        },
      };
      //act
      final result = tLifeAreasWithTimeProvision.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
