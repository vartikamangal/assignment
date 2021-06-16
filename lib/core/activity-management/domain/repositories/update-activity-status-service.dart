// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/activity-status.dart';

abstract class UpdateActivityStatusService {
  Future<Either<Failure, ActivityStatus>> updateStatus({
    @required String status,
    @required int actionId,
  });
}
