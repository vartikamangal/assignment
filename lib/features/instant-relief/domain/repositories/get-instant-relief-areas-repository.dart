import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/instant-relief-area.dart';

abstract class GetInstantReliefAreasRepository {
  Future<Either<Failure, List<InstantReliefArea>>> getReliefAreas();
}
