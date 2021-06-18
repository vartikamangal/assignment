// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
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
  final http.Client client;
  final Box sessionClient;

  TrackSubjectMoodRemoteServiceImpl({
    @required this.client,
    @required this.sessionClient,
  });
  @override
  Future<TrackMoodSuccess> trackMood({@required MoodTracking mood}) async {
    final headers = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.setMoodDuration),
      headers: headers,
      body: jsonEncode(
        (mood as MoodTrackingModel).toJson(),
      ),
    );
    log((mood as MoodTrackingModel).toJson().toString());
    log(response.statusCode.toString());
    log(headers.toString());
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return TrackMoodSuccess();
    } else {
      throw ServerException();
    }
  }
}
