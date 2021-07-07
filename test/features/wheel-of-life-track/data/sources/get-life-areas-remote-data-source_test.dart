// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-life-areas-remote-data-source_test.mocks.dart';
@GenerateMocks([ApiClient])

Future<void> main() async {
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  late WheelOfLifeRemoteDataSourceImpl sourceImpl;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    sourceImpl = WheelOfLifeRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
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

  void setupHttpSuccessClient200() {
    when(
      client!.get(uri: APIRoute.getWolAreas),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'get-wol-areas-raw-repsonse.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client!.get(uri: APIRoute.getWolAreas),
    ).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : GetLifeAreas{Remote}', () {
    test(
        'should send a GET request to the specified URL for getting required data',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await sourceImpl.getAreas();
      //assert
      verify(
        client!.get(
          uri: APIRoute.getWolAreas,
        ),
      );
    });
    test('should return the List<LifeAreaModel> if the statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await sourceImpl.getAreas();
      //assert
      expect(result, tAreas);
    });
    test('should throw a ServerException if statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = sourceImpl.getAreas;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
