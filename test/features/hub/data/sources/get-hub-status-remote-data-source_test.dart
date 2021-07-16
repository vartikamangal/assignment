import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/sources/get-hub-status-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'get-hub-status-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
Future<void> main() async {
  late MockApiClient client;
  late BaseUrlController urlController;
  late GetHubStatusRemoteDataSourceImpl remoteDataSourceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    urlController = Get.put(BaseUrlController());
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = GetHubStatusRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  const tSubjectIdModel = SubjectIdModel(id: 'id');

  const tSubjectInformationModel = SubjectInformationModel(
      subjectId: tSubjectIdModel,
      userID: null,
      name: 'name',
      nickName: 'nickName',
      deviceIndentifier: null,
      gender: null);

  final tIssue = IssueModel(
      issueId: null,
      issueIcon: null,
      displayName: 'displayName',
      focusName: 'focusName',
      messageOnSelection: 'messageOnSelection');

  final tTargetFocus = TargetFocusListModel(id: 1, targetFocusList: [tIssue]);

  const tLifePriorities = LifePrioritiesModel(
      id: 1, areasInOrderOfPriority: ['areasInOrderOfPriority']);

  final tHubStatus = HubStatusModel(
      id: 1,
      subjectInformation: tSubjectInformationModel,
      targetFocus: tTargetFocus,
      lifePriorities: null,
      lifeSatisfactionRatings: {},
      attemptedQuestions: false,
      journeyPath: null,
      journeyStartedAt: null,
      journeyStatus: 'Not completed',
      latestMood: null);
  void setupHttpSuccessClient200() {
    when(client.get(uri: APIRoute.getHubUserStatus)).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'raw-hub-status-model-response.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(client.get(uri: APIRoute.getHubUserStatus)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : getHubStatus', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getHubStatus();
      //assert
      verify(
        client.get(uri: APIRoute.getHubUserStatus),
      );
    });
    // test('should return gub status model when call statusCode is 200',
    //     () async {
    //   //arrange
    //   setupHttpSuccessClient200();
    //   //act
    //   final result = await remoteDataSourceImpl.getHubStatus();
    //   //assert
    //   expect(result, tHubStatus);
    // });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   setupHttpFailureClient404();
    //   //act
    //   final call = remoteDataSourceImpl.getHubStatus;
    //   //assert
    //   expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    // });
  });
}
