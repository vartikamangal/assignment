import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:matcher/matcher.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/add-issue-remote-service.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import '../../../../fixtures/fixture-reader.dart';


class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  AddIssueRemoteServiceImpl remoteServiceImpl;
  setUp(() {
    client = MockHttpClient();
    localClient = MockBox();
    remoteServiceImpl = AddIssueRemoteServiceImpl(
      client: client,
      sessionClient: localClient,
    );
  });
  //Helper Variables
  const IssueModel tIssueModel = IssueModel(
        issueId: 1,
        focusName: "SLEEP",
        displayName: "Sleep",
        messageOnSelection: " I want to sleep better. More, restful, deeper sleep for my mind and my body",
        issueIcon:ImageProp(
          urlMedium: null,
          urlLarge: null,
          urlShort: null
        )
    );

  void setupHttpSuccessClient200({@required String testFileName}) {
    when(client.post(Uri.parse(APIRoute.addFocus),
        headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
          (_) async => http.Response(fixtureReader(filename: testFileName), 200),
    );
  }
  void setupHttpFailureClient404() {
    when(client.post(Uri.parse(APIRoute.addFocus),
        headers: anyNamed('headers'), body: anyNamed('body')))
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
      verifyNever(client.post(
        Uri.parse(APIRoute.addFocus),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            "issueId": 1,
            "focusName": "SLEEP",
            "displayName": "Sleep",
            "messageOnSelection": " I want to sleep better. More, restful, deeper sleep for my mind and my body",
            "issueIcon":null
          },
        ),
      ));
    });
    test('should return AddIssueSuccess if response is 1 and statusCode is 200',
            () async {
          //arrange
          setupHttpSuccessClient200(testFileName: 'add-issue-success.json');
          //act
          final result = await remoteServiceImpl.addIssue(
            issue: tIssueModel
          );
          //assert
          expect(result, AddIssueSuccess());
        });
    test('should throw ServerException if response is not 1', () async {
      //arrange
      setupHttpSuccessClient200(testFileName: 'add-issue-failed.json');
      //act
      final call = remoteServiceImpl.addIssue;
      //assert
      expect(
            () => call(
              issue:tIssueModel
        ),
        // ignore: deprecated_member_use
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
    test('should throw ServerException if statusCode is not 404', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = await remoteServiceImpl.addIssue;
      //assert
      expect(
            () => call(
              issue:tIssueModel
        ),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });

}