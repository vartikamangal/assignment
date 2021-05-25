import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/mood-tracking-model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood-tracking.dart';
import '../repositories/track-subject-mood-service.dart';

class TrackSubjectMood implements Usecase<Success, TrackSubjectMoodParams> {
  final TrackSubjectMoodService service;

  TrackSubjectMood({@required this.service});
  @override
  Future<Either<Failure, Success>> call(TrackSubjectMoodParams params) async {
    return service.trackMood(mood: params.mood);
  }
}

class TrackSubjectMoodParams extends Equatable {
  final MoodTrackingModel mood;

  const TrackSubjectMoodParams({@required this.mood});
  @override
  List<Object> get props => [mood];
}
