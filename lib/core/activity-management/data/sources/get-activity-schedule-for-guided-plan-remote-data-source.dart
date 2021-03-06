// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/activity-scedule-guided-model.dart';

abstract class GetActivityScheduleForGuidedPlanRemoteDataSource {
  Future<ActivityScheduleGuidedModel> getSchedule();
}

class GetActivityScheduleForGuidedPlanRemoteDataSourceImpl
    implements GetActivityScheduleForGuidedPlanRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetActivityScheduleForGuidedPlanRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<ActivityScheduleGuidedModel> getSchedule() async {
    final response = await client.post(
      uri: APIRoute.getActivityScheduleForGuided,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawSchedule = jsonDecode(response.body) as Map;
    return ActivityScheduleGuidedModel.fromJson(
      rawSchedule as Map<String, dynamic>,
    );
  }
}
