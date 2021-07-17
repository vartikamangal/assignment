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
import 'package:tatsam_app_experimental/features/focus/data/repositories/focus-repository-impl.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/focus-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'add-issue-service-impl_test.mocks.dart';

@GenerateMocks([FocusRemoteDataSource, NetworkInfo])
void main() {
  late MockNetworkInfo? networkInfo;
  MockFocusRemoteDataSource? remoteService;
  late FocusRepositoryImpl serviceImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockFocusRemoteDataSource();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    serviceImpl = FocusRepositoryImpl(
      remoteDataSource: remoteService,
      baseRepository: baseRepository,
    );
  });
  const tissue = Issue(
      issueId: 1,
      issueIcon: null,
      displayName: "Sleep",
      focusName: "SLEEP",
      messageOnSelection:
          " I want to sleep better. More, restful, deeper sleep for my mind and my body");

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : add-issue', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : AddIssue', () {
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
      when(remoteService!.addIssue(issue: tissue))
          .thenAnswer((_) async => AddIssueSuccess());
      //act
      await serviceImpl.setTarget(
        issue: tissue,
      );
      //assert
      verify(networkInfo!.isConnected);
    });
    test('should return addIssue if call to remote data source is successfull',
        () async {
      //arrange
      when(remoteService!.addIssue(issue: tissue))
          .thenAnswer((_) async => AddIssueSuccess());
      //act
      final result = await serviceImpl.setTarget(issue: tissue);
      //assert
      verify(remoteService!.addIssue(issue: tissue));
      expect(result, Right(AddIssueSuccess()));
    });
    test('should return ServerFailure when the call to remoteService fails',
        () async {
      //arrange
      when(remoteService!.addIssue(issue: tissue)).thenThrow(ServerException());
      //act
      final result = await serviceImpl.setTarget(issue: tissue);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.setTarget(issue: tissue);
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
