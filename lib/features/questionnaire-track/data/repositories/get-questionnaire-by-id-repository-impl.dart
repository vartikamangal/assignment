// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/questionnaire.dart';
import '../../domain/repositories/get-questionnaire-by-id-repository.dart';
import '../sources/get-questionnaire-by-id-remote-data-source.dart';

class GetQuestionnaireByIdRepositoryImpl
    implements GetQuestionnaireByIdRepository {
  final GetQuestionnaireByIdRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetQuestionnaireByIdRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Questionnaire>> getQuestionniare({
    String id,
  }) async {
    return baseRepository(
      () => remoteDataSource.getQuestionnaireById(
        id: id,
      ),
    );
  }
}
