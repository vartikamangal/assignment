// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/emergency-number.dart';
import '../repositories/list-emergency-numbers-repository.dart';

class ListEmergencyNumbers implements Usecase<List<EmergencyNumber>, NoParams> {
  final ListEmergencyNumbersRepository repository;

  ListEmergencyNumbers({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<EmergencyNumber>>> call(NoParams params) async {
    return repository.fetchEmergencyNumbers();
  }
}
