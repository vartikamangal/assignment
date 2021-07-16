import 'dart:convert';
import 'dart:developer';

import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/feeling-duration-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/rapport-building-steps-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart';

abstract class RapportBuildingRemoteDataSource {
  Future<List<MoodModel>> getMoods();
  Future<List<FeelingDurationModel>> getAvailableDurations();
  Future<RapportBuildingStepsModel> getRapportBuildingSteps({
    required MoodModel? mood,
  });
  Future<MoodTrackingModel> setMood({
    required String? moodName,
    required String? activityType,
  });
  Future<SubjectInformationModel> setSubjectName({
    required String? name,
  });
  Future<TrackMoodSuccess> trackMood({
    required MoodTracking? mood,
  });
}

class RapportBuildingRemoteDataSourceImpl
    implements RapportBuildingRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  RapportBuildingRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<FeelingDurationModel>> getAvailableDurations() async {
    final response = await client!.get(
      uri: APIRoute.getDurationOptions,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final rawDurationList = jsonDecode(response.body) as List;
    final result = rawDurationList
        .map(
          (rawDuration) => FeelingDurationModel.fromJson(
              rawDuration as Map<String, dynamic>),
        )
        .toList();
    log(result.toString());
    return result;
  }

  @override
  Future<List<MoodModel>> getMoods() async {
    final response = await client!.get(
      uri: APIRoute.getMoods,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    log(response.body);
    final moods = (jsonDecode(response.body) as List)
        .map((moodRaw) => MoodModel.fromJson(moodRaw as Map<String, dynamic>))
        .toList();

    /// Move to entity!!
    /// Make a new Enity and Model --> Moods & MoodsModel
    moods.sort((a, b) => a.moodId!.compareTo(b.moodId!));
    return moods;
  }

  @override
  Future<RapportBuildingStepsModel> getRapportBuildingSteps(
      {MoodModel? mood}) async {
    final response = await client!.post(
      uri: APIRoute.getRapportBuildingSteps,
      body: jsonEncode(mood!.toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final jsonMap = jsonDecode(response.body) as Map;
    return RapportBuildingStepsModel.fromJson(jsonMap as Map<String, dynamic>);
  }

  @override
  Future<MoodTrackingModel> setMood(
      {String? moodName, String? activityType}) async {
    final response = await client!.post(
      uri: APIRoute.setMood,
      body: jsonEncode({
        "mood": moodName,
        "activityType": activityType,
      }),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final userMoodStatus = jsonDecode(response.body) as Map;
    return MoodTrackingModel.fromJson(userMoodStatus as Map<String, dynamic>);
  }

  @override
  Future<SubjectInformationModel> setSubjectName({String? name}) async {
    final response = await client!.post(
      uri: APIRoute.setSubjectName,
      body: jsonEncode(
        {
          "nickName": name,
        },
      ),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return SubjectInformationModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<TrackMoodSuccess> trackMood({MoodTracking? mood}) async {
    final response = await client!.post(
      uri: APIRoute.setMoodDuration,
      body: jsonEncode(
        (mood as MoodTrackingModel).toJson(),
      ),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return TrackMoodSuccess();
  }
}
