import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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
      networkInfo: sl_journey(),
    ),
  );
  sl_journey.registerLazySingleton<StartJourneyService>(
    () => StartJourneyServiceImpl(
      remoteService: sl_journey(),
      networkInfo: sl_journey(),
    ),
  );
  // Sources
  sl_journey.registerLazySingleton<GetJourneyPathListRemoteDataSource>(
    () => GetJourneyPathListRemoteDataSourceImpl(
      client: sl_journey(),
    ),
  );
  sl_journey.registerLazySingleton<StartJourneyRemoteService>(
    () => StartJourneyRemoteServiceImp(
      client: sl_journey(),
    ),
  );
  // External
}
