// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'set-subject-mood-remote-service_test.mocks.dart';
@GenerateMocks([ApiClient])

Future<void> main() async {
  late RapportBuildingRemoteDataSourceImpl remoteServiceImpl;
  late BaseUrlController urlController;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = RapportBuildingRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  //? helpers vars
  const tMoodName = 'NEUTRAL';
  const tActivityType = 'ONBOARDING';
  final tMoodTrackingModel = MoodTrackingModel(
    subjectId: const SubjectIdModel(id: "b0d388a5-78e5-4520-a137-41336265c978"),
    id: 18703,
    moodDuration: null,
    activityType: "ONBOARDING",
    mood: "BAD",
    createdWhen: DateTime.parse("2021-06-21 03:03:46.071Z"),
  );

  //? helper functions
  void setupHttpSuccessClient200({required String testFileName}) {
    when(
      client!.post(uri: APIRoute.setMood, body: anyNamed('body')),
    ).thenAnswer(
      (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.post(uri: APIRoute.setMood, body: anyNamed('body'))).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : SetSubjectMood{Remote}', () {
    test('should perform a POST request on the specfied URL', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-success.json');
      //act
      await remoteServiceImpl.setMood(
        moodName: tMoodName,
        activityType: tActivityType,
      );
      //assert
      verify(client!.post(
        uri: APIRoute.setMood,
        body: jsonEncode(
          {
            "mood": tMoodName,
            //TODO To be changed later
            "activityType": "ONBOARDING",
          },
        ),
      ));
    });
    test('should return SetMoodSucess if statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-success.json');
      //act
      final result = await remoteServiceImpl.setMood(
        moodName: tMoodName,
        activityType: tActivityType,
      );
      //assert
      expect(result, tMoodTrackingModel);
    });

    test('should throw ServerException if statusCode is not 404', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final Future<MoodTrackingModel> Function({String activityType, String moodName}) call = remoteServiceImpl.setMood;
      //assert
      expect(
        () => call(
          moodName: tMoodName,
          activityType: tActivityType,
        ),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
