import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/profile-details-repository.dart';
import '../../../rapport-building/domain/entities/mood-tracking.dart';

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
