import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/get-recorder-stats-repository-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/get-recorder-stats-local-data-source.dart';

import 'get-recorder-stats-repository-impl_test.mocks.dart';

@GenerateMocks([GetRecorderStatsLocalDataSource, NetworkInfo])
void main() {
  late MockGetRecorderStatsLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;
  late GetRecorderStatsRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockGetRecorderStatsLocalDataSource();

    networkInfo = MockNetworkInfo();
    repositoryImpl =
        GetRecorderStatsRepositoryImpl(localDataSource: localDataSource);
  });
  const Stream<RecordingDisposition>? tRecordingDisposition = null;
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getRecorderStats', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : getRecorderStats', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getDetails();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test('should get recorder stats from the repository', () async {
      //arrange
      when(localDataSource.getDetails())
          .thenAnswer((_) async => tRecordingDisposition);
      //act
      final result = await repositoryImpl.getDetails();
      //assert
      verify(localDataSource.getDetails());
      expect(result, const Right(tRecordingDisposition));
    });
    test('should return VoiceNoteFailure when the call to localService fails',
        () async {
      //arrange
      when(localDataSource.getDetails())
          .thenThrow(VoiceNoteExceptionOperationException());
      //act
      final result = await repositoryImpl.getDetails();
      //assert
      expect(result, Left(VoiceNoteFailure()));
    });
  });
  // runTestsOffline(() {
  //   test('should return DeviceOfflineFailure', () async {
  //     //act
  //     final result = await localDataSource.getDetails();
  //     //assert
  //     expect(result, Left(DeviceOfflineFailure()));
  //   });
  // });
}
