// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/success-create-traveller.dart';
import '../../domain/repository/create-traveller-service.dart';
import '../sources/create-traveller-remote-service.dart';

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
