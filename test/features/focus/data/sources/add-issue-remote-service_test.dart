// Dart imports:

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
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
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/focus-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'add-issue-remote-service_test.mocks.dart';

@GenerateMocks([
  ApiClient,
])
Future<void> main() async {
  late FocusRemoteDataSourceImpl remoteServiceImpl;
  late BaseUrlController urlController;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    urlController = Get.put(BaseUrlController());
    remoteServiceImpl = FocusRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });
  //Helper Variables
  final IssueModel tIssueModel = IssueModel(
    issueId: 1,
    focusName: "SLEEP",
    displayName: "Sleep",
    messageOnSelection:
        " I want to sleep better. More, restful, deeper sleep for my mind and my body",
    issueIcon: ImageModel.fromDomain(
      ImageEntity(
          type: '',
          url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
    ),
  );

  void setupHttpSuccessClient200({required String testFileName}) {
    when(client!.post(uri: APIRoute.addFocus, body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.post(uri: APIRoute.addFocus, body: anyNamed('body')))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : AddIssue{Remote}', () {
    test('should perform a POST request on the specfied URL', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'add-issue-success.json');
      //act
      //assert
      verifyNever(
        client!.post(uri: APIRoute.addFocus, body: anyNamed('body')),
      );
    });
    test('should return AddIssueSuccess if statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'add-issue-success.json');
      //act
      final result = await remoteServiceImpl.addIssue(issue: tIssueModel);
      //assert
      expect(result, AddIssueSuccess());
    });
    test('should throw ServerException if statusCode is not 404', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final Future<AddIssueSuccess> Function({Issue issue}) call =
          remoteServiceImpl.addIssue;
      //assert
      expect(
        () => call(issue: tIssueModel),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
