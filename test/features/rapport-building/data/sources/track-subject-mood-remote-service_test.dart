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
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/track-subject-mood-remote-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  TrackSubjectMoodRemoteServiceImpl serviceImpl;
  MockCustomApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    serviceImpl = TrackSubjectMoodRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final MoodTracking tMoodTrack = MoodTrackingModel(
    activityType: 'ONBOARDING',
    createdWhen: DateTime.parse('2021-04-10 13:38:35.105'),
    id: 3,
    mood: 'NEUTRAL',
    moodDuration: 'SEVEN_DAYS',
    subjectId: const SubjectIdModel(id: '74a439b1-396b-43c2-a859-608c055a78a3'),
  );

  void setupHttpSuccessClient200({@required String responseFilePath}) {
    when(
      client.post(uri: APIRoute.setMoodDuration, body: anyNamed('body')),
    ).thenAnswer(
      (_) async =>
          http.Response(fixtureReader(filename: responseFilePath), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(uri: APIRoute.setMoodDuration, body: anyNamed('body')),
    ).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : TrackSubjectMood{Remote}', () {
    test('should perform a POST request on the specified URL', () async {
      //arrange
      setupHttpSuccessClient200(
        responseFilePath: 'track-subject-mood-raw-response-success.json',
      );
      //act
      await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      verify(
        client.post(
          uri: APIRoute.setMoodDuration,
          body: jsonEncode((tMoodTrack as MoodTrackingModel).toJson()),
        ),
      );
    });
    test('should return TrackMoodSuccess when statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200(
        responseFilePath: 'track-subject-mood-raw-response-success.json',
      );
      //act
      final result = await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      expect(result, TrackMoodSuccess());
    });

    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = serviceImpl.trackMood;
      //assert
      expect(
        () => call(mood: tMoodTrack),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
