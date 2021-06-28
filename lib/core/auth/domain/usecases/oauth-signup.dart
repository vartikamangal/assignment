import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/oauth-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class OAuthSignup implements Usecase<OAuthData, NoParams> {
  final AuthRepository repository;

  OAuthSignup({@required this.repository});
  @override
  Future<Either<Failure, OAuthData>> call(NoParams params) async {
    return repository.oauthSignup();
  }
}
