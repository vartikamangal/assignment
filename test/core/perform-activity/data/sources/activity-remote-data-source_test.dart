import 'package:flutter_test/flutter_test.dart';
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
import 'activity-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient apiClient;
  late AcitivityRemoteDataSourceImpl remoteDataSourceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    apiClient = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = AcitivityRemoteDataSourceImpl(
        apiClient: apiClient,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  const tMoodFeedbackModelForActivity =
      MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType');

  const tFeedback = ActivityRatingModel(
      subjectMoodVO: tMoodFeedbackModelForActivity,
      minutesSpent: 1,
      feedbackThoughts: 'feedbackThoughts',
      recommendationId: 'recommendationId',
      actionId: 1);
  void setupHttpSuccessClient200() {
    when(apiClient.post(uri: APIRoute.rateActivityFeedback))
        .thenAnswer((_) async => http.Response('Success', 200));
  }

  void setupHttpFailureClient404() {
    when(apiClient.post(uri: APIRoute.rateActivityFeedback)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : getaction', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteServiceImpl.getAction(actionStatus: "COMPLETED");
    //   //assert
    //   verify(
    //     client!.get(uri: "${APIRoute.getActionWithActionStatus}${"/COMPLETED"}"),
    //   );
    // });
    // test('should return list<PostOnboardingActionModel> when call statusCode is 200',
    //         () async {
    //       //arrange
    //       setupHttpSuccessClient200();
    //       //act
    //       final result = await remoteServiceImpl.getAction(actionStatus: "COMPLETED");
    //       //assert
    //       expect(result, tPostOnboardingActionModel);
    //     });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.rateActivity(feedback: tFeedback);
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
