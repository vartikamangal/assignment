import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';

class GetProfileWheelOfLifeData implements Usecase<HubStatus, NoParams> {
  final ProfileDetailsRepository repository;

  GetProfileWheelOfLifeData({
    @required this.repository,
  });
  @override
  Future<Either<Failure, HubStatus>> call(NoParams params) async {
    return repository.getProfileWheelOfLifeData();
  }
}
