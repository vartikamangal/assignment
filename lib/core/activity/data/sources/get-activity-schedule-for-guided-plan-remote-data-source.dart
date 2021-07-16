// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';

import '../../../../core/routes/api-routes/api-routes.dart';
import '../models/activity-scedule-guided-model.dart';

abstract class GetActivityScheduleForGuidedPlanRemoteDataSource {
  Future<ActivityScheduleGuidedModel> getSchedule();
}

class GetActivityScheduleForGuidedPlanRemoteDataSourceImpl
    implements GetActivityScheduleForGuidedPlanRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  GetActivityScheduleForGuidedPlanRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<ActivityScheduleGuidedModel> getSchedule() async {
    final response = await client!.post(
      uri: APIRoute.getActivityScheduleForGuided,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    if (response.body.isNotEmpty) {
      final rawSchedule = jsonDecode(response.body) as Map;
      return ActivityScheduleGuidedModel.fromJson(
        rawSchedule as Map<String, dynamic>,
      );
    } else {
      log("<------- [ERROR] Empty Path Path ------>");
      throw ServerException();
    }
  }
}
