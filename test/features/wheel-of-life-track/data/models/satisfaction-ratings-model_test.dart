// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-rating-map-for-time-provision-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-ratings.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tLifeAreaTimeProvisions = [
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
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "ROMANCE",
        name: "Romance",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "PERSONAL_GROWTH",
        name: "PERSONAL_GROWTH",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FINANCES",
        name: "FINANCES",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "HEALTH",
        name: "HEALTH",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FAMILY_AND_FRIENDS",
        name: "FAMILY_AND_FRIENDS",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FUN_AND_RECREATION",
        name: "FUN_AND_RECREATION",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "PHYSICAL_ENVIRONMENT",
        name: "PHYSICAL_ENVIRONMENT",
        description: "Your job, business and aspirations",
      ),
    ),
  ];

  final tSatisfactionRatings = SatisfactionRatingsModel(
    satisfactionRatings: tLifeAreaTimeProvisions,
  );

  group('Model SatisfactionRatingsModel', () {
    test('should be a SatisfactionRatings', () async {
      //assert
      expect(tSatisfactionRatings, isA<SatisfactionRatings>());
    });
    test(
        'toJson should convert the passed SatisfactionRatingsModel into Json format',
        () async {
      //arrange
      final expectedJson = jsonDecode(fixtureReader(
              filename: 'create-life-satisfaction-to-be-posted.json'))
          as Map<String, dynamic>;
      //act
      final result = tSatisfactionRatings.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
