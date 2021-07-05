// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/repository/wheel-of-life-repository-impl.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';

// Project imports:
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
  sl_wol.registerLazySingleton<WheelOfLifeRepository>(
    () => WheelOfLifeRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_wol(),
    ),
  );
  // Sources
  sl_wol.registerLazySingleton<WheelOfLifeRemoteDataSource>(
    () => WheelOfLifeRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  // External
}
