// Package imports:
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:tatsam_app_experimental/core/analytics/analytics-setup.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/repository/app-page-status-repository-impl.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/sources/app-page-status-local-data-source.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/repository/app-page-status-repository.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/usecases/get-last-abandoned-page.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/cache-clearing-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/cache-most-recent-acitivty-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-clearing-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-clearing-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-most-recent-acitivity.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/check-if-first-time-user.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/clear-dirty-cache-on-first-run.dart';
import 'package:tatsam_app_experimental/core/cache-manager/presentation/controllers/activity_cache_controller.dart';
import 'package:tatsam_app_experimental/core/cache-manager/presentation/controllers/mood-data-cache-controller.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/get-recorder-stats-repository-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/voice-note-player-repository-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/get-recorder-stats-local-data-source.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/voice-note-player-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/get-recorder-stats-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/cancel-recording.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/clear-recording-data.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-recorder-details.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/pause-voicenote.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/play-voicenote.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-playing-voicenote.dart';

import '../core/cache-manager/data/repositories/log-last-opened-app-service.dart';
import '../core/cache-manager/data/repositories/mood-cache-service-impl.dart';
// Project imports:
import '../core/cache-manager/data/repositories/save-feedback-service-impl.dart';
import '../core/cache-manager/data/services/app-last-opened-log-service.dart';
import '../core/cache-manager/data/services/mood-cache-local-service.dart';
import '../core/cache-manager/data/services/save-feedback-local-service.dart';
import '../core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import '../core/cache-manager/domain/repositories/mood-cache-service.dart';
import '../core/cache-manager/domain/repositories/save-feedback-service.dart';
import '../core/cache-manager/domain/usecases/cache-mood.dart';
import '../core/cache-manager/domain/usecases/get-cached-mood.dart';
import '../core/cache-manager/domain/usecases/log-app-start-time.dart';
import '../core/cache-manager/domain/usecases/retireve-last-logged-app-init.dart';
import '../core/cache-manager/domain/usecases/save-feedback.dart';
import '../core/duration-tracker/data/repositories/app-duration-repository-impl.dart';
import '../core/duration-tracker/data/sources/app-duration-local-data-source.dart';
import '../core/duration-tracker/domain/repository/app-duration-repository.dart';
import '../core/duration-tracker/domain/usecases/get-last-login.dart';
import '../core/duration-tracker/domain/usecases/update-user-duration-on-app.dart';
import '../core/duration-tracker/duration-tracker-controller.dart';
import '../core/file-manager/file-manager.dart';
import '../core/permission-manager/permission-manager.dart';
import '../core/persistence-consts.dart';
import '../core/platform/network_info.dart';
import '../core/voicenotes/data/repository/start-recording-voicenote-service-impl.dart';
import '../core/voicenotes/data/repository/stop-recording-service-impl.dart';
import '../core/voicenotes/data/source/start-recording-voicenote-local-service.dart';
import '../core/voicenotes/data/source/stop-recording-local-service.dart';
import '../core/voicenotes/domain/repository/start-recording-voicenote-service.dart';
import '../core/voicenotes/domain/repository/stop-recording-service.dart';
import '../core/voicenotes/domain/usecases/start-recording-voice-note.dart';
import '../core/voicenotes/domain/usecases/stop-recording.dart';
import '../core/voicenotes/presentation/controller/voice-notes-controller.dart';

//import 'package:flutter_sound/flutter_sound.dart';

final sl_core_dependencies = GetIt.instance;

Future<void> initCoreDependencies() async {
  //  Factories
  Get.lazyPut<VoiceNoteController>(
    () => VoiceNoteController(
      startRecordingVoiceNote: sl_core_dependencies(),
      soundRecorder: sl_core_dependencies(),
      stopRecording: sl_core_dependencies(),
      fileUtils: sl_core_dependencies(),
      getRecorderDetails: sl_core_dependencies(),
      clearRecordingData: sl_core_dependencies(),
      cancelRecording: sl_core_dependencies(),
      playVoiceNote: sl_core_dependencies(),
      getPlayerStats: sl_core_dependencies(),
      pauseVoiceNote: sl_core_dependencies(),
      stopPlayingVoiceNote: sl_core_dependencies(),
    ),
  );
  Get.lazyPut<DurationTrackerController>(
    () => DurationTrackerController(
      getLastLogin: sl_core_dependencies(),
      updateUserDurationOnApp: sl_core_dependencies(),
    ),
  );
  Get.lazyPut<MoodDataCacheController>(
    () => MoodDataCacheController(
      getCachedMood: sl_core_dependencies(),
      cacheMood: sl_core_dependencies(),
    ),
  );
  Get.lazyPut<ActivityCacheController>(
    () => ActivityCacheController(
      cacheMostRecentAcitivity: sl_core_dependencies(),
      persistActivityFeedback: sl_core_dependencies(),
    ),
  );
  Get.lazyPut<BaseUrlController>(
    () => BaseUrlController(),
  );
  // Usecases
  sl_core_dependencies.registerLazySingleton(
    () => StartRecordingVoiceNote(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => StopRecording(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => SaveFeedback(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => CacheMood(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => GetCachedMood(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => GetLastLogin(
      repository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => UpdateUserDurationOnApp(
      repository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => LogAppStartTime(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => RetirieveLastLoggedAppInit(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => GetRecorderDetails(
      repository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => CancelRecording(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => PlayVoiceNote(
      voiceNotesPlayerRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => CheckIfFirstTimeUser(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => PauseVoiceNote(
      voiceNotesPlayerRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => StopPlayingVoiceNote(
      voiceNotesPlayerRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => ClearRecordingData(
      voiceNotesPlayerRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => GetPlayerStats(
      voiceNotesPlayerRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => ClearDirtyCacheOnFirstRun(
      service: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => GetLastAbandonedPage(
      repository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => CacheMostRecentAcitivity(
      service: sl_core_dependencies(),
    ),
  );

  // Respos/Services
  sl_core_dependencies.registerLazySingleton(
    () => BaseRepository(
      callIfNetworkConnected: sl_core_dependencies(),
      handleException: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<StartRecordingVoiceNoteService>(
    () => StartRecordingVoiceNoteServiceImpl(
      localService: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<StopRecordingService>(
    () => StopRecordingServiceImpl(
      localService: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<SaveFeedbackService>(
    () => SaveFeedbackServiceImpl(
      localService: sl_core_dependencies(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<MoodCacheService>(
    () => MoodCacheServiceImpl(
      localService: sl_core_dependencies(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<AppDurationRepository>(
    () => AppDurationRepositoryImpl(
      localDataSource: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<LogLastOpenedAppService>(
    () => LogLastOpenedAppServiceImpl(
      localService: sl_core_dependencies(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<GetRecorderStatsRepository>(
    () => GetRecorderStatsRepositoryImpl(
      localDataSource: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<VoiceNotesPlayerRepository>(
    () => VoiceNotePlayerRepositoryImpl(
      voiceNotePlayerLocalService: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<CacheClearingService>(
    () => CacheClearingServiceImpl(
      localService: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<AppPageStatusRepository>(
    () => AppPageStatusRepositoryImpl(
      localDataSource: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<CacheMostRecentAcitivtyService>(
    () => CacheMostRecentActivityServiceImpl(
      localService: sl_core_dependencies(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  // Sources
  sl_core_dependencies
      .registerLazySingleton<StartRecordingVoiceNoteLocalService>(
    () => StartRecordingVoiceNoteLocalServiceImpl(
      recorder: sl_core_dependencies(),
      permissionManager: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<StopRecordingLocalService>(
    () => StopRecordingLocalServiceImpl(
      recorder: sl_core_dependencies(),
      fileUtils: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<SaveFeedbackLocalService>(
    () => SaveFeedbackLocalServiceImpl(
      localClient: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<MoodCacheLocalService>(
    () => MoodCacheLocalServiceImpl(
      localClient: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<AppDurationLocalDataSource>(
    () => AppDurationLocalDataSourceImpl(
      localClient: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<AppLastOpenedLogLocalService>(
    () => AppLastOpenedLogLocalServiceImpl(
      localClient: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<GetRecorderStatsLocalDataSource>(
    () => GetRecorderStatsLocalDataSourceImpl(
      recorder: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<VoiceNotePlayerLocalService>(
    () => VoiceNotePlayerLocalServiceImpl(
      player: sl_core_dependencies(),
      fileUtils: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<CacheClearingLocalService>(
    () => CacheClearingLocalServiceImpl(
      localClient: sl_core_dependencies(),
      flutterSecureStorage: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<AppPageStatusLocalDataSource>(
    () => AppPageStatusLocalDataSourceImpl(),
  );
  sl_core_dependencies
      .registerLazySingleton<CacheMostRecentAcitivityLocalService>(
    () => CacheMostRecentAcitivityLocalServiceImpl(
      localClient: sl_core_dependencies(),
    ),
  );
  //Core
  sl_core_dependencies.registerLazySingleton(
    () => CallIfNetworkConnected(
      networkInfo: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => HandleException(),
  );
  sl_core_dependencies.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton<PermissionManager>(
    () => PermissionManagerImpl(),
  );
  sl_core_dependencies.registerLazySingleton<FileUtils>(
    () => FileUtilsImpl(
      box: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => ApiClient(
      client: sl_core_dependencies(),
    ),
  );
  sl_core_dependencies.registerLazySingleton(
    () => ThrowExceptionIfResponseError(),
  );
  sl_core_dependencies.registerLazySingleton<SetupAnalytics>(
    () => SetupAnalyticsImpl(),
  );

  // External
  sl_core_dependencies.registerLazySingleton(
    () => Client(),
  );
  sl_core_dependencies.registerLazySingleton(
    () => Connectivity(),
  );
  final box = await Hive.openBox(
    PersistenceConst.CORE_BOX,
  );
  sl_core_dependencies.registerLazySingleton<Box>(
    () => box,
  );
  sl_core_dependencies.registerLazySingleton<FlutterSoundRecorder>(
    () => FlutterSoundRecorder(),
  );
  sl_core_dependencies.registerLazySingleton(
    () => FlutterSoundPlayer(),
  );
}
