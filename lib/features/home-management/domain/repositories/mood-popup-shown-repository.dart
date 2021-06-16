import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class MoodPopupShownRepository {
  Future<Either<Failure, bool>> getMoodPopupShownStatus();
  Future<Either<Failure, Unit>> toogleIsMoodPopupShownState();
}
