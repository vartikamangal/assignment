import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-category-activites-remote-data-source_test.mocks.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late GetCategoryActivitiesRemoteDataSourceImpl remoteDataSourceImpl;
  late MockApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetCategoryActivitiesRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client.get(uri: APIRoute.getAllRecommendationsByCategory)).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'recommendation-model.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(uri: APIRoute.getAllRecommendationsByCategory)).thenAnswer(
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
  });
}
