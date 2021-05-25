import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/get-issues-remote-data-source.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async{
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  GetIssueRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    client = MockHttpClient();
    remoteDataSourceImpl = GetIssueRemoteDataSourceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  const tIssueModel=<IssueModel>[
    IssueModel(issueId: 1,
        focusName: "SLEEP",
        displayName: "Sleep",
        messageOnSelection: " I want to sleep better. More, restful, deeper sleep for my mind and my body",
        issueIcon: ImageProp(
          urlLarge: null,
          urlMedium: null,
          urlShort: null,
        ),),
    IssueModel(issueId: 2,
        focusName: "WORK_FROM_HOME",
        displayName: "Work form home",
        messageOnSelection: "I want to manage my life better as I work from home",
        issueIcon: ImageProp(
          urlLarge: null,
          urlMedium: null,
          urlShort: null,
        ),),
    IssueModel(
        issueId: 3,
        focusName: "REDUCE_STRESS",
        displayName: "Reduce stress",
        messageOnSelection: "I want to reduce stress",
        issueIcon: ImageProp(
          urlLarge: null,
          urlMedium: null,
          urlShort: null,
        ),)
  ];

  void setupHttpSuccessClient200() {
    when(client.get(Uri.parse(APIRoute.getAllIssues), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async =>
          http.Response(fixtureReader(filename: 'raw-issues.json'), 200),
    );
  }
  void setupHttpFailureClient404() {
    when(client.get(Uri.parse(APIRoute.getAllIssues), headers: anyNamed('headers')))
        .thenAnswer(
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
      verifyNever(
        client.get(Uri.parse(APIRoute.getAllIssues), headers: {
          'content-type': 'application/json',
        }),
      );
    });

    test('should return List<IssueModel> when call statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getIssues();
      //assert
      expect(result, tIssueModel);
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