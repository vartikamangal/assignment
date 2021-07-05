// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-user-path-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RetrieveUserPath implements Usecase<String, NoParams> {
  final RetrieveUserPathRepository repository;

  RetrieveUserPath({
    required this.repository,
  });
  @override
  Future<Either<Failure, String>?> call(NoParams params) async {
    return repository.retrievePath();
  }
}
