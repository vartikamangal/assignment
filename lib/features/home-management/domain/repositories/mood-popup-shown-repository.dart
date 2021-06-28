import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class MoodPopupShownRepository {
  Future<Either<Failure, bool>> getMoodPopupShownStatus();
  Future<Either<Failure, Unit>> toogleIsMoodPopupShownState();
}
