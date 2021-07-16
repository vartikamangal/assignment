import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'activity-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient client;
  late AcitivityRemoteDataSourceImpl remoteDataSourceImpl;
  late BaseUrlController urlController;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    urlController = Get.put(BaseUrlController());
    remoteDataSourceImpl = AcitivityRemoteDataSourceImpl(
        apiClient: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });
  const tUnit = unit;
  const tMoodFeedbackModelForActivity =
  MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType');

  const tFeedback = ActivityRatingModel(
      subjectMoodVO: tMoodFeedbackModelForActivity,
      minutesSpent: 1,
      feedbackThoughts: 'feedbackThoughts',
      recommendationId: 'recommendationId',
      actionId: 1);
  void setupHttpSuccessClient200() {
    when(
      client.post(
          uri: APIRoute.rateActivityFeedback,
          body: jsonEncode(tFeedback.toJson())),
    ).thenAnswer(
          (_) async => http.Response(
        fixtureReader(filename: 'activity-remote-data.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(
          uri: APIRoute.rateActivityFeedback,
          body: jsonEncode(tFeedback.toJson())),
    ).thenAnswer(
          (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : rateActivity', () {
    test(
        'should send a GET request to the specified URL for getting required data',
            () async {
          //arrange
          setupHttpSuccessClient200();
          //act
          await remoteDataSourceImpl.rateActivity(feedback: tFeedback);
          //assert
          verify(client.post(
              uri: APIRoute.rateActivityFeedback,
              body: jsonEncode(tFeedback.toJson())));
        });
    test('should return the Feedback model if the statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result =
      await remoteDataSourceImpl.rateActivity(feedback: tFeedback);
      //assert
      expect(result, tUnit);
    });
    test('should throw a ServerException if statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.rateActivity(feedback: tFeedback);
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}