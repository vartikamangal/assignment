// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/repositories/instant-relief-repository-impl.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/get-instant-recommendations.dart';

// Project imports:
import '../features/instant-relief/domain/usecases/get-instant-relief-areas.dart';
import '../features/instant-relief/domain/usecases/list-emergency-numbers.dart';
import '../features/instant-relief/presentation/controllers/instant-relief-controller.dart';

final sl_instant_relief = GetIt.instance;

Future<void> initInstantReliefDependencies() async {
  // Factories
  Get.lazyPut(
    () => InstantReliefController(
      getInstantReliefAreas: sl_instant_relief(),
      listEmergencyNumbers: sl_instant_relief(),
      getInstantRecommendations: sl_instant_relief(),
      checkIfAuthenticated: sl_instant_relief(),
    ),
  );

  // Usecases
  sl_instant_relief.registerLazySingleton(
    () => GetInstantReliefAreas(
      repository: sl_instant_relief(),
    ),
  );
  sl_instant_relief.registerLazySingleton(
    () => ListEmergencyNumbers(
      repository: sl_instant_relief(),
    ),
  );
  sl_instant_relief.registerLazySingleton(
    () => GetInstantRecommendations(
      repository: sl_instant_relief(),
    ),
  );
  // Services/Repos
  sl_instant_relief.registerLazySingleton<InstantReliefRepository>(
    () => InstantReliefRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_instant_relief(),
    ),
  );

  // Sources
  sl_instant_relief.registerLazySingleton<InstantReliefRemoteDataSource>(
    () => InstantReliefRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
