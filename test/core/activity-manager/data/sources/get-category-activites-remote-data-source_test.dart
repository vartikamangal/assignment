import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-category-activites-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late MockApiClient client;
  late GetCategoryActivitiesRemoteDataSourceImpl remoteDataSourceImpl;
  BaseUrlController urlController;

  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetCategoryActivitiesRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final tRecommendations = RecommendationModel.fromDomain(Recommendation(
      activity: Activity(
          id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: ImageEntity(
              type: '',
              url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
          durationInMinutes: 15,
          messageOnReceivingFeedback: " This is an encouraging message",
          messageOnCompletion:
              "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
          recommendationStatus: "ENABLED",
          frequencyMetric: "WEEKLY",
          frequency: 1,
          actionTime: "DO_NOW",
          criticality: "LOW",
          categoryVO: RecommendationCategory(
              id: 1,
              categoryName: "PHYSICAL",
              displayTitle: "Physical",
              displaySubtitle: "Focus on the body",
              categoryDetailedDescription: "This is physical category for body",
              categoryShortDescription: "Focus on the body",
              iconVO: ImageEntity(
                  type: '',
                  url:
                      'https://images.unsplash.com/photo-1547721064-da6cfb341d50')),
          tags: <Tag>[
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null),
            Tag(
                name: "ROMANCE_LOW",
                tagCategory: "WOL_SATISFACTION_RATING",
                displayName: "Satisfaction low for Romance",
                parentName: "ROMANCE"),
            Tag(
                name: "WORK_FROM_HOME",
                tagCategory: "FOCUS_ISSUE",
                displayName: "Work form home",
                parentName: null),
            Tag(
                name: "LOSING_TEMPER",
                tagCategory: "INSTANT_RELIEF",
                displayName: "Losing Temper",
                parentName: null),
          ],
          activitySteps: []),
      weight: 1.0));

  final tRecommendationCategory =
      RecommendationCategoryModel.fromDomain(RecommendationCategory(
    id: 2,
    categoryName: "MENTAL",
    displayTitle: "Mental",
    displaySubtitle: "Focus on your mind",
    categoryDetailedDescription: "This is mental category",
    categoryShortDescription: "Focus on your mind",
    iconVO: ImageEntity(
        type: 'png',
        url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
  ));

  // Helper functions

  void setupHttpSuccessClient200() {
    when(
      client.post(
          uri: APIRoute.getAllRecommendationsByCategory,
          body: jsonEncode(tRecommendationCategory.toJson())),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'category-activity-remote-data.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(
          uri: APIRoute.getAllRecommendationsByCategory,
          body: jsonEncode(tRecommendationCategory.toJson())),
    ).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : getAllRecommendationsByCategory', () {
    test(
        'should send a GET request to the specified URL for getting required data',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getActivities(
          category: tRecommendationCategory);
      //assert
      verify(client.post(
          uri: APIRoute.getAllRecommendationsByCategory,
          body: jsonEncode(tRecommendationCategory.toJson())));
    });
    test('should return the Recommendation model if the statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getActivities(
          category: tRecommendationCategory);
      //assert
      expect(result.toString(), tRecommendations.toString());
    });
    test('should throw a ServerException if statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call =
          remoteDataSourceImpl.getActivities(category: tRecommendationCategory);
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
