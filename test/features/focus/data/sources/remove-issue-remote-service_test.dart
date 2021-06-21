// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/remove-issue-remote-service.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue-removed-success.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  RemoveIssueRemoteServiceImpl remoteServiceImpl;
  MockCustomApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = RemoveIssueRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  const tIssueModel = IssueModel(
      issueId: 1,
      focusName: "SLEEP",
      displayName: "Sleep",
      messageOnSelection:
          " I want to sleep better. More, restful, deeper sleep for my mind and my body",
      issueIcon: ImageProp());

  void setupHttpSuccessClient200({@required String testFileName}) {
    when(client.post(uri: APIRoute.deleteFocus, body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.post(uri: APIRoute.deleteFocus, body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : RemoveIssue{Remote}', () {
    test(
      'should perform a POST request on the specfied URL',
      () async {
        //arrange
        setupHttpSuccessClient200(testFileName: 'remove-issue-success.json');
        //act
        await remoteServiceImpl.removeIssue(issue: tIssueModel);
        //assert
        verify(client.post(
          uri: APIRoute.deleteFocus,
          body: jsonEncode(tIssueModel.toJson()),
        ));
      },
    );
    test('should return SetMoodSucess if statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'remove-issue-success.json');
      //act
      final result = await remoteServiceImpl.removeIssue(issue: tIssueModel);
      //assert
      expect(result, IssueRemovedSuccess());
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteServiceImpl.removeIssue;
      //assert
      expect(
        () => call(issue: tIssueModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
