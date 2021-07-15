import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-id-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/questionnaire-remote-data-source.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'questionnaire-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late QuestionnaireRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = QuestionnaireRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });
  const tQuestionnaireModel =
      QuestionIdModel(id: "04ca410e-5188-4d09-8802-b61d5ac3b357");

  void setupHttpSuccessClient200() {
    when(client!.get(
            uri:
                "${APIRoute.getQuestionnaire}/04ca410e-5188-4d09-8802-b61d5ac3b357"))
        .thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'raw-question-by-id.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: "${APIRoute.getQuestionnaire}/$id")).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  // group('DATA SOURCE : getQuestionnaireById{Remote}', () {
  //   test('should send a GET request to specifed url', () async {
  //     //arrange
  //     setupHttpSuccessClient200();
  //     //act
  //     await remoteDataSourceImpl.getQuestionnaireById(id: "04ca410e-5188-4d09-8802-b61d5ac3b357");
  //     //assert
  //     verify(
  //       client!.get(uri: "${APIRoute.getQuestionnaire}/04ca410e-5188-4d09-8802-b61d5ac3b357"),
  //     );
  //   });
  //
  //   test('should return questionnaire when call statusCode is 200',
  //           () async {
  //         //arrange
  //         setupHttpSuccessClient200();
  //         //act
  //         final result = await remoteDataSourceImpl.getQuestionnaireById(id: "04ca410e-5188-4d09-8802-b61d5ac3b357");
  //         //assert
  //         expect(result, tQuestionnaireModel);
  //       });
  //
  //   test('should throw ServerException when statusCode is not 200', () async {
  //     //arrange
  //     setupHttpFailureClient404();
  //     //act
  //     //assert
  //     expect(() => remoteDataSourceImpl.getQuestionnaireById(id: "04ca410e-5188-4d09-8802-b61d5ac3b357"), throwsA(const TypeMatcher<ServerException>()));
  //   });
  // });
}
