import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/mood-popup-shown-repository.dart';

class GetIsMoodPopupShownStatus implements Usecase<bool?, NoParams> {
  final MoodPopupShownRepository repository;

  GetIsMoodPopupShownStatus({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool?>> call(NoParams params) async {
    return repository.getMoodPopupShownStatus();
  }
}
