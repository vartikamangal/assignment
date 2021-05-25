import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/hub/data/sources/create-traveller-remote-service.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/success-create-traveller.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/create-traveller-service.dart';

class CreateTravellerServiceImpl implements CreateTravellerService {
  final CreateTravellerRemoteService remoteService;
  final NetworkInfo networkInfo;

  CreateTravellerServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Success>> createTraveller() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteService.createTraveller();
        return const Right(SuccessCreatedTraveller());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(
        ServerFailure(),
      );
    }
  }
}
