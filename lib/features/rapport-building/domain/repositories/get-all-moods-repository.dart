// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/mood.dart';

abstract class GetAllMoodsRepository {
  Future<Either<Failure, List<Mood>>> getAllMoods();
}
