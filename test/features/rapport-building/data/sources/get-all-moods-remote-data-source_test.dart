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
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-all-moods-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])

Future<void> main() async {
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  late RapportBuildingRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = RapportBuildingRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  //Helpers Variables
  const tMoods = <MoodModel>[
    MoodModel(
      id: 1,
      moodName: "VERY_BAD",
      moodDescription: "Very sad",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    ),
    MoodModel(
      id: 2,
      moodName: "BAD",
      moodDescription: "Sad",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    ),
    MoodModel(
      id: 3,
      moodName: "NEUTRAL",
      moodDescription: "Neutral",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    ),
    MoodModel(
      id: 4,
      moodName: "GOOD",
      moodDescription: "Happy",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    ),
    MoodModel(
      id: 5,
      moodName: "VERY_GOOD",
      moodDescription: "Very Happy",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    ),
  ];

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.get(uri: APIRoute.getMoods)).thenAnswer(
      (_) async =>
          http.Response(fixtureReader(filename: 'raw-moods.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getMoods)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : GetAllMoods{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getMoods();
      //assert
      verify(
        client!.get(uri: APIRoute.getMoods),
      );
    });
    test('should return List<MoodModel> when call statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getMoods();
      //assert
      expect(result, tMoods);
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getMoods;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
