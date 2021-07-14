// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/repository/list-activities-repository-impl.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/sources/list-activities-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/repository/list-activities-repository.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/usecases/list-activities.dart';
import 'package:tatsam_app_experimental/features/view-all-content/presentation/controller/list-activities-controller.dart';

final sl_view_all_content = GetIt.instance;

Future<void> initViewAllContentDependencies() async {
  // Factories
  Get.lazyPut(
    () => ListActivitiesController(
      listAllActivities: sl_view_all_content(),
    ),
  );

  // Usecases
  sl_view_all_content.registerLazySingleton(
    () => ListAllActivities(
      repository: sl_view_all_content(),
    ),
  );

  // Services/Repos
  sl_view_all_content.registerLazySingleton<ListActivitiesRepository>(
    () => ListActivitiesRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      listActivitiesRemoteDataSource: sl_view_all_content(),
    ),
  );

  // Sources
  sl_view_all_content.registerLazySingleton<ListActivitiesRemoteDataSource>(
    () => ListActivitiesRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
