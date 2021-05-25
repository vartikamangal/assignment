import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/prioritize-remote-service.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/success-prioritize.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends http.Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox sessionClient;
  PrioritizeRemoteServiceImpl remoteServiceImpl;

  setUp(() {
    client = MockHttpClient();
    sessionClient = MockBox();
    remoteServiceImpl = PrioritizeRemoteServiceImpl(
      client: client,
      sessionClient: sessionClient,
    );
  });

  const tAreas = [
    LifeAreaModel(
      areaCode: "CAREER",
      description: 'Your job, business and aspirations',
      name: 'Career',
    ),
    LifeAreaModel(
      areaCode: "FINANCES",
      description: 'Your relationship with money',
      name: 'Finances',
    ),
    LifeAreaModel(
      areaCode: "HEALTH",
      description: 'Your body, sickness and wellness',
      name: 'Health',
    ),
    LifeAreaModel(
      areaCode: "FAMILY_AND_FRIENDS",
      description: 'Relationships in your life',
      name: 'Family and Friends',
    ),
    LifeAreaModel(
      areaCode: "ROMANCE",
      description: 'Romantic love and partnership',
      name: 'Romance',
    ),
    LifeAreaModel(
      areaCode: "PERSONAL_GROWTH",
      description: 'Aims, goals and aspirations',
      name: 'Personal Growth',
    ),
    LifeAreaModel(
      areaCode: "FUN_AND_RECREATION",
      description: 'Entertainment and leisure',
      name: 'Fun and Recreation',
    ),
    LifeAreaModel(
      areaCode: "PHYSICAL_ENVIRONMENT",
      description: 'Your surroundings',
      name: 'Physical Environment',
    ),
  ];

  const tLifeAreaPrioritizationModel =
      LifeAreaModelForPrioritization(lifeaAreas: tAreas);

  void setupHttpSuccessClient200({@required String path}) {
    when(
      client.post(
        Uri.parse(APIRoute.prioritizeAreas),
        headers: anyNamed('headers'),
        body: jsonEncode(tLifeAreaPrioritizationModel.toJson()),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: path),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(
        Uri.parse(APIRoute.prioritizeAreas),
        headers: anyNamed('headers'),
        body: jsonEncode(tLifeAreaPrioritizationModel.toJson()),
      ),
    ).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : Priotize[WOL]{Remote}', () {
    test('should send a POST request to the specified URL', () async {
      //arrange
      setupHttpSuccessClient200(path: 'success-prioritize-response.json');
      //act
      await remoteServiceImpl.prioritize(
          lifeAreas: tLifeAreaPrioritizationModel);
      //assert
      verify(
        client.post(
          Uri.parse(APIRoute.prioritizeAreas),
          headers: {
            'content-type': 'application/json',
          },
          body: jsonEncode(tLifeAreaPrioritizationModel.toJson()),
        ),
      );
    });
    test(
        'should return SuccessPrioritize if the statusCode is 200 and response is 1',
        () async {
      //arrange
      setupHttpSuccessClient200(path: 'success-prioritize-response.json');
      //act
      final result = await remoteServiceImpl.prioritize(
        lifeAreas: tLifeAreaPrioritizationModel,
      );

      //assert
      expect(result, SuccessPrioritize());
    });
    test('should throw ServerException when responseBody is not 1', () async {
      //arrange
      setupHttpSuccessClient200(path: 'failed-prioritize-response.json');
      //act
      final call = remoteServiceImpl.prioritize;
      //assert
      expect(
        () => call(lifeAreas: tLifeAreaPrioritizationModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteServiceImpl.prioritize;
      //assert
      expect(
        () => call(lifeAreas: tLifeAreaPrioritizationModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
