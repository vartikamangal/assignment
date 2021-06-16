import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/user-data.dart';
import '../repositories/auth-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class GetUserDetails implements Usecase<UserData, NoParams> {
  final AuthRepository authRepository;

  GetUserDetails({
    @required this.authRepository,
  });
  @override
  Future<Either<Failure, UserData>> call(NoParams params) async {
    return authRepository.getUserDetails();
  }
}
