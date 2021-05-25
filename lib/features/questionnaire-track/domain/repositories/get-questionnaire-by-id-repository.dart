import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';

abstract class GetQuestionnaireByIdRepository {
  Future<Either<Failure, Questionnaire>> getQuestionniare({
    @required String id,
  });
}
