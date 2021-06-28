import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../hub/domain/entities/hub-status.dart';
import '../repositories/profile-details-repository.dart';

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
