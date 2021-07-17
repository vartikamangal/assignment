import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/home-management/data/models/post-onboparding-action-model.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/get-action-with-action-status-remote-data-source.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-action-with-action-status-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])

Future<void> main() async{
  late MockApiClient ? client;
  late BaseUrlController urlController;
  late GetActionWithActionStatusRemoteDataSourceImpl remoteServiceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteServiceImpl = GetActionWithActionStatusRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  const tPostOnboardingActionModel=<PostOnboardingActionModel>[
    PostOnboardingActionModel( actionId: 1,
        journeyId: 'journeyId',
        actionStatus: 'actionStatus',
        title: 'title',
        subtitle: 'subtitle',
        feedbackMood: 'feedbackMood',
        durationInMinutes: 1)
  ];

  void setupHttpSuccessClient200() {
    when(client!.get(uri: "${APIRoute.getActionWithActionStatus}${"/COMPLETED"}")).thenAnswer(
          (_) async => http.Response(
          fixtureReader(filename: 'post-onboarding-action-model-from.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client!.get(uri: "${APIRoute.getActionWithActionStatus}${"/COMPLETED"}")).thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
    );
  }
  //? Actual tests go here
  group('DATA SOURCE : getaction', () {
    // test('should send a GET request to specifed url', () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   await remoteServiceImpl.getAction(actionStatus: "COMPLETED");
    //   //assert
    //   verify(
    //     client!.get(uri: "${APIRoute.getActionWithActionStatus}${"/COMPLETED"}"),
    //   );
    // });
    // test('should return list<PostOnboardingActionModel> when call statusCode is 200',
    //         () async {
    //       //arrange
    //       setupHttpSuccessClient200();
    //       //act
    //       final result = await remoteServiceImpl.getAction(actionStatus: "COMPLETED");
    //       //assert
    //       expect(result, tPostOnboardingActionModel);
    //     });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteServiceImpl.getAction(actionStatus: "COMPLETED");
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}