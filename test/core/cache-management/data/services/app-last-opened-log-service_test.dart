import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'app-last-opened-log-service_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox localClient;
  late AppLastOpenedLogLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = AppLastOpenedLogLocalServiceImpl(
      localClient: localClient,
    );
  });

  const tunit = unit;

  group('DATA SOURCE : appLastOpenedLog', () {
    test('should log app start DateTime', () async {
      //arrange
      when(localClient.put(
          PersistenceConst.LAST_OPENED_APP, DateTime.now().toString()))
          .thenAnswer((_) async => tunit);
      //act
      final result = await serviceImpl.logStartDatetime();
      //assert
      verify(localClient.put(
          PersistenceConst.LAST_OPENED_APP, DateTime.now().toString()));
      expect(result, tunit);
    });
    //
    // test('should throw CacheException when cacheActivity is failed', () async {
    //   //arrange
    //   when(localClient.put(
    //           PersistenceConst.LAST_OPENED_APP, DateTime.now().toString()))
    //       .thenThrow(CacheException());
    //   //act
    //   final call = serviceImpl.logStartDatetime;
    //   //assert
    //   expect(() => call, throwsA(const TypeMatcher<CacheException>()));
    // });
  });
}