import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-category-activites-remote-data-source_test.mocks.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late GetCategoryActivitiesRemoteDataSourceImpl remoteDataSourceImpl;
  late BaseUrlController urlController;
  MockApiClient? client;
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
  final tRecommendations=RecommendationCategoryModel.fromDomain(
    RecommendationCategory(
        id: 2,
        categoryName: "MENTAL",
        displayTitle: "Mental",
        displaySubtitle: "Focus on your mind",
        categoryDetailedDescription: "This is mental category",
        categoryShortDescription: "Focus on your mind",
        iconVO:  ImageEntity(
            type: '',
            url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
    )
  );

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.post(uri: APIRoute.getAllRecommendationsByCategory,body: jsonEncode(tRecommendations.toJson()))).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'recommendation-model.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.post(uri: APIRoute.getAllRecommendationsByCategory,body: jsonEncode(tRecommendations.toJson())),
    ).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : getAllRecommendationsByCategory{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getActivities(category: tRecommendations);
      print("hello");
      //assert
      verify(
        client!.post(uri: APIRoute.getAllRecommendationsByCategory,body: jsonEncode(tRecommendations.toJson())),
      );
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = await remoteDataSourceImpl.getActivities(category: tRecommendations);
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
