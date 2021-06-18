import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/utils/snackbars/snackbars.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/cancel-recording.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-recorder-details.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/start-recording-voice-note.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-recording.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

class VoiceNoteController extends GetxController {
  final StartRecordingVoiceNote startRecordingVoiceNote;
  final FlutterSoundRecorder soundRecorder;
  final GetRecorderDetails getRecorderDetails;
  final StopRecording stopRecording;
  final CancelRecording cancelRecording;
  final FileUtils fileUtils;

  // Usecases
  VoiceNoteController({
    @required this.startRecordingVoiceNote,
    @required this.soundRecorder,
    @required this.stopRecording,
    @required this.fileUtils,
    @required this.getRecorderDetails,
    @required this.cancelRecording,
  });

  // Usecase assistors
  Future<void> getFilePathToRecord() async {
    final pathToRecordOrFailure = await fileUtils.getNewFileNameName();
    pathToRecordOrFailure.fold(
      (failure) => ShowSnackbar.rawSnackBar(
        title: failure.toString(),
        message: 'Unable to fetch filePath',
      ),
      (filePath) async {
        currentVoiceNotePath.value = filePath;
      },
    );
  }

  Future<void> recordVoiceNote() async {
    await getFilePathToRecord().then((value) async {
      final startedRecordingVoiceNoteOrFailure = await startRecordingVoiceNote(
        StartRecordingVoiceNoteParams(
          filePath: currentVoiceNotePath.value,
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
          fetchRecorderStats();
          log(status.message);
        },
      );
    });
  }

  Future<void> fetchRecorderStats() async {
    isWaiting.value = true;
    final failureOrResult = await getRecorderDetails(
      NoParams(),
    );
    isWaiting.value = false;
    failureOrResult.fold(
      (f) {
        ShowSnackbar.rawSnackBar(
          title: f.toString(),
          message: 'Unable to start recording',
        );
      },
      (r) {
        r.listen((event) {
          elapsedDuration.value = event.duration;
        });
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

  Future<void> cancelOngoingRecording() async {
    final failureOrResult = await cancelRecording(
      CancelRecordingParams(
        incompleteRecordedFileToDelete: currentVoiceNotePath.value,
      ),
    );
    failureOrResult.fold(
      (f) {
        log('error in cancelling recording');
        cleanVoiceFilePath();
        isRecording.value = soundRecorder.isRecording;
      },
      (r) {
        cleanVoiceFilePath();
        isRecording.value = soundRecorder.isRecording;
      },
    );
  }

  void cleanVoiceFilePath() {
    currentVoiceNotePath.value = null;
  }

  // UI managers
  RxBool isRecording = RxBool(false);
  RxBool isWaiting = RxBool(false);
  RxString currentVoiceNotePath = RxString('');
  Rx<Duration> elapsedDuration = Rx<Duration>();

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
