import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/repositories/set-user-feeling-service.dart';
import '../sources/set-subject-feeling-local-service.dart';

class SetSubjectFeelingServiceImpl implements SetSubjectFeelingService {
  final SetSubjectFeelingLocalService localService;

  const SetSubjectFeelingServiceImpl({@required this.localService});
  @override
  Future<Either<Failure, Success>> setSubjectFeeling(String feeling) async {
    try {
      final setFeelingStatus = await localService.setFeeling(feeling: feeling);
      return Right(setFeelingStatus);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
