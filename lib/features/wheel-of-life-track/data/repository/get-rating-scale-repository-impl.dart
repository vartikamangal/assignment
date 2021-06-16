// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/rating-scale.dart';
import '../../domain/repositories/get-rating-scale-repository.dart';
import '../sources/get-rating-scale-remote-data-source.dart';

class GetRatingScaleRepositoryImpl implements GetRatingScaleRepository {
  final GetRatingScaleRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetRatingScaleRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, RatingScale>> getRatingScale() async {
    return baseRepository(
      () => remoteDataSource.getRatingScale(),
    );
  }
}
