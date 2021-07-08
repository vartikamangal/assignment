import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/repositories/get-hub-status-repository-impl.dart';
import 'package:tatsam_app_experimental/features/hub/data/sources/get-hub-status-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'get-hub-status-repository-impl_test.mocks.dart';

@GenerateMocks([GetHubStatusRemoteDataSource,NetworkInfo])

void main() {
  MockGetHubStatusRemoteDataSource ? remoteDataSource;
  MockNetworkInfo ? networkInfo;
  late GetHubStatusRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  HubStatusModel hubStatusModel;

  setUp(() {
    remoteDataSource = MockGetHubStatusRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryImpl = GetHubStatusRepositoryImpl(
        remoteDataSource: remoteDataSource, baseRepository: baseRepository);
  });

  const tSubjectIdModel = SubjectIdModel(id: 'id');

  const tSubjectInformationModel = SubjectInformationModel(
      subjectId: tSubjectIdModel,
      userID: 'userID',
      name: 'name',
      nickName: 'nickName',
      deviceIndentifier: 'deviceIndentifier',
      gender: Gender.Male);

  const tIssue = IssueModel(
      issueId: 1,
      issueIcon: ImageProp(),
      displayName: 'displayName',
      focusName: 'focusName',
      messageOnSelection: 'messageOnSelection');

  const tTargetFocus = TargetFocusListModel(id: 1, targetFocusList: [tIssue]);

  const tLifePriorities = LifePrioritiesModel(
      id: 1, areasInOrderOfPriority: ['areasInOrderOfPriority']);

  const tHubStatus = HubStatusModel(
      id: 1,
      subjectInformation: tSubjectInformationModel,
      targetFocus: tTargetFocus,
      lifePriorities: tLifePriorities,
      lifeSatisfactionRatings: {},
      attemptedQuestions: false, journeyPath: null, latestMood: '', journeyStatus: '', journeyStartedAt: null);
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : get-hub-status', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getHubStatus', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getHubStatus();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should get hub status when coonection to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getHubStatus()).thenAnswer((_) async => tHubStatus);
      //act
      final result = await remoteDataSource!.getHubStatus();
      //assert
      verify(remoteDataSource!.getHubStatus());
      expect(result, tHubStatus);
    });
    test('should return ServerFailure when the call to remoteDataSource fails',
        () async {
      //arrange
      when(remoteDataSource!.getHubStatus()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getHubStatus();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  // test('DEVICE OFFLINE : getHubStatus should return DeviceOfflineFailure',
  //     () async {
  //   when(networkInfo!.isConnected).thenAnswer((_) async => false);
  //   //act
  //   final result = await remoteDataSource!.getHubStatus();
  //   //assert
  //   expect(result, null);
  // });
}
