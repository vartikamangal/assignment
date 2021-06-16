// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/get-instant-recommendations.dart';

// Project imports:
import '../features/instant-relief/data/repositories/get-instant-relief-areas-repository-impl.dart';
import '../features/instant-relief/data/repositories/list-emergency-numbers-repository-impl.dart';
import '../features/instant-relief/data/sources/get-instant-relief-areas-remote-data-source.dart';
import '../features/instant-relief/data/sources/list-emergency-numbers-remote-service.dart';
import '../features/instant-relief/domain/repositories/get-instant-relief-areas-repository.dart';
import '../features/instant-relief/domain/repositories/list-emergency-numbers-repository.dart';
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
      requestLogin: sl_instant_relief(),
      checkIfAlreadyLoggedIn: sl_instant_relief(),
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
  sl_instant_relief.registerLazySingleton<GetInstantReliefAreasRepository>(
    () => GetInstantReliefAreasRepositoryImpl(
      remoteDataSource: sl_instant_relief(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_instant_relief.registerLazySingleton<ListEmergencyNumbersRepository>(
    () => ListEmergencyNumbersRepositoryImpl(
      remoteDataSource: sl_instant_relief(),
      baseRepository: sl_core_dependencies(),
    ),
  );

  // Sources
  sl_instant_relief
      .registerLazySingleton<GetInstantReliefAreasRemoteDataSource>(
    () => GetInstantReliefAreasRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );

  sl_instant_relief.registerLazySingleton<ListEmergencyNumberRemoteDataSource>(
    () => ListEmergencyNumberRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
