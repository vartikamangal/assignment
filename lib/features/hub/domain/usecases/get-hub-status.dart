import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/get-hub-status-repository.dart';

class GetHubStatus implements Usecase<HubStatus, NoParams> {
  final GetHubStatusRepository repository;

  GetHubStatus({
    @required this.repository,
  });
  @override
  Future<Either<Failure, HubStatus>> call(NoParams params) async {
    return repository.getHubStatus();
  }
}
