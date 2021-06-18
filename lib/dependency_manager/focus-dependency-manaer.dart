// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../features/focus/data/repositories/add-issue-service-impl.dart';
import '../features/focus/data/repositories/get-issues-repository-impl.dart';
import '../features/focus/data/sources/add-issue-remote-service.dart';
import '../features/focus/data/sources/get-issues-remote-data-source.dart';
import '../features/focus/domain/repositories/add-issue-service.dart';
import '../features/focus/domain/repositories/get-issues-repository.dart';
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
  sl_focus.registerLazySingleton<GetIssuesRepository>(
    () => GetIssuesRepositoryImpl(
      remoteDataSource: sl_focus(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  sl_focus.registerLazySingleton<AddIssueService>(
    () => AddIssueServiceImpl(
      remoteService: sl_focus(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  // Remote/Local Sources
  sl_focus.registerLazySingleton<GetIssueRemoteDataSource>(
    () => GetIssueRemoteDataSourceImpl(
      client: sl_focus(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
  sl_focus.registerLazySingleton<AddIssueRemoteService>(
    () => AddIssueRemoteServiceImpl(
      client: sl_focus(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
