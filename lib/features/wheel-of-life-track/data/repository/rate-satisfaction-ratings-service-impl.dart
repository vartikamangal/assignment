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
import '../../domain/entities/satisfaction-ratings.dart';
import '../../domain/repositories/rate-satisfaction-service.dart';
import '../models/satisfaction-ratings-model.dart';
import '../sources/rate-satisfaction-remote-service.dart';

class RateSatisfactionServiceImpl implements RateSatisfactionService {
  final RateSatisfactionRemoteService remoteService;
  final BaseRepository baseRepository;

  RateSatisfactionServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>> rateSatisfactionService({
    @required SatisfactionRatings satisfactionRatings,
  }) async {
    return baseRepository(
      () => remoteService.rateSatisfaction(
        ratings: satisfactionRatings as SatisfactionRatingsModel,
      ),
    );
  }
}
