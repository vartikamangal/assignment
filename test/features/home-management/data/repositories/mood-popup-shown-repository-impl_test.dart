import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/home-management/data/repositories/mood-popup-shown-repository-impl.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/mood-popup-shown-local-data-source.dart';
import 'mood-popup-shown-repository-impl_test.mocks.dart';


@GenerateMocks([MoodPopupShownLocalDataSource,NetworkInfo])

void main() {
  late MockMoodPopupShownLocalDataSource? localDataSource;
  MockNetworkInfo? networkInfo;
  late MoodPopupShownRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockMoodPopupShownLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl =
        MoodPopupShownRepositoryImpl(localDataSource: localDataSource);
  });

  const tStatus = false;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getRecommendations()', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getRecommendations()', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getMoodPopupShownStatus();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test(
        'should get recommendation when coonection to remote data source is successfull',
            () async {
          //arrange
          when(localDataSource!.getMoodPopupShownStatus())
              .thenAnswer((_) async => tStatus);
          //act
          final result = await localDataSource!.getMoodPopupShownStatus();
          //assert
          verify(localDataSource!.getMoodPopupShownStatus());
          expect(result, tStatus);
        });
    test('should return ServerFailure when the call to remoteDataSource fails',
            () async {
          //arrange
          when(localDataSource!.getMoodPopupShownStatus())
              .thenThrow(CacheException());
          //act
          final result = await repositoryImpl.getMoodPopupShownStatus();
          //assert
          expect(result, Left(CacheFailure()));
        });
  });
  // test('DEVICE OFFLINE : GetJourneyPaths should return DeviceOfflineFailure',
  //         () async {
  //       when(networkInfo!.isConnected).thenAnswer((_) async => false);
  //       //act
  //       final result = await repositoryImpl.getMoodPopupShownStatus();
  //       //assert
  //       expect(result, Left(DeviceOfflineFailure()));
  //     });
}
