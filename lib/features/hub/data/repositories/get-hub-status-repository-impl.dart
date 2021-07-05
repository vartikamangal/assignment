// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/hub-status.dart';
import '../../domain/repository/get-hub-status-repository.dart';
import '../sources/get-hub-status-remote-data-source.dart';

class GetHubStatusRepositoryImpl implements GetHubStatusRepository {
  final GetHubStatusRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;

  GetHubStatusRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, HubStatus>?> getHubStatus() async {
    return baseRepository(
      () => remoteDataSource!.getHubStatus(),
    );
  }
}
