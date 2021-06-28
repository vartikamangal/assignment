import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../entities/app-duration.dart';
import '../repository/app-duration-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class UpdateUserDurationOnApp
    implements Usecase<Unit, UpdateUserDurationOnAppParams> {
  final AppDurationRepository repository;

  UpdateUserDurationOnApp({
    @required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(
      UpdateUserDurationOnAppParams params) async {
    return repository.updateUserDurationOnApp(
      appDuration: params.userDurationOnApp,
      isNewUser: params.isNewUser,
    );
  }
}

class UpdateUserDurationOnAppParams extends Equatable {
  final AppDuration userDurationOnApp;
  final bool isNewUser;
  const UpdateUserDurationOnAppParams({
    @required this.userDurationOnApp,
    @required this.isNewUser,
  });

  @override
  List<Object> get props => [userDurationOnApp, isNewUser];

  @override
  bool get stringify => true;
}
