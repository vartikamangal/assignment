// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/hub-status.dart';

abstract class GetHubStatusRepository {
  Future<Either<Failure, HubStatus>?> getHubStatus();
}
