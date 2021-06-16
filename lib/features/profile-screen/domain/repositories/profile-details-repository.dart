import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';

abstract class ProfileDetailsRepository {
  /// supposed to provide [ProfileData] with basic user homepage details
  Future<Either<Failure, ProfileData>> getBasicProfileDetails();

  /// supposed to provide [HubStatus] for pie chart construction
  Future<Either<Failure, HubStatus>> getProfileWheelOfLifeData();

  /// supposed to provide List of [MoodTracking] for linear chart construction
  Future<Either<Failure, List<MoodTracking>>> getMoodLogs();

  /// supposed to provide List of [QuestionLog] for questionnaire-home-screen
  Future<Either<Failure, List<QuestionLog>>> getProfileQuestions();
}
