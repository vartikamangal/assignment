// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/repositories/path-operations-repository-impl.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/path-operations-remote-data-source.dart';
import 'get_journey_path_list_remote_data_source_test.mocks.dart';

@GenerateMocks([PathOperationsRemoteDataSource,NetworkInfo])

void main() {
  late MockPathOperationsRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late PathOperationsRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockPathOperationsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = PathOperationsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });

  const tJourneyModel = <JourneyModel>[
    JourneyModel(
        id: 1,
        title: "Small Wins Path",
        subtitle: "Weekly focus areas. Choose your own experiences.",
        description:
            "Only one area of focus per week, Daily small wins at your own pace",
        icon:"",
        pathName: "SMALL_WINS")
  ];

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetAllIssues', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getJourneyPaths();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return a List<IssueModel> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getJourneys())
          .thenAnswer((_) async => tJourneyModel);
      //act
      final result = await repositoryImpl.getJourneyPaths();
      //assert
      verify(remoteDataSource!.getJourneys());
      expect(result, const Right(tJourneyModel));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getJourneys()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getJourneyPaths();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : GetJourneyPaths should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getJourneyPaths();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
