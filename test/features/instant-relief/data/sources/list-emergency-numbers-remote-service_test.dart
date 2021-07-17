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
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'list-emergency-numbers-remote-service_test.mocks.dart';

@GenerateMocks([ApiClient])

Future<void> main() async {
  late InstantReliefRemoteDataSourceImpl remoteDataSourceImpl;
  MockApiClient? client;
  late BaseUrlController urlController;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = InstantReliefRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  const tEmergencyNumber = <EmergencyNumberModel>[
    // EmergencyNumberModel(number: "9545865596")
  ];

  // Helper functions

  void setupHttpSuccessClient200() {
    when(
      client!.get(uri: APIRoute.listEmergencyNumbers),
    ).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'raw-emergency-number.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client!.get(uri: APIRoute.listEmergencyNumbers),
    ).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : GetEmergencyNumber{Remote}', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteDataSourceImpl.fetchEmergencyNumbers();
    //   //assert
    //   verify(
    //     client!.get(uri: APIRoute.listEmergencyNumbers),
    //   );
    // });
    // test('should return List<EmergencyNumberModel> when call statusCode is 200',
    //     () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   final result = await remoteDataSourceImpl.fetchEmergencyNumbers();
    //   //assert
    //   expect(result, tEmergencyNumber);
    // });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteDataSourceImpl.fetchEmergencyNumbers();
    //   //assert
    //   expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    // });
  });
}
