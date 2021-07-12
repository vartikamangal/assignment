import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'update-activty-status-remote-service_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late AcitivityRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = AcitivityRemoteDataSourceImpl(
      apiClient: client!,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  const tStatus = "COMPLETED";
  const tActionId = 19351;

  // Helper functions

  void setupHttpSuccessClient200() {
    when(client!.get(
            uri:
                "${APIRoute.updateActionStatus}/$tActionId/status/${tStatus.toUpperCase()}"))
        .thenAnswer(
      (_) async =>
          http.Response(fixtureReader(filename: 'activity-status.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: APIRoute.getAllRecommendationCategories)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

//  ? Actual tests go here
  group('DATA SOURCE : modifyStatus{Remote}', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteDataSourceImpl.updateActivityStatus(status: tStatus,actionId: tActionId);
    //   //assert
    //   verify(
    //     client!.get(uri:
    //     "${APIRoute.updateActionStatus}/$tActionId/status/${tStatus.toUpperCase()}"),
    //   );
    // });
    // test(
    //     'should return List<RecommendationCategoryModel> when call statusCode is 200',
    //         () async {
    //       //arrange
    //       setupHttpSuccessClient200();
    //       //act
    //       final result = await remoteDataSourceImpl.getAllCategories();
    //       //assert
    //       expect(result, tRecommendationCategoryModel);
    //     });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteDataSourceImpl.updateActivityStatus(status: tStatus,actionId: tActionId);
    //   //assert
    //   expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    // });
  });
}
