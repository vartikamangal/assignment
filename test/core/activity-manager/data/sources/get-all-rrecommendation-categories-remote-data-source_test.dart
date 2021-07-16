import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';

import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'get-all-rrecommendation-categories-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late GetAllRecommendationCategoriesRemoteDataSourceImpl remoteDataSourceImpl;
  BaseUrlController urlController;
  late MockApiClient client;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetAllRecommendationCategoriesRemoteDataSourceImpl(
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final tRecommendationCategoryModel = <RecommendationCategoryModel>[
    RecommendationCategoryModel.fromDomain(RecommendationCategory(
      id: 2494,
      categoryName: "MENTAL",
      displayTitle: "Mental",
      displaySubtitle: "Focus on your mind",
      categoryDetailedDescription: "This is mental category",
      categoryShortDescription: "Focus on your mind",
      iconVO: ImageEntity(
          type: 'png',
          url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
    ))
  ];

  void setupHttpSuccessClient200() {
    when(client.get(uri: APIRoute.getAllRecommendationCategories)).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'recommendation-category-model.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(uri: APIRoute.getAllRecommendationCategories)).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : getAllCategories', () {
    test(
        'should send a GET request to the specified URL for getting required data',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getAllCategories();
      //assert
      verify(client.get(uri: APIRoute.getAllRecommendationCategories));
    });
    test('should return the Feedback model if the statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getAllCategories();
      //assert
      expect(result, tRecommendationCategoryModel);
    });
    test('should throw a ServerException if statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getAllCategories();
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
