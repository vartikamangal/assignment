import 'dart:developer';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../error/exceptions.dart';
import '../../../permission-manager/permission-manager.dart';
import '../../domain/entity/recording-started-status.dart';

abstract class StartRecordingVoiceNoteLocalService {
  Future<RecordingStarted> startRecording({
    required String? filePath,
    required Codec? codec,
  });
}

class StartRecordingVoiceNoteLocalServiceImpl
    implements StartRecordingVoiceNoteLocalService {
  final FlutterSoundRecorder? recorder;
  final PermissionManager? permissionManager;
  final CallbackPeriod = const Duration(milliseconds: 500);

  StartRecordingVoiceNoteLocalServiceImpl({
    required this.recorder,
    required this.permissionManager,
  });
  @override
  Future<RecordingStarted> startRecording({
    String? filePath,
    Codec? codec,
  }) async {
    if (await permissionManager!.requestPermission(
      permission: Permission.microphone,
    )) {
      if (recorder!.isRecording) {
        return const RecordingStarted(
          recordingStatus: 'Already recording',
        );
      } else {
        // If platform is android ask for different permission than that of iOS
        if (Platform.isAndroid) {
          if (await permissionManager!.requestPermission(
            permission: Permission.storage,
          )) {
            return _startRecording(recorder!, filePath, codec!, CallbackPeriod);
          } else {
            throw NotPermittedActionException();
          }
        } else {
          final isiOSPermitted = await permissionManager!.requestPermission(
            permission: Permission.photos,
          );
          if (isiOSPermitted) {
            return _startRecording(recorder!, filePath, codec!, CallbackPeriod);
          } else {
            throw NotPermittedActionException();
          }
        }
      }
    } else {
      throw NotPermittedActionException();
    }
  }

  // For better code re-use
  Future<RecordingStarted> _startRecording(
    FlutterSoundRecorder recorder,
    String? filePath,
    Codec codec,
    Duration callbackPeriod,
  ) async {
    try {
      await recorder.openAudioSession();
      await recorder.setSubscriptionDuration(callbackPeriod);
      await recorder.startRecorder(
        toFile: filePath,
        codec: codec,
      );
      return const RecordingStarted(
        recordingStatus: 'Started Rceording',
      );
    } catch (e) {
      log(e.toString());
      throw VoiceNoteExceptionOperationException();
    }
  }
}
