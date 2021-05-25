import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/mood.dart';

abstract class GetAllMoodsRepository {
  Future<Either<Failure, List<Mood>>> getAllMoods();
}
