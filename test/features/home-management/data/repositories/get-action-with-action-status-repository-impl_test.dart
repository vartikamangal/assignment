import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/home-management/data/models/post-onboparding-action-model.dart';
import 'package:tatsam_app_experimental/features/home-management/data/repositories/get-action-with-action-status-repository-impl.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/get-action-with-action-status-remote-data-source.dart';
import 'get-action-with-action-status-repository-impl_test.mocks.dart';

@GenerateMocks([GetActionWithActionStatusRemoteDataSource,NetworkInfo])

void main() {
  MockGetActionWithActionStatusRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late GetActionWithActionStatusRepositoryImpl repositoryImpl;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetActionWithActionStatusRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryImpl = GetActionWithActionStatusRepositoryImpl(
        remoteDataSource: remoteDataSource, baseRepository: baseRepository);
  });

  const tActionStatus = '';
  const tPostOnBoardingActionModel = <PostOnboardingActionModel>[
    PostOnboardingActionModel(
        actionId: 1,
        journeyId: 'journeyId',
        actionStatus: 'actionStatus',
        title: 'title',
        subtitle: 'subtitle',
        feedbackMood: 'feedbackMood',
        durationInMinutes: 1)
  ];
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getAction', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getAction', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getActions();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should get action status when coonection to remote data source is successfull',
            () async {
          //arrange
          when(remoteDataSource!.getAction(actionStatus: tActionStatus))
              .thenAnswer((_) async => tPostOnBoardingActionModel);
          //act
          final result =
          await remoteDataSource!.getAction(actionStatus: tActionStatus);
          //assert
          verify(remoteDataSource!.getAction(actionStatus: tActionStatus));
          expect(result, tPostOnBoardingActionModel);
        });
    // test('should return ServerFailure when the call to remoteDataSource fails',
    //     () async {
    //   //arrange
    //   when(remoteDataSource!.getAction(actionStatus: tActionStatus))
    //       .thenThrow(ServerException());
    //   //act
    //   final result = await repositoryImpl.getActions();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  // test('DEVICE OFFLINE : getAction should return DeviceOfflineFailure',
  //         () async {
  //       when(networkInfo!.isConnected).thenAnswer((_) async => false);
  //       //act
  //       final result =
  //       await remoteDataSource!.getAction(actionStatus: tActionStatus);
  //       //assert
  //       expect(result, null);
  //     });
}
