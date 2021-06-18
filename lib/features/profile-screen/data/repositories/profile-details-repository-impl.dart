import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/generic-error-message.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
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
  final NetworkInfo networkInfo;

  ProfileDetailsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, ProfileData>> getBasicProfileDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getBasicProfileDetails();
        return Right(result);
      } on AuthException {
        return const Left(
          GenericErrorMessage.authFailure,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoodTracking>>> getMoodLogs() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMoodLogs();
        return Right(result);
      } on AuthException {
        return const Left(
          GenericErrorMessage.authFailure,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuestionLog>>> getProfileQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getProfileQuestions();
        return Right(result);
      } on AuthException {
        return const Left(
          GenericErrorMessage.authFailure,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, HubStatus>> getProfileWheelOfLifeData() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getProfileWheelOfLifeData();
        return Right(result);
      } on AuthException {
        return const Left(
          GenericErrorMessage.authFailure,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
