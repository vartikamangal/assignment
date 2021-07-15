// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/repository/wheel-of-life-repository-impl.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';
import 'get-rating-scale-repository-impl_test.mocks.dart';

@GenerateMocks([WheelOfLifeRemoteDataSource, NetworkInfo])
void main() {
  late MockWheelOfLifeRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late WheelOfLifeRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockWheelOfLifeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = WheelOfLifeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });

  final tRatingScale = RatingScaleModel(
    min: 0,
    max: 0,
    ratingValue: 0,
    ratingScaleName: null,
  );

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : GetRatingScaleRepositoryImpl', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : GetRatingScaleRepositoryImpl', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteDataSource!.getRatingScale())
          .thenAnswer((_) async => tRatingScale);
      //act
      await repositoryImpl.getRatingScale();
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return RatingScaleModel if the call to remote resource is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getRatingScale())
          .thenAnswer((_) async => tRatingScale);
      //act
      final result = await repositoryImpl.getRatingScale();
      //assert
      verify(remoteDataSource!.getRatingScale());
      expect(result, Right(tRatingScale));
    });
    test('should return ServerFailure when call to remote resource fails',
        () async {
      //arrange
      when(remoteDataSource!.getRatingScale()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getRatingScale();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });

  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await repositoryImpl.getRatingScale();
      //assert
      verifyZeroInteractions(remoteDataSource);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
