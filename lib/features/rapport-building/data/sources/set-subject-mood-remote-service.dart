// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/routes/api-routes/api-routes.dart';
import '../models/mood-tracking-model.dart';

abstract class SetSubjectMoodRemoteService {
  Future<MoodTrackingModel> setMood({
    @required String moodName,
    @required String activityType,
  });
}

class SetSubjectMoodRemoteServiceImpl implements SetSubjectMoodRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  const SetSubjectMoodRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<MoodTrackingModel> setMood({
    @required String moodName,
    @required String activityType,
  }) async {
    final response = await client.post(
      uri: APIRoute.setMood,
      body: jsonEncode({
        "mood": moodName,
        "activityType": activityType,
      }),
    );
    log(response.body);
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final userMoodStatus = jsonDecode(response.body) as Map;
    return MoodTrackingModel.fromJson(userMoodStatus as Map<String, dynamic>);
  }
}
