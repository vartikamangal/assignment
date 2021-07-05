import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/mood-popup-shown-repository.dart';

class ToggleMoodPopupShownState implements Usecase<Unit, NoParams> {
  final MoodPopupShownRepository repository;

  ToggleMoodPopupShownState({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.toogleIsMoodPopupShownState();
  }
}
