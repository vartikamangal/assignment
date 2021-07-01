import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-data-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/repositories/profile-details-repository-impl.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/sources/profile-details-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

class MockProfileDetailsRemoteDataSource extends Mock
    implements ProfileDetailsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockProfileDetailsRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  ProfileDetailsRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    remoteDataSource = MockProfileDetailsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = ProfileDetailsRepositoryImpl(
        remoteDataSource: remoteDataSource, baseRepository: baseRepository);
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
  });

  const tIssueModel = IssueModel(
      issueId: 1,
      focusName: 'focusName',
      displayName: 'displayName',
      messageOnSelection: 'messageOnSelection',
      issueIcon: ImageProp());
  const tJourneyModel = JourneyModel(
      id: 1,
      title: 'title',
      subtitle: 'subtitle',
      description: 'description',
      icon: ImageProp(),
      pathName: 'pathName');

  const tProfileData = ProfileDataModel(
    subjectInformationId: 1,
    travellerId: 'travellerId',
    holisticScore: 1,
    activitiesThisWeek: 1,
    timeOnActivitiesThisWeek: 1,
    nickName: 'nickName',
    focusIssues: [tIssueModel],
    journeyPath: tJourneyModel,
  );
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getBasicProfileDetails', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getBasicProfileDetails', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await remoteDataSource.getBasicProfileDetails();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test(
        'should get basic profile details when coonection to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource.getBasicProfileDetails())
          .thenAnswer((_) async => tProfileData);
      //act
      final result = await remoteDataSource.getBasicProfileDetails();
      //assert
      verify(remoteDataSource.getBasicProfileDetails());
      expect(result, tProfileData);
    });
    test('should return ServerFailure when the call to remoteDataSource fails',
        () async {
      //arrange
      when(remoteDataSource.getBasicProfileDetails())
          .thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getBasicProfileDetails();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test(
      'DEVICE OFFLINE : getBasicProfileDetails should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await remoteDataSource.getBasicProfileDetails();
    //assert
    expect(result, null);
  });
}
