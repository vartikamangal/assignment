// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../data/models/mood-tracking-model.dart';
import '../entities/mood-tracking.dart';

abstract class TrackSubjectMoodService {
  Future<Either<Failure, Success>> trackMood(
      {@required MoodTrackingModel mood});
}
