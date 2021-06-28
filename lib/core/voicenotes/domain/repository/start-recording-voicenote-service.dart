import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import '../../../error/failures.dart';
import '../../../success/success-interface.dart';

abstract class StartRecordingVoiceNoteService {
  Future<Either<Failure, Success>> startRecodring({
    @required String filePath,
    @required Codec codec,
  });
}
