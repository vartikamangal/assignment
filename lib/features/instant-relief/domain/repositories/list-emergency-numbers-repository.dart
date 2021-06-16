// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/emergency-number.dart';

abstract class ListEmergencyNumbersRepository {
  /// TODO if this one gives any exception used in app, Make sure to check the rmeote response once,
  /// coz. currently it is not a List instead a single contact instead. ///
  Future<Either<Failure, List<EmergencyNumber>>> fetchEmergencyNumbers();
}
