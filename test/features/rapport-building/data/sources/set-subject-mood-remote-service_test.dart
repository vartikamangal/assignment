import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-mood-remote-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/set-mood-success.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  SetSubjectMoodRemoteServiceImpl remoteServiceImpl;

  setUp(() {
    client = MockHttpClient();
    localClient = MockBox();
    remoteServiceImpl = SetSubjectMoodRemoteServiceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  //? helpers vars
  const tMoodName = 'NEUTRAL';
  const tActivityType = 'ONBOARDING';

  //? helper functions
  void setupHttpSuccessClient200({@required String testFileName}) {
    when(client.post(Uri.parse(APIRoute.setMood),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.post(Uri.parse(APIRoute.setMood),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : SetSubjectMood{Remote}', () {
    test('should perform a POST request on the specfied URL', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-success.json');
      //act
      final result = await remoteServiceImpl.setMood(
        moodName: tMoodName,
        activityType: tActivityType,
      );
      //assert
      verify(client.post(
        Uri.parse(APIRoute.setMood),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            "mood": tMoodName,
            //TODO To be changed later
            "activityType": "ONBOARDING",
          },
        ),
      ));
    });
    test('should return SetMoodSucess if response is 1 and statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-success.json');
      //act
      final result = await remoteServiceImpl.setMood(
        moodName: tMoodName,
        activityType: tActivityType,
      );
      //assert
      expect(result, SetMoodSuccess());
    });
    test('should throw ServerException if response is not 1', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-failed.json');
      //act
      final call = remoteServiceImpl.setMood;
      //assert
      expect(
        () => call(
          moodName: tMoodName,
          activityType: tActivityType,
        ),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
    test('should throw ServerException if statusCode is not 404', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = await remoteServiceImpl.setMood;
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
