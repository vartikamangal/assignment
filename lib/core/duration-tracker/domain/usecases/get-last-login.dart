import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/repository/app-duration-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

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
