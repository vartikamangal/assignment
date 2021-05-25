import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';

abstract class GetHubStatusRepository {
  Future<Either<Failure, HubStatus>> getHubStatus();
}
