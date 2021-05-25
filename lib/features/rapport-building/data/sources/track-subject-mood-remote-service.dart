import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../core/persistence-consts.dart';

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
    final sessionId = await sessionClient.get(PersistenceConst.CORE_DEVICE_ID);
    final response = await client.post(
      Uri.parse(APIRoute.setMoodDuration),
      headers: {
        "content-type": "application/json",
        "TATSAM_USER": '{"deviceIdentifier": "$sessionId"}',
      },
      body: jsonEncode((mood as MoodTrackingModel).toJson()),
    );
    if (response.statusCode == 200) {
      return TrackMoodSuccess();
    } else {
      throw ServerException();
    }
  }
}
