import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';

abstract class AppPageStatusRepository {
  /// Responsible for fetching the [AppRoute] where
  /// user left the app during onboarding
  Future<Either<Failure, AppRoute>> getLastAbandonedPage({
    @required HubStatusModel hubStatusModel,
  });
}
