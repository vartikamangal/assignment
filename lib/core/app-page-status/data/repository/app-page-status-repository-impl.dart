import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/sources/app-page-status-local-data-source.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/repository/app-page-status-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';

const appFallbackRoute = AppRouteModel(name: RouteName.origin);

class AppPageStatusRepositoryImpl implements AppPageStatusRepository {
  final AppPageStatusLocalDataSource? localDataSource;

  AppPageStatusRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, AppRoute>> getLastAbandonedPage({
    required HubStatusModel? hubStatusModel,
  }) async {
    try {
      final result = await localDataSource!.getLastAbandonedPage(
        hubStatusModel: hubStatusModel,
      );
      return Right(result);
    } on AbandonedPageNotFoundException {
      return const Left(
        AbandonedPageNotFoundFailure(fallbackRoute: appFallbackRoute),
      );
    }
  }
}
