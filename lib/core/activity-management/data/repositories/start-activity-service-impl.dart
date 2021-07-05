// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/activity-status.dart';
import '../../domain/repositories/start-activity-service.dart';
import '../sources/start-activity-remote-service.dart';

class StartActivityServiceImpl implements StartActivityService {
  final StartActivityRemoteService? remoteService;
  final BaseRepository baseRepository;

  StartActivityServiceImpl({
    required this.remoteService,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, ActivityStatus>?> startActivity({
    String? recommendationId,
    bool? isInstantActivity,
  }) async {
    return baseRepository(
      () => remoteService!.startActivity(
        recommendationId: recommendationId,
        isInstantActivity: isInstantActivity,
      ),
    );
  }
}
