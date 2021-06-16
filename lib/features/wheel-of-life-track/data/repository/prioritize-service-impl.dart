// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/life-areas-for-prioritization.dart';
import '../../domain/repositories/prioritize-service.dart';
import '../models/life-area-model-for-prioritization.dart';
import '../sources/prioritize-remote-service.dart';

class PrioritizeServiceImpl implements PrioritizeService {
  final PrioritizeRemoteService remoteService;
  final BaseRepository baseRepository;

  PrioritizeServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>> prioritize({
    @required LifeAreaForPrioritization lifeAreas,
  }) async {
    return baseRepository(
      () => remoteService.prioritize(
        lifeAreas: lifeAreas as LifeAreaModelForPrioritization,
      ),
    );
  }
}
