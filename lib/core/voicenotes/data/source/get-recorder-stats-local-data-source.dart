import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../error/exceptions.dart';

abstract class GetRecorderStatsLocalDataSource {
  Future<Stream<RecordingDisposition>?> getDetails();
}

class GetRecorderStatsLocalDataSourceImpl
    implements GetRecorderStatsLocalDataSource {
  final FlutterSoundRecorder? recorder;

  GetRecorderStatsLocalDataSourceImpl({
    required this.recorder,
  });
  @override
  Future<Stream<RecordingDisposition>?> getDetails() async {
    try {
      return recorder!.onProgress;
    } catch (e) {
      log(e.toString());
      throw VoiceNoteExceptionOperationException();
    }
  }
}
