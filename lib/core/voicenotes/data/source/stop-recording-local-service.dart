import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';

abstract class StopRecordingLocalService {
  Future<RecordingStopped> stopRecording();
  Future<Unit> cancelRecording({
    @required String partialRecordingFileToDelete,
  });
}

class StopRecordingLocalServiceImpl implements StopRecordingLocalService {
  final FlutterSoundRecorder recorder;

  StopRecordingLocalServiceImpl({
    @required this.recorder,
  });
  @override
  Future<RecordingStopped> stopRecording() async {
    try {
      if (recorder.isStopped) {
        log("recorder already stopped");
        return const RecordingStopped(status: 'already stopped');
      } else {
        await recorder.stopRecorder();
        //TODO now find a method for also removing this data from the cached filesystem
        return const RecordingStopped(
          status: 'recorder stopped',
        );
      }
    } catch (e) {
      log(e.toString());
      throw VoiceNoteExceptionOperationException();
    }
  }

  @override
  Future<Unit> cancelRecording({
    String partialRecordingFileToDelete,
  }) async {
    try {
      if (recorder.isStopped) {
        log("recorder already stopped");
        return unit;
      } else {
        await recorder.stopRecorder();
        await recorder.deleteRecord(
          fileName: partialRecordingFileToDelete,
        );
        log("deleted $partialRecordingFileToDelete & cancelled recording");
        return unit;
      }
    } catch (e) {
      log(e.toString());
      throw VoiceNoteExceptionOperationException();
    }
  }
}
