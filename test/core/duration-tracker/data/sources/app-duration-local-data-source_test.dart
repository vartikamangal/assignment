import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/duration-tracker/data/models/app-duration-model.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/sources/app-duration-local-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:matcher/matcher.dart';
import '../../../../features/what-path-to-choose/data/sources/get_journey_path_list_remote_data_source_test.dart';
import '../../../../fixtures/fixture-reader.dart';
import 'app-duration-local-data-source_test.mocks.dart';

@GenerateMocks([Box])

void main() {
  late MockBox localClient;
  late AppDurationLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    localDataSourceImpl =
        AppDurationLocalDataSourceImpl(localClient: localClient);
  });

  void setupHttpSuccessClient200() {
    when(localClient.get(PersistenceConst.USER_DURATION_ON_APP)).thenAnswer(
      (_) async => http.Response(
          fixtureReader(filename: 'app-duration-model.json'), 200),
    );
  }

  void setupHttpFailureClient404() {
    when(localClient.get(PersistenceConst.USER_DURATION_ON_APP)).thenAnswer(
      (_) async => http.Response('Oops! page not found', 404),
    );
  }

  group('DATA SOURCE : getLastLogin', () {
    test('should tests', () async {
      //arrange
      setupHttpSuccessClient200();
      when(localClient.get(PersistenceConst.USER_DURATION_ON_APP))
          .thenAnswer((_) async {
        await localDataSourceImpl.getLastLogin();
        //assert
        verify(localClient.get(PersistenceConst.USER_DURATION_ON_APP));
      });
    });
    test('should return Success when call statusCode is 200', () async {
      //arrange
      setupHttpSuccessClient200();
      //act
      when(localClient.get(PersistenceConst.USER_DURATION_ON_APP))
          .thenAnswer((_) async {
        final result = await localDataSourceImpl.getLastLogin();
        //assert
        expect(
            result,
            AppDurationModel(
                lastLogin: DateTime.parse('2021-05-10T13:19:41.543Z'),
                currentWeekday: 1));
      });
    });
    test('should throw CacheException when statusCode is not 200', () async {
      //arrange
      setupHttpFailureClient404();
      //act
      final call = localDataSourceImpl.getLastLogin;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
}
