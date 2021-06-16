// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class CreateTravellerService {
  Future<Either<Failure, Success>> createTraveller();
}
