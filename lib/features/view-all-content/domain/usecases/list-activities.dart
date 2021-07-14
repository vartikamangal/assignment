import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page.dart';

import '../repository/list-activities-repository.dart';

class ListAllActivities
    implements Usecase<Page<Activity>, ListAllActivitiesParams> {
  final ListActivitiesRepository repository;

  ListAllActivities({required this.repository});
  @override
  Future<Either<Failure, Page<Activity>>?> call(
      ListAllActivitiesParams params) async {
    return repository.getAllRecommendations(pageRequest: params.pageRequest);
  }
}

class ListAllActivitiesParams extends Equatable {
  final PageRequest pageRequest;
  const ListAllActivitiesParams(this.pageRequest);
  @override
  List<Object> get props => [pageRequest];
}
