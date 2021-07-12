// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-category-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-schedule-guided-plan-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-all-recommendation-categories-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-all-recommendation-catoegories-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-category-activities-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-categories.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-all-recommendation-categories.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/persist-activity-feedback-repository-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/persist-activity-feedback-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/persist-activity-feedback-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/get-persisted-feedbacks.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/persist-activity-feedbacks.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

final sl_path = GetIt.instance;

Future<void> initPathDependencies() async {
  // Factories
  Get.lazyPut(
    () => PathController(
      retrieveUserPath: sl_path(),
      getAllRecommendationCategories: sl_path(),
      getCategoryActivities: sl_path(),
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
    () => GetActivityScheduleForGuidedPlan(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => PersistActivityFeedback(
      service: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => GetPersistedFeedbacks(
      service: sl_path(),
    ),
  );
  // Services/Repos
  sl_path.registerLazySingleton<GetAllRecommendationCategoriesRepository>(
    () => GetAllRecommendationCategoriesRepositoryImpl(
      remoteDataSource: sl_path(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<GetCategoryActivitiesRepository>(
    () => GetCategoryActivitiesRepositoryImpl(
      remoteDataSource: sl_path(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<GetActivitySceduleForGuidedPlanRepository>(
    () => GetActivityScheduleGuidedPlanRepositoryImpl(
      remoteDataSource: sl_path(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<PersistActivityFeedbackRepository>(
    () => PersistAcitivityFeedbackRepositoryImpl(
      localService: sl_path(),
    ),
  );
  // Sources
  sl_path.registerLazySingleton<GetAllRecommendationCategoriesRemoteDataSource>(
    () => GetAllRecommendationCategoriesRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<GetCategoryActivitiesRemoteDataSource>(
    () => GetCategoryActivitiesRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );

  sl_path
      .registerLazySingleton<GetActivityScheduleForGuidedPlanRemoteDataSource>(
    () => GetActivityScheduleForGuidedPlanRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<PersistActivityFeedbackLocalService>(
    () => PersistActivityFeedbackLocalServiceImpl(
      box: sl_path(),
    ),
  );
}
