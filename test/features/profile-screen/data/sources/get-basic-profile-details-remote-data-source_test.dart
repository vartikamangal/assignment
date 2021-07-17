import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-data-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/sources/profile-details-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'profile-details-remote-data-source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient client;
  late BaseUrlController urlController;
  late ProfileDetailsRemoteDataSourceImpl remoteDataSourceImpl;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    client = MockApiClient();
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    urlController = Get.put(BaseUrlController());
    remoteDataSourceImpl = ProfileDetailsRemoteDataSourceImpl(
        client: client,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  final tProfileDataModel = ProfileDataModel(
      subjectInformationId: 24944,
      travellerId: 'd0ba7d82-ad7f-4a1f-902c-8da2629f2369',
      holisticScore: 1,
      activitiesThisWeek: 1,
      timeOnActivitiesThisWeek: 15,
      nickName: 'dsfsd',
      focusIssues: <IssueModel>[
        IssueModel(
            issueId: 1,
            focusName: 'SLEEP',
            displayName: 'Sleep',
            messageOnSelection:
            'I want to sleep better. More, restful, deeper sleep for my mind and my body',
            issueIcon: ImageModel.fromDomain(ImageEntity(
                type: 'png',
                url: 'https://images.tatsam.in/Logo+512+x+512.png')))
      ],
      journeyPath: JourneyModel(
          id: 1,
          title: 'Small Wins Path',
          subtitle: 'Weekly focus areas. Choose your own experiences.',
          description:
          'Only one area of focus per week, Daily small wins at your own pace',
          icon: ImageModel.fromDomain(ImageEntity(
              type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png')),
          pathName: 'SMALL_WINS'));

  void setupHttpSuccessClient200() {
    when(
      client.post(uri: APIRoute.getBasicDetails),
    ).thenAnswer(
          (_) async => http.Response(
        fixtureReader(filename: 'profile-data-model.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client.post(uri: APIRoute.getBasicDetails),
    ).thenAnswer(
          (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  group('DATA SOURCE : GetLifeAreas{Remote}', () {
    test(
        'should send a GET request to the specified URL for getting required data',
            () async {
          //arrange
          setupHttpSuccessClient200();
          //act
          await remoteDataSourceImpl.getBasicProfileDetails();
          //assert
          verify(client.post(uri: APIRoute.getBasicDetails));
        });
    test('should return the List<LifeAreaModel> if the statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getBasicProfileDetails();
      //assert
      expect(result.toString(), tProfileDataModel.toString());
    });
    test('should throw a ServerException if statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getBasicProfileDetails();
      //assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
