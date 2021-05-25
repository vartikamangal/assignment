import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import'package:tatsam_app_experimental/features/focus/data/sources/remove-issue-remote-service.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/focus/data/repositories/remove-issue-service-impl.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue-removed-success.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';



class MockRemoveIssueRemoteService extends Mock
    implements RemoveIssueRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  MockNetworkInfo networkInfo;
  MockRemoveIssueRemoteService remoteService;
  RemoveIssueServiceImpl serviceImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockRemoveIssueRemoteService();
    serviceImpl = RemoveIssueServiceImpl(
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
    group('DEVICE ONLINE : RemoveIssue', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }


  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : RemoveIssue', () {
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
      await serviceImpl.removeIssue(
        issue: tissue
      );
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return SetMoodSuccess if call to remote data source is successfull',
            () async {
          //arrange
          when(remoteService.removeIssue(
            issue: tissue
          )).thenAnswer((_) async => IssueRemovedSuccess());
          //act
          final result = await serviceImpl.removeIssue(
            issue: tissue
          );
          //assert
          verify(remoteService.removeIssue(
            issue: tissue
          ));
          expect(result, Right(IssueRemovedSuccess()));
        });

    test('should return ServerFailure when the call to remoteService fails',
            () async {
          //arrange
          when(remoteService.removeIssue(
            issue: tissue
          )).thenThrow(ServerException());
          //act
          final result = await serviceImpl.removeIssue(
            issue: tissue
          );
          //assert
          expect(result, Left(ServerFailure()));
        });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.removeIssue(
        issue: tissue
      );
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}