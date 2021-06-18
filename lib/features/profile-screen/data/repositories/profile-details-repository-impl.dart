import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/sources/profile-details-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';

class ProfileDetailsRepositoryImpl implements ProfileDetailsRepository {
  final ProfileDetailsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  ProfileDetailsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, ProfileData>> getBasicProfileDetails() async {
    return baseRepository(
      () => remoteDataSource.getBasicProfileDetails(),
    );
  }

  @override
  Future<Either<Failure, List<MoodTracking>>> getMoodLogs() async {
    return baseRepository(
      () => remoteDataSource.getMoodLogs(),
    );
  }

  @override
  Future<Either<Failure, List<QuestionLog>>> getProfileQuestions() async {
    return baseRepository(
      () => remoteDataSource.getProfileQuestions(),
    );
  }

  @override
  Future<Either<Failure, HubStatus>> getProfileWheelOfLifeData() async {
    return baseRepository(
      () => remoteDataSource.getProfileWheelOfLifeData(),
    );
  }
}
