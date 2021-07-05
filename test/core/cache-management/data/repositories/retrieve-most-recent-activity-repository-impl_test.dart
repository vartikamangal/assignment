import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/retrieve-most-recent-activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

import '../../../core_mock_generator_test.mocks.dart';
import 'retrieve-most-recent-activity-repository-impl_test.mocks.dart';

@GenerateMocks([RetrieveMostRecentActivityLocalDataSource])
void main() {
  late MockRetrieveMostRecentActivityLocalDataSource localDataSource;
  late MockNetworkInfo? networkInfo;
  late RetreieveMostRecentAcitvityRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    localDataSource = MockRetrieveMostRecentActivityLocalDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryImpl = RetreieveMostRecentAcitvityRepositoryImpl(
        localDataSource: localDataSource, baseRepository: baseRepository);
  });

  const tCachedActivityModel = CacheAcitivityModel(
      id: 'id', title: 'title', subtitle: 'subtitle', icon: 'icon');
  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : retrieveActivity', body);
  }

  // Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.retrieveActivity();
      //assert
      verify(networkInfo!.isConnected);
    });
    group('USECASE: retrieveActivity', () {
      test('should retrive activity', () async {
        //arrange
        when(localDataSource.retrieveActivity())
            .thenAnswer((_) async => tCachedActivityModel);
        //act
        final result = await repositoryImpl.retrieveActivity();
        //assert
        verify(localDataSource.retrieveActivity());
        expect(result, const Right(tCachedActivityModel));
      });
    });
    test(
        'should return a ServerFailure when call to dataSource is unsuccessfull.',
        () async {
      //arrange
      when(localDataSource.retrieveActivity()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.retrieveActivity();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : getactivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await localDataSource.retrieveActivity();
    //assert
    expect(result, null);
  });
}
