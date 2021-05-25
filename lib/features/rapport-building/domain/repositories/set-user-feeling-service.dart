import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class SetSubjectFeelingService {
  Future<Either<Failure, Success>> setSubjectFeeling(String feeling);
}
