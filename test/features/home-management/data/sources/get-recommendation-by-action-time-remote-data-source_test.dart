import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-recommendation-by-action-time-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])

Future<void> main() async{
  late MockApiClient client;
  late GetRecommendationsByActionTimeRemoteDataSourceImpl remoteServiceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = GetRecommendationsByActionTimeRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  void setupHttpSuccessClient200() {
    when(client.get(uri: "${APIRoute.getRecommendationByActionTime}${"actionTime"}")).thenAnswer(
          (_) async => http.Response(
          fixtureReader(filename: 'create-traveller-reposone1.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(uri:"${APIRoute.getRecommendationByActionTime}${"actionTime"}")).thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }


  //? Actual tests go here
  group('DATA SOURCE : get recommendation by action time', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteServiceImpl.getRecommendations(actionTime: "actiontime");
    //   //assert
    //   verify(
    //     client.get(uri: "${APIRoute.getRecommendationByActionTime}${"actiontime"}"),
    //   );
    // });
    // test('should return SuccessCreatedTraveller when call statusCode is 200',
    //         () async {
    //       //arrange
    //       setupHttpSuccessClient200();
    //       //act
    //       final result = await remoteServiceImpl.createTraveller();
    //       //assert
    //       expect(result, const SuccessCreatedTraveller());
    //     });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteServiceImpl.createTraveller;
    //   //assert
    //   expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    // });
  });
}