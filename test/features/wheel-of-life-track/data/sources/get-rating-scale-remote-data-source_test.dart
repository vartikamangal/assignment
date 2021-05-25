import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/get-rating-scale-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox sessionClient;
  GetRatingScaleRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    client = MockHttpClient();
    sessionClient = MockBox();
    remoteDataSourceImpl = GetRatingScaleRemoteDataSourceImpl(
      client: client,
      sessionClient: sessionClient,
    );
  });

  final tRatingScale = RatingScaleModel(
    min: 0,
    max: 0,
    ratingValue: 0,
    ratingScaleName: null,
  );

  void setupHttpSuccessClient200() {
    when(client.get(Uri.parse(APIRoute.getRatingScale),
            headers: anyNamed('headers')))
        .thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'get-rating-scale-raw-response.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(Uri.parse(APIRoute.getRatingScale),
            headers: anyNamed('headers')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : GetRatingScale{Remote}', () {
    test('should send a GET request to the specified URL', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getRatingScale();
      //assert
      verify(
        client.get(
          Uri.parse(APIRoute.getRatingScale),
          headers: {
            "content-type": "application/json",
          },
        ),
      );
    });
    test('should return a ratingScale if statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getRatingScale();
      //assert
      expect(result, tRatingScale);
    });
    test('should throw a ServerException when the statusCode is not 200',
        () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getRatingScale;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
