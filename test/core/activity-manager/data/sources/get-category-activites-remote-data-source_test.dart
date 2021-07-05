import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import '../../../../fixtures/fixture-reader.dart';

import 'package:tatsam_app_experimental/core/activity-management/data/sources/get-category-activites-remote-data-source.dart';


class MockCustomApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  GetCategoryActivitiesRemoteDataSourceImpl remoteDataSourceImpl;
  MockCustomApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockCustomApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetCategoryActivitiesRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.get(uri: APIRoute.getAllRecommendationsByCategory)).thenAnswer(
          (_) async => http.Response(
          fixtureReader(filename: 'recommendation-model.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getAllRecommendationsByCategory)).thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }


  //? Actual tests go here
  group('DATA SOURCE : getAllRecommendationsByCategory{Remote}', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteDataSourceImpl.getActivities();
    //   print("hello");
    //   //assert
    //   verify(
    //     client.get(uri: APIRoute.getAllRecommendationsByCategory),
    //   );
    // });
    //
  });
}