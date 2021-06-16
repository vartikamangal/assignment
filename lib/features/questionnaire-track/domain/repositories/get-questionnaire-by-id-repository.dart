// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/questionnaire.dart';

abstract class GetQuestionnaireByIdRepository {
  Future<Either<Failure, Questionnaire>> getQuestionniare({
    @required String id,
  });
}
