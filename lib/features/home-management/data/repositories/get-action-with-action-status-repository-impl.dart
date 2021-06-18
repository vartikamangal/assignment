import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/platform/network_info.dart';
import '../sources/get-action-with-action-status-remote-data-source.dart';
import '../../domain/entities/post-onboarding-action.dart';
import '../../domain/repositories/get-action-with-action-status-repository.dart';

class GetActionWithActionStatusRepositoryImpl
    implements GetActionWithActionStatusRepository {
  final GetActionWithActionStatusRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetActionWithActionStatusRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<PostOnboardingAction>>> getActions({
    String actionStatus,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final actions = await remoteDataSource.getAction(
          actionStatus: actionStatus,
        );
        return Right(
          actions,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }
}
