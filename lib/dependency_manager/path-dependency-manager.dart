// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/get-persisted-feedbacks.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../core/activity-management/data/repositories/get-activity-category-repository-impl.dart';
import '../core/activity-management/data/repositories/get-activity-schedule-guided-plan-repository-impl.dart';
import '../core/activity-management/data/repositories/get-all-recommendation-categories-repository-impl.dart';
import '../core/activity-management/data/repositories/persist-recommendation-feedback-service-impl.dart';
import '../core/activity-management/data/repositories/rate-recommendation-flow-service-impl.dart';
import '../core/activity-management/data/repositories/start-activity-service-impl.dart';
import '../core/activity-management/data/repositories/update-activity-status-service-impl.dart';
import '../core/activity-management/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import '../core/activity-management/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import '../core/activity-management/data/sources/get-category-activites-remote-data-source.dart';
import '../core/activity-management/data/sources/persist-recommendation-input-local-service.dart';
import '../core/activity-management/data/sources/rate-recommendation-flow-remote-service.dart';
import '../core/activity-management/data/sources/start-activity-remote-service.dart';
import '../core/activity-management/data/sources/update-activity-status-remote-sevice.dart';
import '../core/activity-management/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import '../core/activity-management/domain/repositories/get-all-recommendation-catoegories-repository.dart';
import '../core/activity-management/domain/repositories/get-category-activities-repository.dart';
import '../core/activity-management/domain/repositories/persist-recommendation-feedback-service.dart';
import '../core/activity-management/domain/repositories/rate-recommendation-flow-service.dart';
import '../core/activity-management/domain/repositories/start-activity-service.dart';
import '../core/activity-management/domain/repositories/update-activity-status-service.dart';
import '../core/activity-management/domain/usecases/get-activity-categories.dart';
import '../core/activity-management/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import '../core/activity-management/domain/usecases/get-all-recommendation-categories.dart';
import '../core/activity-management/domain/usecases/persist-recommendation-feedback.dart';
import '../core/activity-management/domain/usecases/rate-recommendation-flow.dart';
import '../core/activity-management/domain/usecases/start-activity.dart';
import '../core/activity-management/domain/usecases/update-activity-status.dart';
import '../core/activity-management/presentation/controller/path-controller.dart';
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
  sl_path.registerLazySingleton(
    () => PersistRecommendationFeedback(
      service: sl_path(),
    ),
  );
  sl_path.registerLazySingleton(
    () => RateRecommendationFlow(
      service: sl_path(),
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
  sl_path.registerLazySingleton<StartActivityService>(
    () => StartActivityServiceImpl(
      remoteService: sl_path(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<UpdateActivityStatusService>(
    () => UpdateActivityStatusServiceImpl(
      remoteService: sl_path(),
      baseRepository: sl_core_dependencies(),
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
  sl_path.registerLazySingleton<RateRecommendationFlowService>(
    () => RateRecommendationFlowServiceImpl(
      remoteService: sl_path(),
      baseRepository: sl_core_dependencies(),
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
  sl_path.registerLazySingleton<StartActivityRemoteService>(
    () => StartActivityRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<UpdateActivityStatusRemoteService>(
    () => UpdateActivityStatusRemoteServiceImpl(
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
  sl_path.registerLazySingleton<PersistRecommendationFeedbackLocalService>(
    () => PersistRecommendationFeedbackLocalServiceImpl(
      box: sl_path(),
    ),
  );
  sl_path.registerLazySingleton<RateRecommendationFlowRemoteService>(
    () => RateRecommendationFlowRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_path.registerLazySingleton<CacheMostRecentAcitivityLocalService>(
    () => CacheMostRecentAcitivityLocalServiceImpl(
      localClient: sl_path(),
    ),
  );
}
