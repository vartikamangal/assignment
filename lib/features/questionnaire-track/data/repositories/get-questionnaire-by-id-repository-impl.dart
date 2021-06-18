// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/questionnaire.dart';
import '../../domain/repositories/get-questionnaire-by-id-repository.dart';
import '../sources/get-questionnaire-by-id-remote-data-source.dart';

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
