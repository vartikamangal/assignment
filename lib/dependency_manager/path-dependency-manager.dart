// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-category-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-schedule-guided-plan-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-all-recommendation-categories-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/persist-recommendation-feedback-service-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/persist-recommendation-input-local-service.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-all-recommendation-catoegories-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-category-activities-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/persist-recommendation-feedback-service.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-categories.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-all-recommendation-categories.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-persisted-feedbacks.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/persist-recommendation-feedback.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/rate-recommendation-flow.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/start-activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/update-activity-status.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../core/cache-manager/data/repositories/cache-most-recent-acitivty-service-impl.dart';
import '../core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import '../core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import '../core/cache-manager/domain/usecases/cache-most-recent-acitivity.dart';

final sl_path = GetIt.instance;

Future<void> initPathDependencies() async {
  // Factories
  Get.lazyPut(
    () => PathController(
      retrieveUserPath: sl_path(),
      getAllRecommendationCategories: sl_path(),
      getCategoryActivities: sl_path(),
      startActivity: sl_path(),
      updateActivityStatus: sl_path(),
      getActivityScheduleForGuidedPlan: sl_path(),
      persistRecommendationFeedback: sl_path(),
      rateRecommendationFlow: sl_path(),
      cacheMostRecentAcitivity: sl_path(),
      saveFeedback: sl_path(),
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
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => UpdateActivityStatus(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => GetActivityScheduleForGuidedPlan(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => PersistRecommendationFeedback(
      service: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => RateRecommendationFlow(
      repository: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => CacheMostRecentAcitivity(
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
  sl_path.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<GetActivitySceduleForGuidedPlanRepository>(
    () => GetActivityScheduleGuidedPlanRepositoryImpl(
      remoteDataSource: sl_path(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<RecommendationFeedbackService>(
    () => RecommendationFeedbackServiceImpl(
      localService: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<CacheMostRecentAcitivtyService>(
    () => CacheMostRecentActivityServiceImpl(
      localService: sl_path(),
      baseRepository: sl_core_dependencies(),
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
  sl_path.registerLazySingleton<AcitivityRemoteDataSource>(
    () => AcitivityRemoteDataSourceImpl(
      apiClient: sl_core_dependencies(),
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
  sl_path.registerLazySingleton<PersistRecommendationFeedbackLocalService>(
    () => PersistRecommendationFeedbackLocalServiceImpl(
      box: sl_path(),
    ),
  );

  sl_path.registerLazySingleton<CacheMostRecentAcitivityLocalService>(
    () => CacheMostRecentAcitivityLocalServiceImpl(
      localClient: sl_path(),
    ),
  );
}
