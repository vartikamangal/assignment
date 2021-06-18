// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

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
