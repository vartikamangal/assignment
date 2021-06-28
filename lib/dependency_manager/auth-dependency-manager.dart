// Package imports:
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/oauth-signup.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../core/auth/data/repositories/auth-repository-impl.dart';
import '../core/auth/data/sources/auth-remote-service.dart';
import '../core/auth/domain/repositories/auth-repository.dart';
import '../core/auth/domain/usecases/check-if-already-logged-in.dart';
import '../core/auth/domain/usecases/oauth-login.dart';
import '../core/auth/domain/usecases/request-logout.dart';
import '../core/auth/domain/usecases/request-new-token.dart';
import '../core/auth/presentation/controller/auth-controller.dart';

final sl_auth = GetIt.instance;

Future<void> initAuthDependencies() async {
  //Core
  Get.lazyPut(
    () => AuthController(
      checkIfAuthenticated: sl_auth(),
      oauthLogin: sl_auth(),
      oAuthSignup: sl_auth(),
      requestLogout: sl_auth(),
      requestNewToken: sl_auth(),
      retrieveUserOnboardingStatus: sl_auth(),
    ),
  );
  // Usecases
  sl_auth.registerLazySingleton(
    () => CheckIfAuthenticated(
      repository: sl_auth(),
    ),
  );
  sl_auth.registerLazySingleton(
    () => OauthLogin(
      repository: sl_auth(),
    ),
  );
  sl_auth.registerLazySingleton(
    () => OAuthSignup(
      repository: sl_auth(),
    ),
  );
  sl_auth.registerLazySingleton(
    () => RequestLogout(
      repository: sl_auth(),
    ),
  );
  sl_auth.registerLazySingleton(
    () => RequestNewToken(
      repository: sl_auth(),
    ),
  );
  // Repos/Services
  sl_auth.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteService: sl_auth(),
      networkInfo: sl_auth(),
    ),
  );

  // Remote/Local Sources
  sl_auth.registerLazySingleton<AuthRemoteService>(
    () => AuthRemoteServiceImpl(
      secureStorage: sl_auth(),
      flutterAppAuth: sl_auth(),
      apiClient: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );

  // External
  sl_auth.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl_auth.registerLazySingleton<FlutterAppAuth>(
    () => FlutterAppAuth(),
  );
}
