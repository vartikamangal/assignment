// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/emergency-number.dart';

class ListEmergencyNumbers implements Usecase<List<EmergencyNumber>, NoParams> {
  final InstantReliefRepository repository;

  ListEmergencyNumbers({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<EmergencyNumber>>?> call(NoParams params) async {
    return repository.fetchEmergencyNumbers();
  }
}
