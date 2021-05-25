import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../models/mood-model.dart';
import '../sources/get-rapport-building-steps-remote-data-source.dart';
import '../../domain/entities/mood.dart';
import '../../domain/entities/rapport-building-steps.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/get-rapport-building-steps-repository.dart';

class GetRapportBuildingStepsRepositoryImpl
    implements GetRapportBuildingStepsRepository {
  final GetRapportBuildingStepsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetRapportBuildingStepsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, RapportBuildingSteps>> getRapportBuildingSteps({
    @required Mood mood,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final rapportBuildingSteps =
            await remoteDataSource.getRapportBuildingSteps(
          mood: mood as MoodModel,
        );
        return Right(rapportBuildingSteps);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
