// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import '../features/hub/data/repositories/create-traveller-service-impl.dart';
import '../features/hub/data/repositories/get-hub-status-repository-impl.dart';
import '../features/hub/data/sources/create-traveller-remote-service.dart';
import '../features/hub/data/sources/get-hub-status-remote-data-source.dart';
import '../features/hub/domain/repository/create-traveller-service.dart';
import '../features/hub/domain/repository/get-hub-status-repository.dart';
import '../features/hub/domain/usecases/create-travller.dart';
import '../features/hub/domain/usecases/get-hub-status.dart';
import '../features/hub/presentation/controller/hub-controller.dart';

final sl_hub = GetIt.instance;

Future<void> initHubDependencies() async {
  // Factories
  Get.lazyPut(
    () => HubController(
      getHubStatus: sl_hub(),
      createTraveller: sl_hub(),
      requestLogin: sl_hub(),
      checkIfAlreadyLoggedIn: sl_hub(),
    ),
  );

  // Usecases
  sl_hub.registerLazySingleton(
    () => GetHubStatus(
      repository: sl_hub(),
    ),
  );
  sl_hub.registerLazySingleton(
    () => CreateTraveller(
      service: sl_hub(),
    ),
  );
  // Services/Repos
  sl_hub.registerLazySingleton<GetHubStatusRepository>(
    () => GetHubStatusRepositoryImpl(
      remoteDataSource: sl_hub(),
      networkInfo: sl_hub(),
    ),
  );
  sl_hub.registerLazySingleton<CreateTravellerService>(
    () => CreateTravellerServiceImpl(
      remoteService: sl_hub(),
      networkInfo: sl_hub(),
    ),
  );
  // Sources
  sl_hub.registerLazySingleton<GetHubStatusRemoteDataSource>(
    () => GetHubStatusRemoteDataSourceImpl(
      remoteClient: sl_hub(),
    ),
  );
  sl_hub.registerLazySingleton<CreateTravellerRemoteService>(
    () => CreateTravellerRemoteServiceImpl(
      client: sl_hub(),
    ),
  );
}
