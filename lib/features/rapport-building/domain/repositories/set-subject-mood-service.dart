import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/mood-tracking.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class SetSubjectMoodService {
  Future<Either<Failure, MoodTracking>> setSubjectMood({
    @required String moodName,
    @required String activityType,
  });
}
