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
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get-life-areas-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  MockApiClient? client;
  late BaseUrlController urlController;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  late WheelOfLifeRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = WheelOfLifeRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final tRatingScale = RatingScaleModel(
    min: 0,
    max: 0,
    ratingValue: 0,
    ratingScaleName: null,
  );

  void setupHttpSuccessClient200() {
    when(
      client!.get(uri: APIRoute.getRatingScale),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'get-rating-scale-raw-response.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client!.get(uri: APIRoute.getRatingScale),
    ).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : GetRatingScale{Remote}', () {
    test('should send a GET request to the specified URL', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getRatingScale();
      //assert
      verify(
        client!.get(
          uri: APIRoute.getRatingScale,
        ),
      );
    });
    test('should return a ratingScale if statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getRatingScale();
      //assert
      expect(result, tRatingScale);
    });
    test('should throw a ServerException when the statusCode is not 200',
        () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getRatingScale;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
