import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/path-operations-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/path-operations-repository.dart';

class PathOperationsRepositoryImpl implements PathOperationsRepository {
  final BaseRepository baseRepository;
  final PathOperationsRemoteDataSource? remoteDataSource;

  PathOperationsRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Journey>>?> getJourneyPaths() async {
    return baseRepository(
      () => remoteDataSource!.getJourneys(),
    );
  }

  @override
  Future<Either<Failure, Success>?> startJourney({Journey? journey}) async {
    return baseRepository(
      () => remoteDataSource!.startJourney(
        journey: journey as JourneyModel?,
      ),
    );
  }
}
