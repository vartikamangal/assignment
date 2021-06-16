import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';

class GetBasicProfileDetails implements Usecase<ProfileData, NoParams> {
  final ProfileDetailsRepository repository;

  GetBasicProfileDetails({
    @required this.repository,
  });
  @override
  Future<Either<Failure, ProfileData>> call(NoParams params) async {
    return repository.getBasicProfileDetails();
  }
}
