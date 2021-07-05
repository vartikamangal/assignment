import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling-duration.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-building-steps.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

class RapportBuildingRepositoryImpl implements RapportBuildingRepository {
  final BaseRepository baseRepository;
  final RapportBuildingRemoteDataSource? remoteDataSource;
  RapportBuildingRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Mood>>?> getAllMoods() async {
    return baseRepository(() => remoteDataSource!.getMoods());
  }

  @override
  Future<Either<Failure, List<FeelingDuration>>?>
      getAvailableDurations() async {
    return baseRepository(() => remoteDataSource!.getAvailableDurations());
  }

  @override
  Future<Either<Failure, RapportBuildingSteps>?> getRapportBuildingSteps(
      {Mood? mood}) async {
    return baseRepository(
      () => remoteDataSource!.getRapportBuildingSteps(mood: mood as MoodModel?),
    );
  }

  @override
  Future<Either<Failure, MoodTracking>?> setSubjectMood(
      {String? moodName, String? activityType}) async {
    return baseRepository(
      () => remoteDataSource!.setMood(
        moodName: moodName,
        activityType: activityType,
      ),
    );
  }

  @override
  Future<Either<Failure, SubjectInformation>?> setSubjectName(
      {String? subjectName}) async {
    return baseRepository(
      () => remoteDataSource!.setSubjectName(name: subjectName),
    );
  }

  @override
  Future<Either<Failure, Success>?> trackMood({MoodTrackingModel? mood}) async {
    return baseRepository(() => remoteDataSource!.trackMood(mood: mood));
  }
}
