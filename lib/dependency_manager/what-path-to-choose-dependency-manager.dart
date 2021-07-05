// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/repositories/path-operations-repository-impl.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/path-operations-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/path-operations-repository.dart';

// Project imports:
import '../features/what-path-to-choose/domain/usecases/get-journey-path-list.dart';
import '../features/what-path-to-choose/domain/usecases/start_journey.dart';
import '../features/what-path-to-choose/presentation/controller/choose-path-controller.dart';

final sl_journey = GetIt.instance;

Future<void> initJourneyDependencies() async {
  // Factories
  Get.lazyPut(
    () => ChoosePathController(
      getJourneyPathList: sl_journey(),
      startJourney: sl_journey(),
      checkIfAuthenticated: sl_journey(),
    ),
  );
  // Usecases
  sl_journey.registerLazySingleton(
    () => GetJourneyPathList(
      repository: sl_journey(),
    ),
  );
  sl_journey.registerLazySingleton(
    () => StartJourney(
      service: sl_journey(),
    ),
  );
  // Repositories & Services
  sl_journey.registerLazySingleton<PathOperationsRepository>(
    () => PathOperationsRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_journey(),
    ),
  );
  // Sources
  sl_journey.registerLazySingleton<PathOperationsRemoteDataSource>(
    () => PathOperationsRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      localClient: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  // External
}
