import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../features/wheel-of-life-track/data/repository/get-life-areas-repository-impl.dart';
import '../features/wheel-of-life-track/data/repository/get-rating-scale-repository-impl.dart';
import '../features/wheel-of-life-track/data/repository/prioritize-service-impl.dart';
import '../features/wheel-of-life-track/data/repository/rate-satisfaction-ratings-service-impl.dart';
import '../features/wheel-of-life-track/data/sources/get-life-areas-remote-data-source.dart';
import '../features/wheel-of-life-track/data/sources/get-rating-scale-remote-data-source.dart';
import '../features/wheel-of-life-track/data/sources/prioritize-remote-service.dart';
import '../features/wheel-of-life-track/data/sources/rate-satisfaction-remote-service.dart';
import '../features/wheel-of-life-track/domain/repositories/get-life-areas-repository.dart';
import '../features/wheel-of-life-track/domain/repositories/get-rating-scale-repository.dart';
import '../features/wheel-of-life-track/domain/repositories/prioritize-service.dart';
import '../features/wheel-of-life-track/domain/repositories/rate-satisfaction-service.dart';
import '../features/wheel-of-life-track/domain/usecases/get-life-areas.dart';
import '../features/wheel-of-life-track/domain/usecases/get-rating-scale.dart';
import '../features/wheel-of-life-track/domain/usecases/prioritize.dart';
import '../features/wheel-of-life-track/domain/usecases/rate-satisfaction.dart';
import '../features/wheel-of-life-track/presentation/controllers/wheel-of-life-controller.dart';

final sl_wol = GetIt.instance;

Future<void> initWheelOfLifeDependencies() async {
  // Factories
  Get.lazyPut(
    () => WheelOfLifeController(
      getLifeAreas: sl_wol(),
      getRatingScale: sl_wol(),
      prioritize: sl_wol(),
      rateSatisfaction: sl_wol(),
    ),
  );
  // Usecases
  sl_wol.registerLazySingleton(
    () => GetLifeAreas(
      repository: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton(
    () => GetRatingScale(
      repository: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton(
    () => Prioritize(
      service: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton(
    () => RateSatisfaction(
      service: sl_wol(),
    ),
  );
  // Repositories & Services
  sl_wol.registerLazySingleton<GetLifeAreasRepository>(
    () => GetLifeAreasRepositoryImpl(
      source: sl_wol(),
      networkInfo: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<GetRatingScaleRepository>(
    () => GetRatingScaleRepositoryImpl(
      remoteDataSource: sl_wol(),
      networkInfo: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<PrioritizeService>(
    () => PrioritizeServiceImpl(
      networkInfo: sl_wol(),
      remoteService: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<RateSatisfactionService>(
    () => RateSatisfactionServiceImpl(
      networkInfo: sl_wol(),
      remoteService: sl_wol(),
    ),
  );
  // Sources
  sl_wol.registerLazySingleton<GetLifeAreasRemoteDataSource>(
    () => GetLifeAreasRemoteDataSourceImpl(
      client: sl_wol(),
      sessionClient: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<GetRatingScaleRemoteDataSource>(
    () => GetRatingScaleRemoteDataSourceImpl(
      client: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<PrioritizeRemoteService>(
    () => PrioritizeRemoteServiceImpl(
      client: sl_wol(),
      sessionClient: sl_wol(),
    ),
  );
  sl_wol.registerLazySingleton<RateSatisfactionRemoteService>(
    () => RateSatisfactionRemoteServiceImpl(
      client: sl_wol(),
      sessionClient: sl_wol(),
    ),
  );
  // External
}
