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
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-instant-relief-areas-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])

Future<void> main() async {
  late InstantReliefRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = InstantReliefRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  const tInstantReliefAreas = <InstantReliefAreaModel>[
    InstantReliefAreaModel(
        id: 1,
        title: "title",
        subtitle: "subtitle",
        instantReliefName: "instantReliefName",
        description: "description",
        icon: "")
  ];

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.get(uri: APIRoute.getInstantReliefAreas)).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'raw-instant-relief-area.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getInstantReliefAreas)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : GetInstantReliefAreas{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getReliefAreas();
      //assert
      verify(
        client!.get(uri: APIRoute.getInstantReliefAreas),
      );
    });
    test(
        'should return List<InstantReliefAreaModel> when call statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getReliefAreas();
      //assert
      expect(result, tInstantReliefAreas);
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getReliefAreas();
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
