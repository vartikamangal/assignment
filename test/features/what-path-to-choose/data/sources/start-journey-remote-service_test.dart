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

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/start-journey-remote-service.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey_started_success.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  StartJourneyRemoteServiceImp remoteServiceImpl;

  setUp(() {
    client = MockHttpClient();
    localClient = MockBox();
    remoteServiceImpl = StartJourneyRemoteServiceImp(
      client: client,
      sessionClient: localClient,
    );
  });

  const tJourneyModel = JourneyModel(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description:
          "Only one area of focus per week, Daily small wins at your own pace",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
      pathName: "SMALL_WINS");

  void setupHttpSuccessClient200({@required String testFileName}) {
    when(client.post(Uri.parse(APIRoute.startJourney),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.post(Uri.parse(APIRoute.startJourney),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : StartJourney{Remote}', () {
    test('should perform a POST request on the specfied URL', () async {
      //arrange
      setupHttpSuccessClient200(
          testFileName: 'start-journey-remote-success.json');
      //act
      final result =
          await remoteServiceImpl.startJourney(journey: tJourneyModel);
      //assert
      verifyNever(client.post(
        Uri.parse(APIRoute.startJourney),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            "id": 1,
            "title": "Small Wins Path",
            "subtitle": "Weekly focus areas. Choose your own experiences.",
            "description":
                "Only one area of focus per week, Daily small wins at your own pace",
            "icon": null,
            "pathName": "SMALL_WINS"
          },
        ),
      ));
    });
    test(
        'should return StartJourneySuccess if response is 1 and statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200(
          testFileName: 'start-journey-remote-success.json');
      //act
      final result =
          await remoteServiceImpl.startJourney(journey: tJourneyModel);
      //assert
      expect(result, SuccessJourneyStart());
    });
    test('should throw ServerException if response is not 1', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'set-subject-mood-failed.json');
      //act
      final call = remoteServiceImpl.startJourney;
      //assert
      expect(
        () => call(journey: tJourneyModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
    test('should throw ServerException if statusCode is not 404', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = await remoteServiceImpl.startJourney;
      //assert
      expect(
        () => call(journey: tJourneyModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
