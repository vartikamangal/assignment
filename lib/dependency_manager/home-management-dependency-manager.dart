// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import '../core/cache-manager/data/repositories/retrieve-most-recent-activity-repository-impl.dart';
import '../core/cache-manager/data/repositories/retrieve-user-path-repository-impl.dart';
import '../core/cache-manager/data/repositories/save-user-onboarding-status-service-impl.dart';
import '../core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import '../core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import '../core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import '../core/cache-manager/domain/repositories/retrieve-most-recent-activity-repository.dart';
import '../core/cache-manager/domain/repositories/retrieve-user-path-repository.dart';
import '../core/cache-manager/domain/repositories/save-user-onboarding-status-service.dart';
import '../core/cache-manager/domain/usecases/check-if-first-time-user.dart';
import '../core/cache-manager/domain/usecases/retireve-most-recent-activity.dart';
import '../core/cache-manager/domain/usecases/retireve-user-path.dart';
import '../core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import '../core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';
import '../core/cache-manager/domain/usecases/save-user-onboarding-status.dart';
import '../dependency_manager/core_dependency_managers.dart';
import '../features/home-management/data/repositories/add-weekly-category-service-impl.dart';
import '../features/home-management/data/repositories/get-action-with-action-status-repository-impl.dart';
import '../features/home-management/data/repositories/get-recommendations-repository-impl.dart';
import '../features/home-management/data/repositories/mood-popup-shown-repository-impl.dart';
import '../features/home-management/data/sources/add-weekly-category-remote-service.dart';
import '../features/home-management/data/sources/get-action-with-action-status-remote-data-source.dart';
import '../features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';
import '../features/home-management/data/sources/mood-popup-shown-local-data-source.dart';
import '../features/home-management/domain/repositories/add-weekly-category-service.dart';
import '../features/home-management/domain/repositories/get-action-with-action-status-repository.dart';
import '../features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart';
import '../features/home-management/domain/repositories/mood-popup-shown-repository.dart';
import '../features/home-management/domain/usecases/add-weekly-activity.dart';
import '../features/home-management/domain/usecases/add-weekly-category.dart';
import '../features/home-management/domain/usecases/get-action-with-action-status.dart';
import '../features/home-management/domain/usecases/get-mood-popup-shown-status.dart';
import '../features/home-management/domain/usecases/get-recommendations-by-action-time.dart';
import '../features/home-management/domain/usecases/toggle-mood-popup-shown-state.dart';
import '../features/home-management/presentation/controller/home-controller.dart';

final sl_home_manager = GetIt.instance;

Future<void> initHomeManagementDependencies() async {
  //Core
  Get.lazyPut(
    () => HomeController(
      retrieveMostRecentActivity: sl_home_manager(),
      retrieveUserPath: sl_home_manager(),
      userOnboardingStatus: sl_home_manager(),
      getRecommendationsByActionTime: sl_home_manager(),
      retrieveUserOnboardingStatus: sl_home_manager(),
      getActionWithActionStatus: sl_home_manager(),
      checkIfFirstTimeUser: sl_home_manager(),
      saveIsFirstTimeOnboardingStatus: sl_home_manager(),
      rateRecommendationFlow: sl_home_manager(),
      updateActivityStatus: sl_home_manager(),
      getAllRecommendationCategories: sl_home_manager(),
      getCategoryActivities: sl_home_manager(),
      addWeeklyCategory: sl_home_manager(),
      addWeeklyActivity: sl_home_manager(),
      getCachedMood: sl_home_manager(),
      userDurationOnApp: sl_home_manager(),
      getLastLogin: sl_home_manager(),
      setSubjectMood: sl_home_manager(),
      getAllMoods: sl_home_manager(),
      getIsMoodPopupShownStatus: sl_home_manager(),
      toggleMoodPopupShownState: sl_home_manager(),
      retirieveLastLoggedAppInit: sl_home_manager(),
    ),
  );
  // Usecases
  sl_home_manager.registerLazySingleton(
    () => RetrieveMostRecentActivity(
      repository: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => RetrieveUserPath(
      repository: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => SaveUserOnboardingStatus(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => GetRecommendationsByActionTime(
      repository: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => RetrieveUserOnboardingStatus(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => GetActionWithActionStatus(
      repository: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => CheckIfFirstTimeUser(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => SaveIsFirstTimeOnboardingStatus(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => AddWeeklyCategory(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => AddWeeklyActivity(
      service: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => GetIsMoodPopupShownStatus(
      repository: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton(
    () => ToggleMoodPopupShownState(
      repository: sl_home_manager(),
    ),
  );
  // Repos/Services
  sl_home_manager.registerLazySingleton<RetrieveMostRecentAcitivityRepository>(
    () => RetreieveMostRecentAcitvityRepositoryImpl(
      localDataSource: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<RetrieveUserPathRepository>(
    () => RetrieveUserPathRepositoryImpl(
      localDataSource: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<SaveUserOnboardingStatusService>(
    () => SaveUserOnboardingStatusServiceImpl(
      localService: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager
      .registerLazySingleton<GetRecommendationsByActionTimeRepository>(
    () => GetRecommendationsByActionTimeRepositoryRepositoryImpl(
      remoteDataSource: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<GetActionWithActionStatusRepository>(
    () => GetActionWithActionStatusRepositoryImpl(
      remoteDataSource: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<AddWeeklyCategoryService>(
    () => AddWeeklyCategoryServiceImpl(
      remoteService: sl_home_manager(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<MoodPopupShownRepository>(
    () => MoodPopupShownRepositoryImpl(
      localDataSource: sl_home_manager(),
    ),
  );
  // Remote/Local Sources
  sl_home_manager
      .registerLazySingleton<RetrieveMostRecentActivityLocalDataSource>(
    () => RetrieveMostRecentActivityLocalDataSourceImpl(
      localClient: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton<RetrieveUserPathLocalDataSource>(
    () => RetrieveUserPathLocalDataSourceImpl(
      localClient: sl_home_manager(),
    ),
  );
  sl_home_manager.registerLazySingleton<UserOnboardingStatusLocalService>(
    () => UserOnboardingStatusLocalServiceImpl(
      localClient: sl_home_manager(),
    ),
  );
  sl_home_manager
      .registerLazySingleton<GetRecommendationsByActionTimeRemoteDataSource>(
    () => GetRecommendationsByActionTimeRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_home_manager
      .registerLazySingleton<GetActionWithActionStatusRemoteDataSource>(
    () => GetActionWithActionStatusRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<AddWeeklyCategoryRemoteService>(
    () => AddWeeklyCategoryRemoteServiceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_home_manager.registerLazySingleton<MoodPopupShownLocalDataSource>(
    () => MoodPopupShownLocalDataSourceImpl(
      localClient: sl_home_manager(),
    ),
  );
}
