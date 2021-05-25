import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/subject-information.dart';
import '../../domain/repositories/set-subject-name-service.dart';
import '../sources/set-subject-name-remote-service.dart';

class SetSubjectNameServiceImpl implements SetSubjectNameService {
  final SetSubjectNameRemoteService service;
  final NetworkInfo networkInfo;

  SetSubjectNameServiceImpl({
    @required this.service,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SubjectInformation>> setSubjectName({
    String subjectName,
    String deviceId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final serviceResult = await service.setSubjectName(name: subjectName);
        return Right(serviceResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
