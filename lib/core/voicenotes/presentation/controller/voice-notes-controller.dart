import 'dart:developer';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

import '../../../../dependency_manager/core_dependency_managers.dart';
import '../../../error/display-error-info.dart';
import '../../../file-manager/file-manager.dart';
import '../../../usecase/usecase.dart';
import '../../data/model/player-stats-model.dart';
import '../../domain/entity/player-stats.dart';
import '../../domain/usecases/cancel-recording.dart';
import '../../domain/usecases/clear-recording-data.dart';
import '../../domain/usecases/get-player-stats.dart';
import '../../domain/usecases/get-recorder-details.dart';
import '../../domain/usecases/pause-voicenote.dart';
import '../../domain/usecases/play-voicenote.dart';
import '../../domain/usecases/start-recording-voice-note.dart';
import '../../domain/usecases/stop-playing-voicenote.dart';
import '../../domain/usecases/stop-recording.dart';

/// IDLE --> Show TextFormField
/// READY --> Show Recorder
/// Recorded --> Show PlayerUI
enum VoiceNotePlayerUIState { IDLE, RECORDING, RECORDED }

class VoiceNoteController extends GetxController {
  final StartRecordingVoiceNote startRecordingVoiceNote;
  final FlutterSoundRecorder soundRecorder;
  final GetRecorderDetails getRecorderDetails;
  final StopRecording stopRecording;
  final PlayVoiceNote playVoiceNote;
  final PauseVoiceNote pauseVoiceNote;
  final StopPlayingVoiceNote stopPlayingVoiceNote;
  final CancelRecording cancelRecording;
  final ClearRecordingData clearRecordingData;
  final GetPlayerStats getPlayerStats;
  final FileUtils fileUtils;

  // Usecases
  VoiceNoteController({
    required this.startRecordingVoiceNote,
    required this.soundRecorder,
    required this.stopRecording,
    required this.playVoiceNote,
    required this.pauseVoiceNote,
    required this.stopPlayingVoiceNote,
    required this.clearRecordingData,
    required this.fileUtils,
    required this.getRecorderDetails,
    required this.getPlayerStats,
    required this.cancelRecording,
  });

  static const defaultCodec = Codec.aacMP4;
  static const defaultSampleRate = 44000;
  static const defaultNumChannel = 2;

  // Usecase assistors
  Future<void> getFilePathToRecord() async {
    final pathToRecordOrFailure = await fileUtils.getNewFileNameName();
    pathToRecordOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (filePath) async {
        currentVoiceNotePath.value = filePath;
        log(currentVoiceNotePath.value.toString());
      },
    );
  }

  Future<void> recordVoiceNote() async {
    await getFilePathToRecord().then(
      (value) async {
        final startedRecordingVoiceNoteOrFailure =
            await startRecordingVoiceNote(
          StartRecordingVoiceNoteParams(
              filePath: currentVoiceNotePath.value, codec: defaultCodec),
        );
        startedRecordingVoiceNoteOrFailure.fold(
          (failure) {
            ErrorInfo.show(failure);
          },
          (status) {
            playerState.value = VoiceNotePlayerUIState.RECORDING;
            fetchRecorderStats();
            log(status.message);
          },
        );
      },
    );
  }

  Future<void> fetchRecorderStats() async {
    isWaiting.value = true;
    final failureOrResult = await getRecorderDetails(
      NoParams(),
    );
    isWaiting.value = false;
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        r!.listen((event) {
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
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) {
        playerState.value = VoiceNotePlayerUIState.RECORDED;
        log(status.message);
      },
    );
  }

  /// UI -> Usecase implementation
  Future<void> playVoicenoteUI({required String? audioSource}) async {
    final failureOrResult = await playVoiceNote(
      PlayVoiceNoteParams(
        fileToPlay: audioSource,
        codec: defaultCodec,
        numChannels: defaultNumChannel,
        smapleRate: defaultSampleRate,
        onCompleted: () {
          log('play complete');
        },
      ),
    );
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) async {
        await getPlayerStatsUI();
      },
    );
  }

  Future<void> getPlayerStatsUI() async {
    final failureOrResult = await getPlayerStats(NoParams());
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        currentPlayingFileStats.bindStream(r);
      },
    );
  }

  Future<void> pauseVoicenoteUI() async {
    final failureOrResult = await pauseVoiceNote(NoParams());
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {},
    );
  }

  Future<void> stopVoicenoteUI() async {
    final failureOrResult = await stopPlayingVoiceNote(NoParams());
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        playerState.value = VoiceNotePlayerUIState.IDLE;
      },
    );
  }

  Future<void> clearVoiceNoteUI() async {
    final failureOrResult = await clearRecordingData(
      ClearRecordingDataPrams(
        fileToDelete: currentVoiceNotePath.value,
      ),
    );
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        log('previous recording file deleted');
        cleanVoiceFilePath();
      },
    );
  }

  /// Mixed function of stopPlayer() and cleanVoiceNote()
  /// Stops the running player and then cleans its session files
  Future<void> stopPlayerAndCleanPreviousRecording() async {
    Future.value([
      stopVoicenoteUI(),
      clearVoiceNoteUI(),
    ]);
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
        playerState.value = VoiceNotePlayerUIState.IDLE;
      },
      (r) {
        cleanVoiceFilePath();
        playerState.value = VoiceNotePlayerUIState.IDLE;
        elapsedDuration.value = null;
      },
    );
  }

  bool isPlayableFilePresent() {
    if (currentVoiceNotePath.value != null ||
        currentVoiceNotePath.value != '' &&
            playerState.value == VoiceNotePlayerUIState.RECORDING) {
      return true;
    } else {
      return false;
    }
  }

  void cleanVoiceFilePath() {
    currentVoiceNotePath.value = null;
  }

  // UI managers
  RxBool isWaiting = RxBool(false);
  RxnString currentVoiceNotePath = RxnString('');
  Rxn<Duration> elapsedDuration = Rxn<Duration>();
  Rxn<PlayerStats> currentPlayingFileStats = Rxn<PlayerStatsModel>();
  Rx<VoiceNotePlayerUIState> playerState = VoiceNotePlayerUIState.IDLE.obs;

  /// Helper getters for playback UI
  Stream<Duration?> get currentPlayingFileDuration =>
      currentPlayingFileStats.map(
        (event) => event!.totalLength,
      );
  Stream<Duration?> get currentPlayingFilePosition =>
      currentPlayingFileStats.map(
        (event) => event!.currentPosition,
      );

  void resetPlayerState() {
    playerState.value = VoiceNotePlayerUIState.IDLE;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    sl_core_dependencies<FlutterSoundRecorder>().openAudioSession();
    sl_core_dependencies<FlutterSoundPlayer>().openAudioSession();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    sl_core_dependencies<FlutterSoundRecorder>().closeAudioSession();
    sl_core_dependencies<FlutterSoundPlayer>().closeAudioSession();
  }
}
