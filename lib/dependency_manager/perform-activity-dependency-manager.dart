// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/repositories/activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/rate-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/start-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/update-activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/content_page_controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

final sl_perform_activity = GetIt.instance;

Future<void> initPerformActivityDependencies() async {
  // Factories
  Get.lazyPut<PerformActivityController>(() => PerformActivityController(
        updateActivityStatus: sl_perform_activity(),
        startActivity: sl_perform_activity(),
      ));
  Get.lazyPut<ContentPageController>(() => ContentPageController(
        rateActivity: sl_perform_activity(),
      ));

  // Usecases
  sl_perform_activity.registerLazySingleton(
    () => RateActivity(
      repository: sl_perform_activity(),
    ),
  );
  sl_perform_activity.registerLazySingleton(
    () => UpdateActivityStatus(
      repository: sl_perform_activity(),
    ),
  );
  sl_perform_activity.registerLazySingleton(
    () => StartActivity(
      repository: sl_perform_activity(),
    ),
  );
  // Services/Repos
  sl_perform_activity.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_perform_activity(),
    ),
  );
  // Sources
  sl_perform_activity.registerLazySingleton<AcitivityRemoteDataSource>(
    () => AcitivityRemoteDataSourceImpl(
      apiClient: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
