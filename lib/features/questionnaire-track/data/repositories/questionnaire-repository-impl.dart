import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/questionnaire-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final BaseRepository baseRepository;
  final QuestionnaireRemoteDataSource? remoteDataSource;

  QuestionnaireRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, Success>?> attempQuestionnaire({
    Questionnaire? questionnaire,
    RxMap<Question, dynamic>? questionToAnswerMap,
    RxMap<Question, QuestionOption>? questionToScaleMap,
  }) async {
    return baseRepository(
      () => remoteDataSource!.attemptQuestionnaire(
        questionToAnswerMap: questionToAnswerMap,
        questionToScaleMap: questionToScaleMap,
        questionnaire: questionnaire,
      ),
    );
  }

  @override
  Future<Either<Failure, Questionnaire>?> getQuestionniare({String? id}) async {
    return baseRepository(
      () => remoteDataSource!.getQuestionnaireById(
        id: id,
      ),
    );
  }
}
