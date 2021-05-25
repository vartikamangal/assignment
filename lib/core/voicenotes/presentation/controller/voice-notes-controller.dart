import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/utils/snackbars/snackbars.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/start-recording-voice-note.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-recording.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

class VoiceNoteController extends GetxController {
  final StartRecordingVoiceNote startRecordingVoiceNote;
  final FlutterSoundRecorder soundRecorder;
  final StopRecording stopRecording;
  final FileUtils fileUtils;

  // Usecases
  VoiceNoteController({
    @required this.startRecordingVoiceNote,
    @required this.soundRecorder,
    @required this.stopRecording,
    @required this.fileUtils,
  });

  // Usecase assistors
  Future<void> recordVoiceNote() async {
    final pathToRecordOrFailure = await fileUtils.getNewFileNameName();
    pathToRecordOrFailure.fold(
      (failure) => ShowSnackbar.rawSnackBar(
        title: failure.toString(),
        message: 'Unable to fetch filePath',
      ),
      (filePath) async {
        currentVoiceNotePath.value = filePath;
        final startedRecordingVoiceNoteOrFailure =
            await startRecordingVoiceNote(
          StartRecordingVoiceNoteParams(
            filePath: filePath,
            codec: Codec.aacMP4,
          ),
        );
        startedRecordingVoiceNoteOrFailure.fold(
          (failure) => ShowSnackbar.rawSnackBar(
            title: failure.toString(),
            message: 'Unable to start recording',
          ),
          (status) {
            isRecording.value = soundRecorder.isRecording;
            log(status.message);
          },
        );
      },
    );
  }

  Future<void> stopRecordingVoiceNote() async {
    final stoppedRecordingOrFailure = await stopRecording(
      NoParams(),
    );
    stoppedRecordingOrFailure.fold(
      (failure) => ShowSnackbar.rawSnackBar(
        title: failure.toString(),
        message: 'Unable to stop recording',
      ),
      (status) {
        isRecording.value = soundRecorder.isRecording;
        log(status.message);
      },
    );
  }

  // UI managers
  RxBool isRecording = RxBool(false);
  RxString currentVoiceNotePath = RxString('');

  @override
  Future<void> onInit() async {
    super.onInit();
    sl_core_dependencies<FlutterSoundRecorder>().openAudioSession();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    sl_core_dependencies<FlutterSoundRecorder>().closeAudioSession();
  }
}
