import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/app-duration.dart';
import '../repository/app-duration-repository.dart';

class GetLastLogin implements Usecase<AppDuration, NoParams> {
  final AppDurationRepository repository;

  GetLastLogin({
    required this.repository,
  });
  @override
  Future<Either<Failure, AppDuration>> call(NoParams params) async {
    return repository.getLastLogin();
  }
}
