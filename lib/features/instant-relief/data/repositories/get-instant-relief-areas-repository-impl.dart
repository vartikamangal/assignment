// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/instant-relief-area.dart';
import '../../domain/repositories/get-instant-relief-areas-repository.dart';
import '../sources/get-instant-relief-areas-remote-data-source.dart';

class GetInstantReliefAreasRepositoryImpl
    implements GetInstantReliefAreasRepository {
  final GetInstantReliefAreasRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetInstantReliefAreasRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<InstantReliefArea>>> getReliefAreas() async {
    return baseRepository(
      () => remoteDataSource.getReliefAreas(),
    );
  }

  @override
  Future<Either<Failure, List<ActivityRecommendation>>> getRecommendations({
    @required String instantLifeArea,
  }) async {
    return baseRepository(
      () => remoteDataSource.getRecommendations(
        instantLifeArea: instantLifeArea,
      ),
    );
  }
}
