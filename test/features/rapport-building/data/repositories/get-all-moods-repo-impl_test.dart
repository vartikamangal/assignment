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
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/rapport-building-repository-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';
import 'get-all-moods-repo-impl_test.mocks.dart';

@GenerateMocks([RapportBuildingRemoteDataSource,NetworkInfo])

void main() {
  late MockRapportBuildingRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late RapportBuildingRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  //? Helper data vars
  const tMoods = <MoodModel>[
    MoodModel(
      id: 1,
      moodName: "VERY_BAD",
      moodDescription: "Very sad",
      icon: null,
    ),
    MoodModel(
      id: 2,
      moodName: "BAD",
      moodDescription: "Sad",
      icon: null,
    ),
    MoodModel(
      id: 3,
      moodName: "NEUTRAL",
      moodDescription: "Neutral",
      icon: null,
    ),
    MoodModel(
      id: 4,
      moodName: "GOOD",
      moodDescription: "Happy",
      icon: null,
    ),
    MoodModel(
      id: 5,
      moodName: "VERY_GOOD",
      moodDescription: "Very Happy",
      icon: null,
    ),
  ];

  //? Helper Functions

  setUp(
    () {
      remoteDataSource = MockRapportBuildingRemoteDataSource();
      networkInfo = MockNetworkInfo();
      callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
      handleException = HandleException();
      baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException,
      );
      repositoryImpl = RapportBuildingRepositoryImpl(
        baseRepository: baseRepository,
        remoteDataSource: remoteDataSource,
      );
    },
  );

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetAllMoods', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getAllMoods();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return a List<MoodModel> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getMoods()).thenAnswer((_) async => tMoods);
      //act
      final result = await repositoryImpl.getAllMoods();
      //assert
      verify(remoteDataSource!.getMoods());
      expect(result, const Right(tMoods));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getMoods()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getAllMoods();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });

  //! For offline tests
  test('DEVICE OFFLINE : GetAllMoods should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getAllMoods();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
