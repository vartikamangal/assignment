import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../../data/models/mood-tracking-model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/mood-tracking.dart';

abstract class TrackSubjectMoodService {
  Future<Either<Failure, Success>> trackMood(
      {@required MoodTrackingModel mood});
}
