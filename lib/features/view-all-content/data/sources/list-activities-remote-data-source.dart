import 'dart:convert';
import 'dart:developer';

import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/page-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';

abstract class ListActivitiesRemoteDataSource {
  Future<PageModel<ActivityModel, Activity>> listActivities(
      {required PageRequest pageRequest});
}

class ListActivitiesRemoteDataSourceImpl
    implements ListActivitiesRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  const ListActivitiesRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<PageModel<ActivityModel, Activity>> listActivities({
    required PageRequest pageRequest,
  }) async {
    final _uri =
        "${APIRoute.getRecommendationById}${"?page=${pageRequest.pageNumber}&size=${pageRequest.pageSize}"}";
    final response = await client.get(uri: _uri);
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    log(jsonMap.toString());
    return PageModel.fromJson(
      jsonMap,
      (e) => ActivityModel.fromJson(e),
    );
  }
}
