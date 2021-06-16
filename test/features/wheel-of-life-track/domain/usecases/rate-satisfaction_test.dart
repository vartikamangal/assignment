// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rated-satisfaction-success.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-rating-map-for-time-provision-scale.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-ratings.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/rate-satisfaction-service.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/usecases/rate-satisfaction.dart';

class MockRateSatisfactionService extends Mock
    implements RateSatisfactionService {}

void main() {
  MockRateSatisfactionService service;
  RateSatisfaction useCase;

  setUp(() {
    service = MockRateSatisfactionService();
    useCase = RateSatisfaction(service: service);
  });

  final tAreasRatedAsPerTime = <SatisfactionRatingMapForTimeProvision>[
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "CAREER",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "ROMANCE",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "PERSONAL_GROWTH",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "FINANCES",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "HEALTH",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: LifeAreaModel(
        areaCode: "FAMILY_AND_FRIENDS",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: const LifeAreaModel(
        areaCode: "FUN_AND_RECREATION",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 0,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
    SatisfactionRatingMapForTimeProvision(
      lifeArea: const LifeAreaModel(
        areaCode: "PHYSICAL_ENVIRONMENT",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
      rating: RatingScaleModel(
          min: 1,
          max: 5,
          ratingValue: 0,
          ratingScaleName: 'WOL_SATISFACTION_RATING'),
    ),
  ];

  // This will be sent to test (holds the above list for cleaner code)
  final tRatings =
      SatisfactionRatings(satisfactionRatings: tAreasRatedAsPerTime);

  final tSuccess = SuccessRatedSatisfaction();

  group('USECASE : rateSatisfaction', () {
    test('should save userSatisfactionRatings using the service', () async {
      //arrange
      when(service.rateSatisfactionService(satisfactionRatings: tRatings))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result = await useCase(RateSatisfactionParams(ratings: tRatings));
      //assert
      verify(service.rateSatisfactionService(satisfactionRatings: tRatings));
      expect(result, Right(tSuccess));
    });
  });
}
