// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/rapport-building-repository-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
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
  sl_rapport.registerLazySingleton<RapportBuildingRepository>(
    () => RapportBuildingRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_rapport(),
    ),
  );
  // Sources
  sl_rapport.registerLazySingleton<RapportBuildingRemoteDataSource>(
    () => RapportBuildingRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  // External
}
