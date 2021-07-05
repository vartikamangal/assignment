import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/repository/app-page-status-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';

class GetLastAbandonedPage
    implements Usecase<AppRoute, GetLastAbandonedPageParams> {
  final AppPageStatusRepository repository;

  GetLastAbandonedPage({required this.repository});
  @override
  Future<Either<Failure, AppRoute>> call(
      GetLastAbandonedPageParams params) async {
    return repository.getLastAbandonedPage(
      hubStatusModel: params.hubStatusModel,
    );
  }
}

class GetLastAbandonedPageParams extends Equatable {
  final HubStatusModel hubStatusModel;

  const GetLastAbandonedPageParams({required this.hubStatusModel});
  @override
  List<Object?> get props => [hubStatusModel];
}
