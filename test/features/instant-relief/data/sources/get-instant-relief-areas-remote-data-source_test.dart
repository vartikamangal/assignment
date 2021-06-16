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
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/get-instant-relief-areas-remote-data-source.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async{
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  GetInstantReliefAreasRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    client = MockHttpClient();
    remoteDataSourceImpl = GetInstantReliefAreasRemoteDataSourceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  const tInstantReliefAreas=<InstantReliefAreaModel>[
    InstantReliefAreaModel(
        id: 1,
        title: "title",
        subtitle: "subtitle",
        instantReliefName: "instantReliefName",
        description: "description",
        icon: ImageProp(urlMedium: '',
        urlLarge: '',
        urlShort: ''))
  ];


  // Helper functions

  void setupHttpSuccessClient200() {
    when(client.get(Uri.parse(APIRoute.getInstantReliefAreas), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async =>
          http.Response(fixtureReader(filename: 'raw-instant-relief-area.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(Uri.parse(APIRoute.getInstantReliefAreas), headers: anyNamed('headers')))
        .thenAnswer(
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
        client.get(Uri.parse(APIRoute.getInstantReliefAreas), headers: {
          'content-type': 'application/json',
        }),
      );
    });
    test('should return List<InstantReliefAreaModel> when call statusCode is 200', () async {
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
