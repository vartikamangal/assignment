// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entites/journey.dart';
import '../../domain/repositories/get_journey_path_list_repository.dart';
import '../sources/get_journey_path_list_remote_data_source.dart';

class GetJourneyPathListRpositoryImpl implements GetJounreyPathListRepository {
  final GetJourneyPathListRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetJourneyPathListRpositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<Journey>>> getJourneyPaths() async {
    return baseRepository(
      () => remoteDataSource.getJourneys(),
    );
  }
}
