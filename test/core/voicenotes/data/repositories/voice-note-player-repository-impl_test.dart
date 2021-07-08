import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/voice-note-player-local-service.dart';

import 'voice-note-player-repository-impl_test.mocks.dart';

@GenerateMocks([FlutterSoundPlayer, NetworkInfo])
void main() {
  late MockFlutterSoundPlayer player;
  late MockNetworkInfo networkInfo;
  late VoiceNotePlayerLocalServiceImpl serviceImpl;
  late FileUtilsImpl fileUtils;
  Box? box;

  setUp(() {
    player = MockFlutterSoundPlayer();
    networkInfo = MockNetworkInfo();
    fileUtils = FileUtilsImpl(box: box);
    serviceImpl =
        VoiceNotePlayerLocalServiceImpl(player: player, fileUtils: fileUtils);
  });

  const tUnit = unit;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : VoiceNotePlayer', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : VoiceNotePlayer', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await serviceImpl.startRecodring();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test('should stop player', () async {
      //arrange
      when(player.stopPlayer()).thenAnswer((_) async => tUnit);
      //act
      final result = await serviceImpl.stop();
      //assert
      verify(player.stopPlayer());
      expect(result, tUnit);
    });
    // test('should return VoiceNoteFailure when the call to localService fails',
    //     () async {
    //   //arrange
    //   when(player.stopPlayer()).thenThrow(PlayBackException());
    //   //act
    //   final result = await serviceImpl.stop();
    //   //assert
    //   expect(result, PlaybackFailure());
    // });
  });
  // runTestsOffline(() {
  //   test('should return DeviceOfflineFailure', () async {
  //     //act
  //     final result = await serviceImpl.stop();
  //     //assert
  //     expect(result, Left(DeviceOfflineFailure()));
  //   });
  // });
}
