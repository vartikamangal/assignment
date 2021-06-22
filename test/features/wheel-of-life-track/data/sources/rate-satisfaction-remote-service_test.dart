// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-rating-map-for-time-provision-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/rate-satisfaction-remote-service.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rated-satisfaction-success.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  MockCustomApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  RateSatisfactionRemoteServiceImpl serviceImpl;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    serviceImpl = RateSatisfactionRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

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

  void setupHttpSuccessClient200({@required String path}) {
    when(
      client.post(
        uri: APIRoute.setUserSatisfaction,
        body: jsonEncode(tSatisfactionRatings.toJson()),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: path),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(
        uri: APIRoute.setUserSatisfaction,
        body: jsonEncode(tSatisfactionRatings.toJson()),
      ),
    ).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : RateSatisfactionService{Remote}', () {
    test('should send a POST request to the specified url', () async {
      //arrange
      setupHttpSuccessClient200(
        path: 'set-user-satisfaction-success-resposne.json',
      );
      //act
      await serviceImpl.rateSatisfaction(ratings: tSatisfactionRatings);
      //assert
      verify(
        client.post(
          uri: APIRoute.setUserSatisfaction,
          body: jsonEncode(tSatisfactionRatings.toJson()),
        ),
      );
    });
    test(
        'should return SuccessRatedSatisfaction when statusCode is 200 and body is 1',
        () async {
      //arrange
      setupHttpSuccessClient200(
        path: 'set-user-satisfaction-success-resposne.json',
      );
      //act
      final result = await serviceImpl.rateSatisfaction(
        ratings: tSatisfactionRatings,
      );
      //assert
      expect(result, SuccessRatedSatisfaction());
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = serviceImpl.rateSatisfaction;
      //assert
      expect(
        () => call(
          ratings: tSatisfactionRatings,
        ),
        throwsA(
          const TypeMatcher<ServerException>(),
        ),
      );
    });
  });
}
