// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/focus/data/repositories/add-issue-service-impl.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/add-issue-remote-service.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';

class MockAddIssueRemoteService extends Mock
    implements AddIssueRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  MockNetworkInfo networkInfo;
  MockAddIssueRemoteService remoteService;
  AddIssueServiceImpl serviceImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockAddIssueRemoteService();
    serviceImpl = AddIssueServiceImpl(
      remoteService: remoteService,
      networkInfo: networkInfo,
    );
  });
  const tissue=Issue(
      issueId: 1,
      issueIcon: null,
      displayName: "Sleep",
      focusName: "SLEEP",
      messageOnSelection: " I want to sleep better. More, restful, deeper sleep for my mind and my body");

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : add-issue', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : AddIssue', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }
  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.setTarget(
       issue: tissue,
      );
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return addIssue if call to remote data source is successfull',
            () async {
          //arrange
          when(remoteService.addIssue(
           issue: tissue
          )).thenAnswer((_) async => AddIssueSuccess());
          //act
          final result = await serviceImpl.setTarget(
            issue: tissue
          );
          //assert
          verify(remoteService.addIssue(
            issue: tissue
          ));
          expect(result, Right(AddIssueSuccess()));
        });
    test('should return ServerFailure when the call to remoteService fails',
            () async {
          //arrange
          when(remoteService.addIssue(
            issue: tissue
          )).thenThrow(ServerException());
          //act
          final result = await serviceImpl.setTarget(
            issue: tissue
          );
          //assert
          expect(result, Left(ServerFailure()));
        });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.setTarget(
        issue: tissue
      );
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
