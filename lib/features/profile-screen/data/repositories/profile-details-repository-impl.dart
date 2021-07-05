import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/repository/base-repository-impl.dart';
import '../../../hub/domain/entities/hub-status.dart';
import '../../../rapport-building/domain/entities/mood-tracking.dart';
import '../../domain/entities/profile-data.dart';
import '../../domain/entities/question-log.dart';
import '../../domain/repositories/profile-details-repository.dart';
import '../sources/profile-details-remote-data-source.dart';

class ProfileDetailsRepositoryImpl implements ProfileDetailsRepository {
  final ProfileDetailsRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;

  ProfileDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, ProfileData>?> getBasicProfileDetails() async {
    return baseRepository(
      () => remoteDataSource!.getBasicProfileDetails(),
    );
  }

  @override
  Future<Either<Failure, List<MoodTracking>>?> getMoodLogs() async {
    return baseRepository(
      () => remoteDataSource!.getMoodLogs(),
    );
  }

  @override
  Future<Either<Failure, List<QuestionLog>>?> getProfileQuestions() async {
    return baseRepository(
      () => remoteDataSource!.getProfileQuestions(),
    );
  }

  @override
  Future<Either<Failure, HubStatus>?> getProfileWheelOfLifeData() async {
    return baseRepository(
      () => remoteDataSource!.getProfileWheelOfLifeData(),
    );
  }
}
