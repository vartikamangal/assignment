import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/features/path/data/repositories/get-activity-schedule-guided-plan-repository-impl.dart';
import 'package:tatsam_app_experimental/features/path/data/repositories/start-activity-service-impl.dart';
import 'package:tatsam_app_experimental/features/path/data/repositories/update-activity-status-service-impl.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/start-activity-remote-service.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/update-activity-status-remote-sevice.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/start-activity-service.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/update-activity-status-service.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/start-activity.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/update-activity-status.dart';
import '../features/path/data/repositories/get-activity-category-repository-impl.dart';
import '../features/path/data/repositories/get-all-recommendation-categories-repository-impl.dart';
import '../features/path/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import '../features/path/data/sources/get-category-activites-remote-data-source.dart';
import '../features/path/domain/repositories/get-all-recommendation-catoegories-repository.dart';
import '../features/path/domain/repositories/get-category-activities-repository.dart';
import '../features/path/domain/usecases/get-activity-categories.dart';
import '../features/path/domain/usecases/get-all-recommendation-categories.dart';
import '../features/path/presentation/controller/path-controller.dart';

final sl_path = GetIt.instance;

Future<void> initPathDependencies() async {
  // Factories
  Get.lazyPut(
    () => PathController(
      getAllRecommendationCategories: sl_path(),
      getCategoryActivities: sl_path(),
      startActivity: sl_path(),
      updateActivityStatus: sl_path(),
      getActivityScheduleForGuidedPlan: sl_path(),
    ),
  );

  // Usecases
  sl_path.registerLazySingleton(
    () => GetAllRecommendationCategories(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => GetCategoryActivities(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => StartActivity(
      service: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => UpdateActivityStatus(
      service: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => GetActivityScheduleForGuidedPlan(
      repository: sl_path(),
    ),
  );
  // Services/Repos
  sl_path.registerLazySingleton<GetAllRecommendationCategoriesRepository>(
    () => GetAllRecommendationCategoriesRepositoryImpl(
      remoteDataSource: sl_path(),
      networkInfo: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<GetCategoryActivitiesRepository>(
    () => GetCategoryActivitiesRepositoryImpl(
      remoteDataSource: sl_path(),
      networkInfo: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<StartActivityService>(
    () => StartActivityServiceImpl(
      remoteService: sl_path(),
      networkInfo: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<UpdateActivityStatusService>(
    () => UpdateActivityStatusServiceImpl(
      remoteService: sl_path(),
      networkInfo: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<GetActivitySceduleForGuidedPlanRepository>(
    () => GetActivityScheduleGuidedPlanRepositoryImpl(
      remoteDataSource: sl_path(),
      networkInfo: sl_path(),
    ),
  );
  // Sources
  sl_path.registerLazySingleton<GetAllRecommendationCategoriesRemoteDataSource>(
    () => GetAllRecommendationCategoriesRemoteDataSourceImpl(
      client: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<GetCategoryActivitiesRemoteDataSource>(
    () => GetCategoryActivitiesRemoteDataSourceImpl(
      client: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<StartActivityRemoteService>(
    () => StartActivityRemoteServiceImpl(
      client: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<UpdateActivityStatusRemoteService>(
    () => UpdateActivityStatusRemoteServiceImpl(
      client: sl_path(),
    ),
  );
  sl_path
      .registerLazySingleton<GetActivityScheduleForGuidedPlanRemoteDataSource>(
    () => GetActivityScheduleForGuidedPlanRemoteDataSourceImpl(
      client: sl_path(),
    ),
  );
}
