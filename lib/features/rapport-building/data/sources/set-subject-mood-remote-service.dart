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
import '../models/mood-tracking-model.dart';

abstract class SetSubjectMoodRemoteService {
  Future<MoodTrackingModel> setMood({
    @required String moodName,
    @required String activityType,
  });
}

class SetSubjectMoodRemoteServiceImpl implements SetSubjectMoodRemoteService {
  final http.Client client;

  const SetSubjectMoodRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<MoodTrackingModel> setMood({
    @required String moodName,
    @required String activityType,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.setMood),
      headers: header,
      body: jsonEncode({
        "mood": moodName,
        "activityType": activityType,
      }),
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final userMoodStatus = jsonDecode(response.body) as Map;
      return MoodTrackingModel.fromJson(userMoodStatus as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
