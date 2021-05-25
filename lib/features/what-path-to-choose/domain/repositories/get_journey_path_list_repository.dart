import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entites/journey.dart';

abstract class GetJounreyPathListRepository {
  Future<Either<Failure, List<Journey>>> getJourneyPaths();
}
