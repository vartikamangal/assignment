// Package imports:
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/repositories/questionnaire-repository-impl.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/questionnaire-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';

// Project imports:
import '../features/questionnaire-track/domain/usecases/attempt-questions.dart';
import '../features/questionnaire-track/domain/usecases/get-questionnaire-by-id.dart';
import '../features/questionnaire-track/presentation/controller/question-controller.dart';

final sl_questionnaire = GetIt.instance;

Future<void> initQuestionnaireDependencies() async {
  // Factories
  Get.lazyPut(
    () => QuestionnaireConroller(
      getQuestionnaireById: sl_questionnaire(),
      atemptQuestions: sl_questionnaire(),
    ),
  );

  // Usecases
  sl_questionnaire.registerLazySingleton(
    () => GetQuestionnaireById(
      repository: sl_questionnaire(),
    ),
  );
  sl_questionnaire.registerLazySingleton(
    () => AtemptQuestions(
      service: sl_questionnaire(),
    ),
  );
  // Services/Repos
  sl_questionnaire.registerLazySingleton<QuestionnaireRepository>(
    () => QuestionnaireRepositoryImpl(
      baseRepository: sl_core_dependencies(),
      remoteDataSource: sl_questionnaire(),
    ),
  );
  // Sources
  sl_questionnaire.registerLazySingleton<QuestionnaireRemoteDataSource>(
    () => QuestionnaireRemoteDataSourceImpl(
      client: sl_core_dependencies(),
      throwExceptionIfResponseError: sl_core_dependencies(),
    ),
  );
}
