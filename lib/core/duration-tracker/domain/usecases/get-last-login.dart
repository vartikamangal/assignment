import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/app-duration.dart';
import '../repository/app-duration-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class GetLastLogin implements Usecase<AppDuration, NoParams> {
  final AppDurationRepository repository;

  GetLastLogin({
    @required this.repository,
  });
  @override
  Future<Either<Failure, AppDuration>> call(NoParams params) async {
    return repository.getLastLogin();
  }
}
