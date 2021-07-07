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

@GenerateMocks([Box,FlutterSecureStorage])

Future<void> main() async{
  late MockBox localClient;
  late FlutterSecureStorage flutterSecureStorage;
  late CacheClearingLocalServiceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    flutterSecureStorage=MockFlutterSecureStorage();
    remoteDataSourceImpl = CacheClearingLocalServiceImpl(
      localClient: localClient, flutterSecureStorage: flutterSecureStorage,
    );
  });

  const tunit=unit;
  // void runTestsOnline(Callback body) {
  //   group('DEVICE ONLINE : add-issue', () {
  //     setUp(() {
  //       when(localClient.get(PersistenceConst.IS_FIRST_RUN)).thenAnswer((_) async => true);
  //     });
  //     body();
  //   });
  // }

  group('DATA services for cache clearing service', () {
    test(
        'If should return unit when logStartDatetime is called',
            () async {
          //act
              when(localClient.get(PersistenceConst.IS_FIRST_RUN)).thenAnswer((_) async
              {
                true;

                final result = await remoteDataSourceImpl.clearDirtyCacheOnFirstRun();
                //assert
                expect(result, CacheException);
              });

        });
  });

}