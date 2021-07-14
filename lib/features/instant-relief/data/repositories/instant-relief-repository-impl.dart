import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/emergency-number.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';

class InstantReliefRepositoryImpl implements InstantReliefRepository {
  final BaseRepository baseRepository;
  final InstantReliefRemoteDataSource? remoteDataSource;

  InstantReliefRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<EmergencyNumber>>?>
      fetchEmergencyNumbers() async {
    return baseRepository(
      () => remoteDataSource!.fetchEmergencyNumbers(),
    );
  }

  @override
  Future<Either<Failure, List<Activity>>?> getRecommendations({
    String? instantLifeArea,
  }) async {
    return baseRepository(
      () => remoteDataSource!
          .getRecommendations(
            instantLifeArea: instantLifeArea,
          )
          .then((listOfActivityModel) => listOfActivityModel
              .map((activityModel) => activityModel.toDomain())
              .toList()),
    );
  }

  @override
  Future<Either<Failure, List<InstantReliefArea>>?> getReliefAreas() async {
    return baseRepository(
      () => remoteDataSource!.getReliefAreas(),
    );
  }
}
