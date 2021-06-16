// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/questionnaire.dart';
import '../repositories/get-questionnaire-by-id-repository.dart';

class GetQuestionnaireById
    implements Usecase<Questionnaire, GetQuestionnaireByIdParams> {
  final GetQuestionnaireByIdRepository repository;

  GetQuestionnaireById({
    @required this.repository,
  });
  @override
  Future<Either<Failure, Questionnaire>> call(
      GetQuestionnaireByIdParams params) async {
    return repository.getQuestionniare(
      id: params.id,
    );
  }
}

class GetQuestionnaireByIdParams extends Equatable {
  final String id;

  const GetQuestionnaireByIdParams({
    @required this.id,
  });
  @override
  List<Object> get props => [id];
}
