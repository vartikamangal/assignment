// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entites/journey.dart';
import '../../domain/repositories/get_journey_path_list_repository.dart';
import '../sources/get_journey_path_list_remote_data_source.dart';

class GetJourneyPathListRpositoryImpl implements GetJounreyPathListRepository {
  final GetJourneyPathListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetJourneyPathListRpositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Journey>>> getJourneyPaths() async {
    if (await networkInfo.isConnected) {
      try {
        final journeyList = await remoteDataSource.getJourneys();
        return Right(journeyList);
      } on AuthException {
        return const Left(
          AuthFailure(
            reason: 'You need to be logged in first',
            code: 'NA',
            smallMessage: 'No authentication header passed',
          ),
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
