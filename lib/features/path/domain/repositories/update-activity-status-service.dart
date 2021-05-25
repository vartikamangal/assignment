import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';

abstract class UpdateActivityStatusService {
  Future<Either<Failure, ActivityStatus>> updateStatus({
    @required String status,
    @required int actionId,
  });
}
