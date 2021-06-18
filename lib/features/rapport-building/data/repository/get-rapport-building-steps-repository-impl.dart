// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/mood.dart';
import '../../domain/entities/rapport-building-steps.dart';
import '../../domain/repositories/get-rapport-building-steps-repository.dart';
import '../models/mood-model.dart';
import '../sources/get-rapport-building-steps-remote-data-source.dart';

class GetRapportBuildingStepsRepositoryImpl
    implements GetRapportBuildingStepsRepository {
  final GetRapportBuildingStepsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetRapportBuildingStepsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, RapportBuildingSteps>> getRapportBuildingSteps({
    @required Mood mood,
  }) async {
    return baseRepository(
      () => remoteDataSource.getRapportBuildingSteps(mood: mood as MoodModel),
    );
  }
}
