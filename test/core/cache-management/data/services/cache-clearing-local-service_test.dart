import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-clearing-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'cache-clearing-local-service_test.mocks.dart';
import 'package:matcher/matcher.dart';

@GenerateMocks([Box, FlutterSecureStorage])
Future<void> main() async {
  late MockBox localClient;
  late FlutterSecureStorage flutterSecureStorage;
  late CacheClearingLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    flutterSecureStorage = MockFlutterSecureStorage();
    serviceImpl = CacheClearingLocalServiceImpl(
      localClient: localClient,
      flutterSecureStorage: flutterSecureStorage,
    );
  });

  const tUnit = unit;

  group('DATA services for clearDirtyCacheOnFirstRun', () {
    // test('It should return unit when cacheactivity is called', () async {
    //   when(localClient.get(PersistenceConst.IS_FIRST_RUN))
    //       .thenAnswer((_) async => tUnit);
    //   final result = await serviceImpl.clearDirtyCacheOnFirstRun();
    //   //assert
    //   expect(result, tUnit);
    // });

    test('should throw CacheException when clearDirtyCacheOnFirstRun is failed',
            () async {
          //arrange
          when(localClient.get(PersistenceConst.IS_FIRST_RUN))
              .thenThrow(CacheException());
          //act
          final call = serviceImpl.clearDirtyCacheOnFirstRun();
          //assert
          expect(() => call, throwsA(const TypeMatcher<CacheException>()));
        });
  });
}