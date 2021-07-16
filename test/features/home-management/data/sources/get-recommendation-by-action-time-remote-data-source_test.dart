import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-recommendation-by-action-time-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late MockApiClient client;
  late BaseUrlController urlController;
  late GetRecommendationsByActionTimeRemoteDataSourceImpl remoteServiceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    urlController = Get.put(BaseUrlController());
    remoteServiceImpl = GetRecommendationsByActionTimeRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  final tAcivities = <ActivityModel>[
    ActivityModel.fromDomain(Activity(
        id: "12",
        title: "title",
        subtitle: "subtitle",
        iconVO: ImageEntity(
            type: '',
            url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
        durationInMinutes: 15,
        messageOnReceivingFeedback: "",
        messageOnCompletion: "awesome",
        recommendationStatus: "",
        frequencyMetric: "",
        frequency: 1,
        actionTime: "12",
        criticality: "complicated",
        categoryVO: RecommendationCategory(
          //   id: 2,
          categoryName: "MENTAL",
          displayTitle: "Mental",
          displaySubtitle: "Focus on your mind",
          categoryDetailedDescription: "This is mental category",
          categoryShortDescription: "Focus on your mind",
          iconVO: ImageEntity(
              type: '',
              url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
          id: null,
        ),
        activitySteps: [],
        tags: []))
  ];
  void setupHttpSuccessClient200() {
    when(client.get(
            uri: "${APIRoute.getRecommendationByActionTime}${""}"))
        .thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'create-traveller-reposone1.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(
            uri: "${APIRoute.getRecommendationByActionTime}${""}"))
        .thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : get recommendation by action time', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteServiceImpl.getRecommendations(actionTime: "actiontime");
      //assert
      verify(
        client.get(
            uri: "${APIRoute.getRecommendationByActionTime}${"actiontime"}"),
      );
    });
    test('should return SuccessCreatedTraveller when call statusCode is 200',
            () async {
          //arrange
          setupHttpSuccessClient200();
          //act
          final result = await remoteServiceImpl.getRecommendations(actionTime: "");
          //assert
          expect(result, tAcivities);
        });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteServiceImpl.getRecommendations(actionTime: "");
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
