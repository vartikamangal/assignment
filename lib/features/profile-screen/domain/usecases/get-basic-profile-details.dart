import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile-data.dart';
import '../repositories/profile-details-repository.dart';

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
