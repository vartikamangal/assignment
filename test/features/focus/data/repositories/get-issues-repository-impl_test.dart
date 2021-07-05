// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/data/repositories/focus-repository-impl.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/focus-remote-data-source.dart';

class MockGetAllMoodsRemoteDataSource extends Mock
    implements FocusRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockGetAllMoodsRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late FocusRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  const tIssueModel = <IssueModel>[
    IssueModel(
      issueId: 1,
      focusName: "SLEEP",
      displayName: "Sleep",
      messageOnSelection:
          " I want to sleep better. More, restful, deeper sleep for my mind and my body",
      issueIcon: ImageProp(),
    ),
    IssueModel(
      issueId: 2,
      focusName: "WORK_FROM_HOME",
      displayName: "Work form home",
      messageOnSelection: "I want to manage my life better as I work from home",
      issueIcon: ImageProp(),
    ),
    IssueModel(
      issueId: 3,
      focusName: "REDUCE_STRESS",
      displayName: "Reduce stress",
      messageOnSelection: "I want to reduce stress",
      issueIcon: ImageProp(),
    )
  ];

  setUp(() {
    remoteDataSource = MockGetAllMoodsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = FocusRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });
  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetAllIssues', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.getIssues();
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return a List<IssueModel> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getIssues()).thenAnswer((_) async => tIssueModel);
      //act
      final result = await repositoryImpl.getIssues();
      //assert
      verify(remoteDataSource!.getIssues());
      expect(result, const Right(tIssueModel));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getIssues()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getIssues();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : GetAllIssues should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getIssues();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
