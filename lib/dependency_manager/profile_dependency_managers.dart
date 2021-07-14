// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../features/profile-screen/data/repositories/profile-details-repository-impl.dart';
import '../features/profile-screen/data/sources/profile-details-remote-data-source.dart';
import '../features/profile-screen/domain/repositories/profile-details-repository.dart';
import '../features/profile-screen/domain/usecases/get-basic-profile-details.dart';
import '../features/profile-screen/domain/usecases/get-mood-logs.dart';
import '../features/profile-screen/domain/usecases/get-profile-questions.dart';
import '../features/profile-screen/domain/usecases/get-profile-wheel-of-life-data.dart';
import '../features/profile-screen/presentation/controller/profile-controller.dart';

final sl_profile = GetIt.instance;

Future<void> initProfileDependencies() async {
  // Factories
  Get.lazyPut(() => ProfileController(
        getBasicProfileDetails: sl_profile(),
        getMoodLogs: sl_profile(),
        getProfileQuestions: sl_profile(),
        getProfileWheelOfLifeData: sl_profile(),
        getPersistedFeedbacks: sl_profile(),
        getActionWithActionStatus: sl_profile(),
      ));

  // Usecases
  sl_profile.registerLazySingleton(
    () => GetBasicProfileDetails(
      repository: sl_profile(),
    ),
  );

  sl_profile.registerLazySingleton(
    () => GetMoodLogs(
      repository: sl_profile(),
    ),
  );
  sl_profile.registerLazySingleton(
    () => GetProfileQuestions(
      repository: sl_profile(),
    ),
  );
  sl_profile.registerLazySingleton(
    () => GetProfileWheelOfLifeData(
      repository: sl_profile(),
    ),
  );
  // Services/Repos
  sl_profile.registerLazySingleton<ProfileDetailsRepository>(
    () => ProfileDetailsRepositoryImpl(
      remoteDataSource: sl_profile(),
      baseRepository: sl_core_dependencies(),
    ),
  );
  // Sources
  sl_profile.registerLazySingleton<ProfileDetailsRemoteDataSource>(
    () => ProfileDetailsRemoteDataSourceImpl(
      client: sl_profile(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
