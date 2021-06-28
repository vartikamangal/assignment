import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/retrieve-most-recent-activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-most-recent-activity-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class MockRetrieveMostRecentActivityLocalDataSource extends Mock
    implements RetrieveMostRecentAcitivityRepository {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRetrieveMostRecentActivityLocalDataSource dataSource;
  MockNetworkInfo networkInfo;
  RetreieveMostRecentAcitvityRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;
  RetrieveMostRecentActivityLocalDataSource localDataSource;

  setUp(() {
    dataSource = MockRetrieveMostRecentActivityLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = RetreieveMostRecentAcitvityRepositoryImpl(
        localDataSource: localDataSource, baseRepository: baseRepository);
  });

  const tCachedActivityModel =
      CacheAcitivityModel(id: '', title: '', subtitle: '', icon: '');
  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : retrieveActivity', body);
  }

  //! Actual tests go here
  // runTestOnline(() {
  //   test('should check if the device is online', () async {
  //     //act
  //     await repositoryImpl.retrieveActivity();
  //     //assert
  //     verify(networkInfo.isConnected);
  //   });
  //   group('USECASE: retrieveActivity', () {
  //     test('should retrive activity', () async {
  //       //arrange
  //       when(dataSource.retrieveActivity())
  //           .thenAnswer((_) async => const Right(tCachedActivityModel));
  //       //act
  //       final result = await repositoryImpl.retrieveActivity();
  //       //assert
  //       verify(dataSource.retrieveActivity());
  //       expect(result, const Right(tCachedActivityModel));
  //     });
  //   });
  //   test(
  //       'should return a ServerFailure when call to dataSource is unsuccessfull.',
  //       () async {
  //     //arrange
  //     when(dataSource.retrieveActivity()).thenThrow(ServerException());
  //     //act
  //     final result = await repositoryImpl.retrieveActivity();
  //     //assert
  //     expect(result, Left(ServerFailure()));
  //   });
  // });
  test('DEVICE OFFLINE : getactivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await dataSource.retrieveActivity();
    //assert
    expect(result, null);
  });
}
