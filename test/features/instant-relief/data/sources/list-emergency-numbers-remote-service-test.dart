import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/list-emergency-numbers-remote-service.dart';

import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async{
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  ListEmergencyNumberRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    client = MockHttpClient();
    remoteDataSourceImpl = ListEmergencyNumberRemoteDataSourceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  const tEmergencyNumber=<EmergencyNumberModel>[
    EmergencyNumberModel(number: "9545865596")
  ];

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client.get(Uri.parse(APIRoute.listEmergencyNumbers), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async =>
          http.Response(fixtureReader(filename: 'raw-emergency-number.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(Uri.parse(APIRoute.listEmergencyNumbers), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }


  //? Actual tests go here
  group('DATA SOURCE : GetEmergencyNumber{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.fetchEmergencyNumbers();
      //assert
      verify(
        client.get(Uri.parse(APIRoute.listEmergencyNumbers), headers: {
          'content-type': 'application/json',
        }),
      );
    });
    test('should return List<EmergencyNumberModel> when call statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.fetchEmergencyNumbers();
      //assert
      expect(result, tEmergencyNumber);
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.fetchEmergencyNumbers();
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}