import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../models/satisfaction-ratings-model.dart';
import '../sources/rate-satisfaction-remote-service.dart';
import '../../domain/entities/satisfaction-ratings.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/rate-satisfaction-service.dart';

class RateSatisfactionServiceImpl implements RateSatisfactionService {
  final NetworkInfo networkInfo;
  final RateSatisfactionRemoteService remoteService;

  RateSatisfactionServiceImpl({
    @required this.networkInfo,
    @required this.remoteService,
  });
  @override
  Future<Either<Failure, Success>> rateSatisfactionService({
    @required SatisfactionRatings satisfactionRatings,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final satisfactionRatedStatus = await remoteService.rateSatisfaction(
          ratings: satisfactionRatings as SatisfactionRatingsModel,
        );
        return Right(satisfactionRatedStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
