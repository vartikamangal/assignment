import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/get_journey_path_list_remote_data_source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import '../../../../fixtures/fixture-reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async{
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockHttpClient client;
  MockBox localClient;
  GetJourneyPathListRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    client = MockHttpClient();
    remoteDataSourceImpl = GetJourneyPathListRemoteDataSourceImpl(
      client: client,
      sessionClient: localClient,
    );
  });

  const tJourneyModel=<JourneyModel>[
    JourneyModel(
        id: 1,
        title: "Small Wins Path",
        subtitle: "Weekly focus areas. Choose your own experiences.",
        description: "Only one area of focus per week, Daily small wins at your own pace",
        icon: ImageProp(
          urlLarge: '',
          urlMedium: '',
          urlShort: '',
        ),
        pathName: "SMALL_WINS")
  ];

  void setupHttpSuccessClient200() {
    when(client.get(Uri.parse(APIRoute.getJourneyPathList), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async =>
          http.Response(fixtureReader(filename: 'raw-journey.json'), 200),
    );
  }
  void setupHttpFailureClient404() {
    when(client.get(Uri.parse(APIRoute.getJourneyPathList), headers: anyNamed('headers')))
        .thenAnswer(
          (_) async => http.Response('Oops! page not found', 404),
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
      verifyNever(
        client.get(Uri.parse(APIRoute.getJourneyPathList), headers: {
          'content-type': 'application/json',
        }),
      );
    });
    test('should return List<JourneyModel> when call statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      final result = await remoteDataSourceImpl.getJourneys();
      //assert
      expect(result, tJourneyModel);
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
