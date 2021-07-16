import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/add-weekly-category-remote-service.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture-reader.dart';
import 'add-weekly-category-remote-service_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late AddWeeklyCategoryRemoteServiceImpl remoteServiceImpl;
  late BaseUrlController urlController;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = AddWeeklyCategoryRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  void setupHttpSuccessClient200() {
    when(client!.post(
            uri: '${APIRoute.addWeeklyCategory}${1}', body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'recommendation-category-model.json'), 200),
    );
  }

  final tRecommendationCategoryModel=  RecommendationCategoryModel.fromDomain(
   RecommendationCategory( id: 2,
     categoryName: "MENTAL",
     displayTitle: "Mental",
     displaySubtitle: "Focus on your mind",
     categoryDetailedDescription: "This is mental category",
     categoryShortDescription: "Focus on your mind",
     iconVO: ImageEntity(
         type: '',
         url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
     ),);

  int weekNumber=1;
  void setupHttpFailureClient404() {
    when(client!.post(
            uri: '${APIRoute.addWeeklyCategory}${'$weekNumber'}', body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : addWeeklyCategory{Remote}', () {
     test('should perform a POST request on the specfied URL', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteServiceImpl.addWeeklyCategory(
          weekNumber: 1,category: tRecommendationCategoryModel
      );
      //assert
      verify(client!.post(
        uri: '${APIRoute.addWeeklyCategory}${'$weekNumber'}',
        body: jsonEncode(
          {
            "weekNumber": weekNumber,
            "category": tRecommendationCategoryModel
          },
        ),
      ));
    });

    test('should return unit when call statusCode is 200',
            () async {
          //arrange
          setupHttpSuccessClient200();
          //act
          final result = await remoteServiceImpl.addWeeklyCategory(weekNumber: 1,category: tRecommendationCategoryModel);
          //assert
          expect(result, unit);
        });
    // test('should throw ServerException if statusCode is not 404', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteServiceImpl.addWeeklyCategory(weekNumber: 1,category: tRecommendationCategoryModel);
    //   //assert
    //   expect(
    //         () => call,
    //     // ignore: deprecated_member_use
    //     throwsA( const TypeMatcher<ServerException>()),
    //   );
    // });
  });
}
