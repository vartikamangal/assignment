// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/mood-tracking-model.dart';

class TrackSubjectMood implements Usecase<Success, TrackSubjectMoodParams> {
  final RapportBuildingRepository service;

  TrackSubjectMood({required this.service});
  @override
  Future<Either<Failure, Success>?> call(TrackSubjectMoodParams params) async {
    return service.trackMood(mood: params.mood);
  }
}

class TrackSubjectMoodParams extends Equatable {
  final MoodTrackingModel mood;

  const TrackSubjectMoodParams({required this.mood});
  @override
  List<Object> get props => [mood];
}
