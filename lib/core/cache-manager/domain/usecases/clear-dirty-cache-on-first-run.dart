import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-clearing-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class ClearDirtyCacheOnFirstRun implements Usecase<Unit, NoParams> {
  final CacheClearingService service;

  ClearDirtyCacheOnFirstRun({@required this.service});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return service.clearDirtyCacheOnFirstRun();
  }
}
