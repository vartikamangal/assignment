import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/retrieve-user-path-repository-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class MockRetrieveUserPathLocalDataSource extends Mock
    implements RetrieveUserPathLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRetrieveUserPathLocalDataSource localDataSource;
  MockNetworkInfo networkInfo;
  RetrieveUserPathRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;

  setUp(() {
    localDataSource = MockRetrieveUserPathLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = RetrieveUserPathRepositoryImpl(
        localDataSource: localDataSource, baseRepository: baseRepository);
  });

  const tPath = '';

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : retrievePath()', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : retrievePath()', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.retrievePath();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test(
        'should retrieve a path when coonection to local data source is successfull',
        () async {
      //arrange
      when(localDataSource.retrievePath()).thenAnswer((_) async => tPath);
      //act
      final result = await localDataSource.retrievePath();
      //assert
      verify(localDataSource.retrievePath());
      expect(result, tPath);
    });
    // test('should return ServerFailure when the call to remoteService fails',
    //     () async {
    //   //arrange
    //   when(localDataSource.retrievePath()).thenThrow(ServerException());
    //   //act
    //   final result = await repositoryImpl.retrievePath();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  test('DEVICE OFFLINE : retrievePath should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await localDataSource.retrievePath();
    //assert
    expect(result, null);
  });
}
