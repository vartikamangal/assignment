import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../entities/post-onboarding-action.dart';

abstract class GetActionWithActionStatusRepository {
  Future<Either<Failure, List<PostOnboardingAction>>> getActions({
    @required String actionStatus,
  });
}
