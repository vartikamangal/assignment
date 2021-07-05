// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/questionnaire.dart';

class GetQuestionnaireById
    implements Usecase<Questionnaire, GetQuestionnaireByIdParams> {
  final QuestionnaireRepository repository;

  GetQuestionnaireById({
    required this.repository,
  });
  @override
  Future<Either<Failure, Questionnaire>?> call(
      GetQuestionnaireByIdParams params) async {
    return repository.getQuestionniare(
      id: params.id,
    );
  }
}

class GetQuestionnaireByIdParams extends Equatable {
  final String id;

  const GetQuestionnaireByIdParams({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}
