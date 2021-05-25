import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

abstract class StartRecordingVoiceNoteService {
  Future<Either<Failure, Success>> startRecodring({
    @required String filePath,
    @required Codec codec,
  });
}
