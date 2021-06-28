// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../features/what-path-to-choose/data/repositories/get_journey_path_list_repository_impl.dart';
import '../features/what-path-to-choose/data/repositories/start-journey-service-impl.dart';
import '../features/what-path-to-choose/data/sources/get_journey_path_list_remote_data_source.dart';
import '../features/what-path-to-choose/data/sources/start-journey-remote-service.dart';
import '../features/what-path-to-choose/domain/repositories/get_journey_path_list_repository.dart';
import '../features/what-path-to-choose/domain/repositories/start_journey_service.dart';
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
  sl_journey.registerLazySingleton<GetJounreyPathListRepository>(
    () => GetJourneyPathListRpositoryImpl(
      remoteDataSource: sl_journey(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_journey.registerLazySingleton<StartJourneyService>(
    () => StartJourneyServiceImpl(
      remoteService: sl_journey(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  // Sources
  sl_journey.registerLazySingleton<GetJourneyPathListRemoteDataSource>(
    () => GetJourneyPathListRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_journey.registerLazySingleton<StartJourneyRemoteService>(
    () => StartJourneyRemoteServiceImp(
      client: sl_core_dependencies(),
      localClient: sl_journey(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  // External
}
