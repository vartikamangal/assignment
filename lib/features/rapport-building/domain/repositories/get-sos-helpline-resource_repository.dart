import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sos-resource.dart';

abstract class GetSOSResourceReporsitory {
  Future<Either<Failure, SoSResource>> getSosResource();
}
