// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood-tracking.dart';

class SetSubjectMood implements Usecase<MoodTracking, SetSubjectMoodParams> {
  final RapportBuildingRepository service;

  SetSubjectMood({required this.service});
  @override
  Future<Either<Failure, MoodTracking>?> call(
      SetSubjectMoodParams params) async {
    return service.setSubjectMood(
      moodName: params.moodName,
      activityType: params.activityType,
    );
  }
}

class SetSubjectMoodParams extends Equatable {
  final String? moodName;
  final String activityType;

  const SetSubjectMoodParams({
    required this.moodName,
    required this.activityType,
  });

  @override
  List<Object?> get props => [moodName, activityType];
}
