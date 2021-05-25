import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

abstract class CreateTravellerService {
  Future<Either<Failure, Success>> createTraveller();
}
