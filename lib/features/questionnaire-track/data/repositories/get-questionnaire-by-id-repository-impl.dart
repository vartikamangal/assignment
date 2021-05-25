import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/get-questionnaire-by-id-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/get-questionnaire-by-id-repository.dart';

class GetQuestionnaireByIdRepositoryImpl
    implements GetQuestionnaireByIdRepository {
  final NetworkInfo networkInfo;
  final GetQuestionnaireByIdRemoteDataSource remoteDataSource;

  GetQuestionnaireByIdRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, Questionnaire>> getQuestionniare({
    String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final questionnaire = await remoteDataSource.getQuestionnaireById(
          id: id,
        );
        return Right(questionnaire);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
