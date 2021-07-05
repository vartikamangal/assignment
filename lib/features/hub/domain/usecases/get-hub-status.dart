// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/hub-status.dart';
import '../repository/get-hub-status-repository.dart';

class GetHubStatus implements Usecase<HubStatus, NoParams> {
  final GetHubStatusRepository repository;

  GetHubStatus({
    required this.repository,
  });
  @override
  Future<Either<Failure, HubStatus>?> call(NoParams params) async {
    return repository.getHubStatus();
  }
}
