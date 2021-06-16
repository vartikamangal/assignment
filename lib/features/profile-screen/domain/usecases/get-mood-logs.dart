import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';

class GetMoodLogs implements Usecase<List<MoodTracking>, NoParams> {
  final ProfileDetailsRepository repository;

  GetMoodLogs({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<MoodTracking>>> call(NoParams params) async {
    return repository.getMoodLogs();
  }
}
