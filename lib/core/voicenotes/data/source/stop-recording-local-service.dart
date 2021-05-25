import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';

abstract class StopRecordingLocalService {
  Future<RecordingStopped> stopRecording();
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
        return const RecordingStopped(
          status: 'recorder stopped',
        );
      }
    } catch (e) {
      log(e.toString());
      throw VoiceNoteExceptionOperationException();
    }
  }
}
