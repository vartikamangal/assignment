import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/permission-manager/permission-manager.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/start-recording-voicenote-service-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/stop-recording-service-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/start-recording-voicenote-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/stop-recording-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/start-recording-voicenote-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/start-recording-voice-note.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-recording.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import '../core/persistence-consts.dart';
import '../core/platform/network_info.dart';

final sl_core_dependencies = GetIt.instance;

Future<void> initCoreDependencies() async {
  //  Factories
  Get.lazyPut<VoiceNoteController>(
    () => VoiceNoteController(
      startRecordingVoiceNote: sl_core_dependencies(),
      soundRecorder: sl_core_dependencies(),
      stopRecording: sl_core_dependencies(),
      fileUtils: sl_core_dependencies(),
    ),
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
  // Respos/Services
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
    ),
  );
  //Core
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
}
