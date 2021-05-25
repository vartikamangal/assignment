import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/quick-action.dart';
import '../repositories/get-instant-activities-repository.dart';

class GetInstantActivities implements Usecase<List<QuickAction>, NoParams> {
  final GetInstantActivitiesRepository repository;

  GetInstantActivities({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<QuickAction>>> call(NoParams params) async {
    return repository.getInstantActivities();
  }
}
