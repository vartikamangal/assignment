import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'retrieve-user-path-local-data-source_test.mocks.dart';
import 'package:matcher/matcher.dart';

@GenerateMocks([Box])
void main() {
  late MockBox localClient;
  late RetrieveUserPathLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    localDataSourceImpl = RetrieveUserPathLocalDataSourceImpl(
      localClient: localClient,
    );
  });

  const userPath = '';

  group('DATA SOURCE : retrieveUSerPath', () {
    // test('should retrive user path from the service', () async {
    //   //arrange
    //   when(localClient.get(PersistenceConst.USER_SELECTED_PATH))
    //       .thenAnswer((_) async => userPath);
    //   //act
    //   final result = await localDataSourceImpl.retrievePath();
    //   //assert
    //   verify(localClient.get(PersistenceConst.USER_SELECTED_PATH));
    //   expect(result, userPath);
    // });
    test('should throw CacheException when cant retrive user path', () async {
      //arrange
      when(localClient.get(PersistenceConst.USER_SELECTED_PATH))
          .thenThrow(CacheException());
      //act
      final call = localDataSourceImpl.retrievePath;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
}