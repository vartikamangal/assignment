import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../entities/mood-tracking.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/set-subject-mood-service.dart';

class SetSubjectMood implements Usecase<MoodTracking, SetSubjectMoodParams> {
  final SetSubjectMoodService service;

  SetSubjectMood({@required this.service});
  @override
  Future<Either<Failure, MoodTracking>> call(
      SetSubjectMoodParams params) async {
    return service.setSubjectMood(
      moodName: params.moodName,
      activityType: params.activityType,
    );
  }
}

class SetSubjectMoodParams extends Equatable {
  final String moodName;
  final String activityType;

  const SetSubjectMoodParams({
    @required this.moodName,
    @required this.activityType,
  });

  @override
  List<Object> get props => [moodName, activityType];
}
