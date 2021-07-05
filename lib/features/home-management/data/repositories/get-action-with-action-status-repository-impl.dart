import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/repository/base-repository-impl.dart';
import '../../domain/entities/post-onboarding-action.dart';
import '../../domain/repositories/get-action-with-action-status-repository.dart';
import '../sources/get-action-with-action-status-remote-data-source.dart';

class GetActionWithActionStatusRepositoryImpl
    implements GetActionWithActionStatusRepository {
  final GetActionWithActionStatusRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;
  GetActionWithActionStatusRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<PostOnboardingAction>>?> getActions({
    String? actionStatus,
  }) async {
    return baseRepository(
      () => remoteDataSource!.getAction(
        actionStatus: actionStatus,
      ),
    );
  }
}
