import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/anonymous-user.dart';
import '../repositories/create-anonymous-user-service.dart';

class CreateAnonymousUser
    extends Usecase<AnonymousUser, CreateAnonymousUserParams> {
  final CreateAnonymousUserService service;

  CreateAnonymousUser({@required this.service});
  @override
  Future<Either<Failure, AnonymousUser>> call(
      CreateAnonymousUserParams params) async {
    return service.createAnonymousUser(userName: params.userName);
  }
}

class CreateAnonymousUserParams extends Equatable {
  final String userName;

  const CreateAnonymousUserParams({@required this.userName});
  @override
  List<Object> get props => [userName];
}
