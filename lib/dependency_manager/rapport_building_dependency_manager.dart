// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../features/rapport-building/data/repository/get-all-moods-repository-impl.dart';
import '../features/rapport-building/data/repository/get-available-feeling-duration-repository-impl.dart';
import '../features/rapport-building/data/repository/get-rapport-building-steps-repository-impl.dart';
import '../features/rapport-building/data/repository/set-subject-mood-service-impl.dart';
import '../features/rapport-building/data/repository/set-subject-name-service-impl.dart';
import '../features/rapport-building/data/repository/track-subject-mood-service-impl.dart';
import '../features/rapport-building/data/sources/get-all-moods-remote-data-source.dart';
import '../features/rapport-building/data/sources/get-available-feeling-duration-remote-data-source.dart';
import '../features/rapport-building/data/sources/get-rapport-building-steps-remote-data-source.dart';
import '../features/rapport-building/data/sources/set-subject-mood-remote-service.dart';
import '../features/rapport-building/data/sources/set-subject-name-remote-service.dart';
import '../features/rapport-building/data/sources/track-subject-mood-remote-service.dart';
import '../features/rapport-building/domain/repositories/get-all-moods-repository.dart';
import '../features/rapport-building/domain/repositories/get-available-feeling-duration-repository.dart';
import '../features/rapport-building/domain/repositories/get-rapport-building-steps-repository.dart';
import '../features/rapport-building/domain/repositories/set-subject-mood-service.dart';
import '../features/rapport-building/domain/repositories/set-subject-name-service.dart';
import '../features/rapport-building/domain/repositories/track-subject-mood-service.dart';
import '../features/rapport-building/domain/usecases/get-all-moods.dart';
import '../features/rapport-building/domain/usecases/get-available-feeling-duration.dart';
import '../features/rapport-building/domain/usecases/get-rapport-building-steps.dart';
import '../features/rapport-building/domain/usecases/set-subject-mood.dart';
import '../features/rapport-building/domain/usecases/set-subject-name.dart';
import '../features/rapport-building/domain/usecases/track-subject-mood.dart';

final sl_rapport = GetIt.instance;

Future<void> initRapportDependencies() async {
  // Factories
  Get.lazyPut(
    () => RapportBuildingController(
      setSubjectName: sl_rapport(),
      setSubjectMood: sl_rapport(),
      getAllMoods: sl_rapport(),
      saveFeedback: sl_rapport(),
      getRapportBuildingSteps: sl_rapport(),
      getAvailableFeelingDuration: sl_rapport(),
      trackSubjectMood: sl_rapport(),
      cacheMood: sl_rapport(),
    ),
  );
  // Usecases
  sl_rapport.registerLazySingleton(
    () => SetSubjectName(
      service: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton(
    () => SetSubjectMood(
      service: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton(
    () => GetAllMoods(
      repository: sl_rapport(),
    ),
  );

  sl_rapport.registerLazySingleton(
    () => GetRapportBuildingSteps(
      repository: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton(
    () => GetAvailableFeelingDuration(
      repository: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton(
    () => TrackSubjectMood(
      service: sl_rapport(),
    ),
  );
  // Repositories & Services
  sl_rapport.registerLazySingleton<SetSubjectNameService>(
    () => SetSubjectNameServiceImpl(
      service: sl_rapport(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<SetSubjectMoodService>(
    () => SetSubjectMoodServiceImpl(
      baseRepository: sl_core_dependencies(),
      service: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton<GetAllMoodsRepository>(
    () => GetAllMoodsRepositoryImpl(
      source: sl_rapport(),
      baseRepository: sl_core_dependencies(),
    ),
  );

  sl_rapport.registerLazySingleton<GetRapportBuildingStepsRepository>(
    () => GetRapportBuildingStepsRepositoryImpl(
      remoteDataSource: sl_rapport(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<GetAvailableFeelingDurationRepository>(
    () => GetAvailableFeelingDurationRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_rapport(),
    ),
  );
  sl_rapport.registerLazySingleton<TrackSubjectMoodService>(
    () => TrackSubjectMoodServiceImpl(
      service: sl_rapport(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  // Sources
  sl_rapport.registerLazySingleton<SetSubjectNameRemoteService>(
    () => SetSubjectNameRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<SetSubjectMoodRemoteService>(
    () => SetSubjectMoodRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<GetAllMoodsRemoteDataSource>(
    () => GetAllMoodsRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );

  sl_rapport.registerLazySingleton<GetRapportBuildingStepsRemoteDataSource>(
    () => GetRapportBuildingStepsRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<GetAvailableFeelingDurationRemoteDataSource>(
    () => GetAvailableFeelingDurationRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_rapport.registerLazySingleton<TrackSubjectMoodRemoteService>(
    () => TrackSubjectMoodRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  // External
}
