import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/rate-recommendation-flow-remote-service.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-mood-model.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  RateRecommendationFlowRemoteServiceImpl remoteDataSourceImpl;
  MockCustomApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = RateRecommendationFlowRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  const tFeedbackModel=FeedbackModel(
      subjectMoodVO: FeedbackMoodModel(
          mood: "NEUTRAL",
          activityType:"ONBOARDING"
      ),
      minutesSpent: 15,
      feedbackThoughts: "",
      recommendationId: "",
      actionId: 19389
  );

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client.get(uri: APIRoute.rateActivityFeedback)).thenAnswer(
          (_) async => http.Response(
          unit.toString(), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(uri: APIRoute.rateActivityFeedback)).thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }


  //? Actual tests go here
  group('DATA SOURCE : rateRecommendationFlow{Remote}', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteDataSourceImpl.rateRecommendationFlow(feedback: tFeedbackModel);
    //   //assert
    //   verify(
    //     client.get(uri: APIRoute.rateActivityFeedback),
    //   );
    // });
    // test(
    //     'should return unit when call statusCode is 200',
    //         () async {
    //       //arrange
    //       setupHttpSuccessClient200();
    //       //act
    //       final result = await remoteDataSourceImpl.rateRecommendationFlow(feedback: tFeedbackModel);
    //       //assert
    //       expect(result, unit);
    //     });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteDataSourceImpl.rateRecommendationFlow(feedback: tFeedbackModel);
    //   //assert
    //   expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    // });
  });
}