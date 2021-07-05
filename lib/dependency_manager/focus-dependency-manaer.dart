// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/focus/data/repositories/focus-repository-impl.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/focus-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';

// Project imports:
import '../features/focus/domain/usecases/add-issue.dart';
import '../features/focus/domain/usecases/get-issues.dart';
import '../features/focus/presentation/controller/focus-screen-controller.dart';

final sl_focus = GetIt.instance;

Future<void> initFocusDependencies() async {
  //Core
  Get.lazyPut(
    () => FocusController(
      getIssues: sl_focus(),
      setTarget: sl_focus(),
    ),
  );
  // Usecases
  sl_focus.registerLazySingleton(
    () => GetIssues(
      repository: sl_focus(),
    ),
  );
  sl_focus.registerLazySingleton(
    () => SetTarget(
      service: sl_focus(),
    ),
  );
  // Repos/Services
  sl_focus.registerLazySingleton<FocusRepository>(
    () => FocusRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_focus(),
    ),
  );
  // Remote/Local Sources
  sl_focus.registerLazySingleton<FocusRemoteDataSource>(
    () => FocusRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
