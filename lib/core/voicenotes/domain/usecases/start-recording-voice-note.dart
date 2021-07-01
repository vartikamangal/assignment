import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../error/failures.dart';

import '../../../success/success-interface.dart';
import '../../../usecase/usecase.dart';
import '../repository/start-recording-voicenote-service.dart';

class StartRecordingVoiceNote
    implements Usecase<Success, StartRecordingVoiceNoteParams> {
  final StartRecordingVoiceNoteService service;

  StartRecordingVoiceNote({
    @required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(
      StartRecordingVoiceNoteParams params) async {
    return service.startRecodring(
      filePath: params.filePath,
      codec: params.codec,
    );
  }
}

class StartRecordingVoiceNoteParams extends Equatable {
  final String filePath;
  final Codec codec;
  const StartRecordingVoiceNoteParams({
    @required this.filePath,
    @required this.codec,
  });
  @override
  List<Object> get props => [filePath, codec];
}
