import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/add-weekly-category-remote-service.dart';
import 'package:http/http.dart' as http;
//import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async{
  late AddWeeklyCategoryRemoteServiceImpl remoteServiceImpl;
  MockCustomApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = AddWeeklyCategoryRemoteServiceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  void setupHttpSuccessClient200() {
    when(client!.post(uri: '${APIRoute.addWeeklyCategory}${'1'}', body: anyNamed('body')))
        .thenAnswer(
          (_) async => http.Response(fixtureReader(filename: 'testFileName'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.post(uri: '${APIRoute.addWeeklyCategory}${'1'}', body: anyNamed('body')))
        .thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : AddIssue{Remote}', () {

    // test('should throw ServerException if statusCode is not 404', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteServiceImpl.addWeeklyCategory(weekNumber: 1,category: null);
    //   //assert
    //   expect(
    //         () => remoteServiceImpl.addWeeklyCategory(weekNumber: 1,category: null),
    //     throwsA( TypeMatcher<ServerException>()),
    //   );
    // });
  });
}