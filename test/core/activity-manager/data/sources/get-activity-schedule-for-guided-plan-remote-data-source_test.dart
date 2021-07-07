import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-scedule-guided-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/path-information-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-activity-schedule-for-guided-plan-remote-data-source_test.mocks.dart';
@GenerateMocks([ApiClient])

Future<void> main() async {
  late GetActivityScheduleForGuidedPlanRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetActivityScheduleForGuidedPlanRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });
  const tActivityScheduledGuidedModel = ActivityScheduleGuidedModel(
    id: 3441,
    tags: [],
    pathInformation: PathInformationModel(
        id: 3442,
        description: "Curated Path for stress management",
        title: "Stress management",
        subtitle: "This will help you manage stress better",
        helpContent: "Just putting some help content for future use",
        lengthOfPlan: 23),
    activitySchedule: <GuidedActivityRecommendationModel>[
      GuidedActivityRecommendationModel(
          id: 3443,
          dayNumber: 1,
          icon: null,
          description: "Day 1 of stress management",
          title: "Day 1",
          subtitle: "Perform this day with smile",
          helpContent: "Some useless help content",
          recommendationList: <ActivityRecommendationModel>[])
    ],
  );

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.get(uri: APIRoute.getActivityScheduleForGuided)).thenAnswer(
      (_) async => http.Response(
          fixtureReader(
              filename: 'raw-activity-scheduled-for-guided-plan.json'),
          200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getActivityScheduleForGuided)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

 // ? Actual tests go here
 //   group('DATA SOURCE : getSchedule{Remote}', () {
 //     test('should send a get request to specifed url', () async {
 //       //arrange
 //       setupHttpSuccessClient200();
 //       //act
 //       await remoteDataSourceImpl.getSchedule();
 //       // ignore: avoid_print
 //       print("hello");
 //       //assert
 //       verify(
 //         client!.post(uri: APIRoute.getActivityScheduleForGuided),
 //       );
 //     });
 //     test('should return ActivityScheduledModel when call statusCode is 200',
 //         () async {
 //       //arrange
 //       setupHttpSuccessClient200();
 //       //act
 //       final result = await remoteDataSourceImpl.getSchedule();
 //       print("hello");
 //       //assert
 //       expect(result, tActivityScheduledGuidedModel);
 //     });
 //     test('should throw ServerException when statusCode is not 200', () async {
 //       //arrange
 //       setupHttpFailureClient404();
 //        //act
 //       final call = remoteDataSourceImpl.getSchedule();
 //      //assert
 //      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
 //    });
 //   });
}
