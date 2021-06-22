// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-name-remote-service.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  SetSubjectNameRemoteServiceImpl remoteService;
  MockCustomApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteService = SetSubjectNameRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });
  const tSubjectName = "Bhavna";
  const tDeviceID = "Here_is_a_random_identifier";

  const tSubjectInfo = SubjectInformationModel(
    subjectId: SubjectIdModel(id: "b0d388a5-78e5-4520-a137-41336265c978"),
    userID: "ed598e21-dcf3-4f3a-bc0d-9079f372d603",
    name: null,
    nickName: tSubjectName,
    deviceIndentifier: tDeviceID,
    // ignore: avoid_redundant_argument_values
    gender: null,
  );

  ///! Actual tests begin here

  void setupHttpSuccessClient200() {
    when(client.post(
      uri: APIRoute.setSubjectName,
      body: anyNamed('body'),
    )).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'create-rapport-building-user-response.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(client.post(
      uri: APIRoute.setSubjectName,
      body: anyNamed('body'),
    )).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
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
            uri: APIRoute.setSubjectName,
            body: jsonEncode(
              {
                "nickName": tSubjectName,
              },
            )),
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
