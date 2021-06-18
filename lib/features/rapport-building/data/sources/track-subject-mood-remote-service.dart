// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/entities/track-mood-success.dart';
import '../models/mood-tracking-model.dart';

abstract class TrackSubjectMoodRemoteService {
  Future<TrackMoodSuccess> trackMood({
    @required MoodTracking mood,
  });
}

class TrackSubjectMoodRemoteServiceImpl
    implements TrackSubjectMoodRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  TrackSubjectMoodRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<TrackMoodSuccess> trackMood({@required MoodTracking mood}) async {
    final response = await client.post(
      uri: APIRoute.setMoodDuration,
      body: jsonEncode(
        (mood as MoodTrackingModel).toJson(),
      ),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return TrackMoodSuccess();
  }
}
