import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/repositories/attempth-questionnaire-service-impl.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/repositories/get-questionnaire-by-id-repository-impl.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/attempt-questionnaire-remote-service.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/get-questionnaire-by-id-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/attempt-questionnaire-service.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/get-questionnaire-by-id-repository.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/attempt-questions.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/get-questionnaire-by-id.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/presentation/controller/question-controller.dart';

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
  sl_questionnaire.registerLazySingleton<GetQuestionnaireByIdRepository>(
    () => GetQuestionnaireByIdRepositoryImpl(
      networkInfo: sl_questionnaire(),
      remoteDataSource: sl_questionnaire(),
    ),
  );
  sl_questionnaire.registerLazySingleton<AtemptQuestionnaireService>(
    () => AttemptQuestionnaireServiceImpl(
      remoteService: sl_questionnaire(),
      networkInfo: sl_questionnaire(),
    ),
  );
  // Sources
  sl_questionnaire.registerLazySingleton<GetQuestionnaireByIdRemoteDataSource>(
    () => GetQuestionnaireByIdRemoteDataSourceImpl(
      client: sl_questionnaire(),
    ),
  );
  sl_questionnaire.registerLazySingleton<AttemptQuestionnaireRemoteService>(
    () => AttemptQuestionnaireRemoteServiceImpl(
      client: sl_questionnaire(),
    ),
  );
}
