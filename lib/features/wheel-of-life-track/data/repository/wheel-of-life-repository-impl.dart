import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-area.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-areas-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-ratings.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';

class WheelOfLifeRepositoryImpl implements WheelOfLifeRepository {
  final BaseRepository baseRepository;
  final WheelOfLifeRemoteDataSource? remoteDataSource;

  WheelOfLifeRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<LifeArea>>?> getLifeAreas() async {
    return baseRepository(
      () => remoteDataSource!.getAreas(),
    );
  }

  @override
  Future<Either<Failure, RatingScale>?> getRatingScale() async {
    return baseRepository(
      () => remoteDataSource!.getRatingScale(),
    );
  }

  @override
  Future<Either<Failure, Success>?> prioritize({
    LifeAreaForPrioritization? lifeAreas,
  }) async {
    return baseRepository(
      () => remoteDataSource!.prioritize(
        lifeAreas: lifeAreas as LifeAreaModelForPrioritization?,
      ),
    );
  }

  @override
  Future<Either<Failure, Success>?> rateSatisfactionService({
    SatisfactionRatings? satisfactionRatings,
  }) async {
    return baseRepository(
      () => remoteDataSource!.rateSatisfaction(
        ratings: satisfactionRatings as SatisfactionRatingsModel?,
      ),
    );
  }
}
