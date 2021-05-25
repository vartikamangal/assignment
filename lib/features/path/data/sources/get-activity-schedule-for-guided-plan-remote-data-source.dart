import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';
import 'package:tatsam_app_experimental/features/path/data/models/activity-scedule-guided-model.dart';
import 'package:http/http.dart' as http;

abstract class GetActivityScheduleForGuidedPlanRemoteDataSource {
  Future<ActivityScheduleGuidedModel> getSchedule();
}

class GetActivityScheduleForGuidedPlanRemoteDataSourceImpl
    implements GetActivityScheduleForGuidedPlanRemoteDataSource {
  final http.Client client;

  GetActivityScheduleForGuidedPlanRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<ActivityScheduleGuidedModel> getSchedule() async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(
        APIRoute.getActivityScheduleForGuided,
      ),
      headers: header,
    );
    await SessionManager.setHeader(header: response.headers);
    final rawSchedule = jsonDecode(response.body) as Map;
    if (response.statusCode == 200) {
      return ActivityScheduleGuidedModel.fromJson(
        rawSchedule as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
