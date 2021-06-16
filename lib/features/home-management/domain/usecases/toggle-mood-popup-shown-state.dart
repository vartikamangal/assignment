import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/mood-popup-shown-repository.dart';

class ToggleMoodPopupShownState implements Usecase<Unit, NoParams> {
  final MoodPopupShownRepository repository;

  ToggleMoodPopupShownState({
    @required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.toogleIsMoodPopupShownState();
  }
}
