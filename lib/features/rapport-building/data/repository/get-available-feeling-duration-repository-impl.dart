// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/feeling-duration.dart';
import '../../domain/repositories/get-available-feeling-duration-repository.dart';
import '../sources/get-available-feeling-duration-remote-data-source.dart';

class GetAvailableFeelingDurationRepositoryImpl
    implements GetAvailableFeelingDurationRepository {
  final GetAvailableFeelingDurationRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetAvailableFeelingDurationRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<FeelingDuration>>> getAvailableDurations() async {
    return baseRepository(
      () => remoteDataSource.getAvailableDurations(),
    );
  }
}
