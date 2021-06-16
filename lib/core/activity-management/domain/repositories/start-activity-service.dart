// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/activity-status.dart';

abstract class StartActivityService {
  Future<Either<Failure, ActivityStatus>> startActivity({
    @required String recommendationId,
    @required bool isInstantActivity,
  });
}
