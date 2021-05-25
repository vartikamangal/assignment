import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/get-questionnaire-by-id-repository.dart';

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
