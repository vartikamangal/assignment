// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/life-area.dart';

abstract class GetLifeAreasRepository {
  Future<Either<Failure, List<LifeArea>>> getLifeAreas();
}
