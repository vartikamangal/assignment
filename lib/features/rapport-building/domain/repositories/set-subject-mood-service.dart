// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/mood-tracking.dart';

abstract class SetSubjectMoodService {
  Future<Either<Failure, MoodTracking>> setSubjectMood({
    @required String moodName,
    @required String activityType,
  });
}
