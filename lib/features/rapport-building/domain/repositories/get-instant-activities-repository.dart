import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/quick-action.dart';

abstract class GetInstantActivitiesRepository {
  Future<Either<Failure, List<QuickAction>>> getInstantActivities();
}
