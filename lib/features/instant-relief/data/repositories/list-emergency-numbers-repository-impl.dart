import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/emergency-number.dart';
import '../../domain/repositories/list-emergency-numbers-repository.dart';
import '../sources/list-emergency-numbers-remote-service.dart';

class ListEmergencyNumbersRepositoryImpl
    implements ListEmergencyNumbersRepository {
  final ListEmergencyNumberRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ListEmergencyNumbersRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<EmergencyNumber>>> fetchEmergencyNumbers() async {
    if (await networkInfo.isConnected) {
      try {
        final emergencyNumbers = await remoteDataSource.fetchEmergencyNumbers();
        return Right(emergencyNumbers);
      } on ServerException {
        return Left(DeviceOfflineFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
