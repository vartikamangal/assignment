import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../entities/anonymous-user.dart';

abstract class CreateAnonymousUserService {
  Future<Either<Failure, AnonymousUser>> createAnonymousUser({
    @required String userName,
  });
}
