// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-name-remote-service.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  SetSubjectNameRemoteServiceImpl remoteService;

  setUp(() {
    client = MockHttpClient();
    localClient = MockBox();
    remoteService = SetSubjectNameRemoteServiceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  const tSubjectInfo = SubjectInformationModel(
    subjectId: SubjectIdModel(id: "5a58e827-7c69-4bcc-b40d-5e5c12c5e956"),
    userID: "f43d2341-e0c9-4219-bb6d-252ddd3be26b",
    name: null,
    nickName: "Test User",
    deviceIndentifier: "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER",
    // ignore: avoid_redundant_argument_values
    gender: null,
  );

  const tSubjectName = "Test User";
  const tDeviceID = "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER";

  ///! Actual tests begin here

  void setupHttpSuccessClient200() {
    when(client.post(Uri.parse(APIRoute.setSubjectName),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'create-rapport-building-user-response.json'),
          200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.post(Uri.parse(APIRoute.setSubjectName),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : SetSubjectName{Remote}', () {
    test(
        'should perform a POST request on the specified url, with name in body & deviceId in header',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteService.setSubjectName(name: tSubjectName);
      //assert
      verify(
        client.post(
          Uri.parse(APIRoute.setSubjectName),
          headers: {
            "content-type": "application/json",
            "TATSAM_USER": "{'deviceIdentifier': '$tDeviceID'}",
          },
          body: jsonEncode(
            {
              "nickName": tSubjectName,
            },
          ),
        ),
      );
    });
    test('should return SubjectInformation when the statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteService.setSubjectName(name: tSubjectName);
      //assert
      expect(result, tSubjectInfo);
    });
    test('should throw a ServerException when the statusCode is not 200',
        () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteService.setSubjectName;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
