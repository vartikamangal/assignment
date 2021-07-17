// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/path-operations-remote-data-source.dart';

import '../../../../fixtures/fixture-reader.dart';
import 'get_journey_path_list_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClient, Box])
Future<void> main() async {
  MockApiClient? client;
  late BaseUrlController urlController;
  MockBox localClient;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;
  late PathOperationsRemoteDataSourceImpl remoteDataSourceImpl;
  setUp(() {
    client = MockApiClient();
    localClient = MockBox();
    urlController = Get.put(BaseUrlController());
    Get.put(BaseUrlController);
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
    remoteDataSourceImpl = PathOperationsRemoteDataSourceImpl(
      localClient: localClient,
      client: client,
      throwExceptionIfResponseError: throwExceptionIfResponseError,
    );
  });

  final tJourneyModel = <JourneyModel>[
    JourneyModel(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description:
          "Only one area of focus per week, Daily small wins at your own pace",
      icon: ImageModel.fromDomain(
        ImageEntity(
            type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
      pathName: "SMALL_WINS",
    ),
    JourneyModel(
      id: 2,
      title: "Big goals path",
      subtitle: "Daily plans. Crafted for you by Tatsam experts.",
      description:
          "All areas tackled everyday, requires focus & commitment. Holistic way from day 1.",
      icon: ImageModel.fromDomain(
        ImageEntity(
            type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
      pathName: "BIG_GOALS_PATH",
    ),
  ];

  void setupHttpSuccessClient200() {
    when(
      client!.get(uri: APIRoute.getJourneyPathList),
    ).thenAnswer(
      (_) async => http.Response(
        fixtureReader(filename: 'raw-journey.json'),
        200,
      ),
    );
  }

  void setupHttpFailureClient404() {
    when(
      client!.get(uri: APIRoute.getJourneyPathList),
    ).thenAnswer(
      (_) async => http.Response(
        'Oops! page not found',
        404,
      ),
    );
  }

  //? Actual tests go here
  group('DATA SOURCE : GetJourneyPath{Remote}', () {
    test('should send a GET request to specifed url', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      await remoteDataSourceImpl.getJourneys();
      //assert
      verify(
        client!.get(uri: APIRoute.getJourneyPathList),
      );
    });
    test('should return List<JourneyModel> when call statusCode is 200',
        () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getJourneys();
      //assert
      expect(result.toString(), tJourneyModel.toString());
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = remoteDataSourceImpl.getJourneys;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
