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

import '../../../../fixtures/fixture-reader.dart';
import 'get-issues-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late FocusRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  late BaseUrlController urlController;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    urlController = Get.put(BaseUrlController());
    remoteDataSourceImpl = FocusRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final tIssueModel = <IssueModel>[
    IssueModel(
      issueId: 1,
      focusName: "SLEEP",
      displayName: "Sleep",
      messageOnSelection:
          " I want to sleep better. More, restful, deeper sleep for my mind and my body",
      issueIcon: ImageModel.fromDomain(
        ImageEntity(
            type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
    ),
    IssueModel(
      issueId: 2,
      focusName: "WORK_FROM_HOME",
      displayName: "Work form home",
      messageOnSelection: "I want to manage my life better as I work from home",
      issueIcon: ImageModel.fromDomain(
        ImageEntity(
            type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
    ),
    IssueModel(
      issueId: 3,
      focusName: "REDUCE_STRESS",
      displayName: "Reduce stress",
      messageOnSelection: "I want to reduce stress",
      issueIcon: ImageModel.fromDomain(
        ImageEntity(
            type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
    )
  ];

  void setupHttpSuccessClient200() {
    when(client!.get(uri: APIRoute.getAllIssues)).thenAnswer(
      (_) async =>
          http.Response(fixtureReader(filename: 'raw-issues.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getAllIssues)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : GetAllIssues{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getIssues();
      //assert
      verify(
        client!.get(uri: APIRoute.getAllIssues),
      );
    });

    test('should return List<IssueModel> when call statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getIssues();
      //assert
      expect(result.toString(), tIssueModel.toString());
    });

    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getIssues;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
