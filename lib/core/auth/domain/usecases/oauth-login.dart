import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/oauth-data.dart';
import '../repositories/auth-repository.dart';

class OauthLogin implements Usecase<OAuthData, NoParams> {
  final AuthRepository repository;

  OauthLogin({
    required this.repository,
  });
  @override
  Future<Either<Failure, OAuthData>> call(NoParams params) async {
    return repository.oauthLogin();
  }
}
