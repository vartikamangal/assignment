import 'dart:convert';
import 'dart:developer';

import 'package:flutter_sound/flutter_sound.dart';

import '../../../../core/data-source/api-client.dart';
import '../../../../core/data-source/throw-exception-if-response-error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../features/hub/data/models/hub-status-model.dart';
import '../../../../features/profile-screen/data/models/profile-data-model.dart';
import '../../../../features/profile-screen/data/models/question-log-model.dart';
import '../../../../features/rapport-building/data/models/mood-tracking-model.dart';

abstract class ProfileDetailsRemoteDataSource {
  /// supposed to provide [ProfileDataModel] when {statusCode : 200}
  /// throws [AuthException] for {statuscode : 401}
  /// throws [ServerException] for all the other statusCodes
  Future<ProfileDataModel> getBasicProfileDetails();

  /// supposed to provide [HubStatusModel] when {statusCode : 200}
  /// throws [AuthException] for {statuscode : 401}
  /// throws [ServerException] for all the other statusCodes
  Future<HubStatusModel> getProfileWheelOfLifeData();

  /// supposed to provide List of [MoodTrackingModel] when {statusCode : 200}
  /// throws [AuthException] for {statuscode : 401}
  /// or throws [ServerException] for all the other statusCodes
  Future<List<MoodTrackingModel>> getMoodLogs();

  /// supposed to provide List of [QuestionLogModel] when {statusCode : 200}
  /// throws [AuthException] for {statuscode : 401}
  /// or throws [ServerException] for all the other statusCodes
  Future<List<QuestionLogModel>> getProfileQuestions();
}

class ProfileDetailsRemoteDataSourceImpl
    implements ProfileDetailsRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  ProfileDetailsRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<ProfileDataModel> getBasicProfileDetails() async {
    final response = await client.post(
      uri: APIRoute.getBasicDetails,
    );
    log(response.statusCode.toString());
    log(response.body);
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return ProfileDataModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<List<MoodTrackingModel>> getMoodLogs() async {
    final _body = jsonEncode(["APP_OPEN", "ONBOARDING"]);
    final response = await client.post(
      uri: APIRoute.getMoodLogs,
      body: _body,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final responseBody = jsonDecode(response.body) as List;
    return responseBody
        .map(
          (rawMood) =>
              MoodTrackingModel.fromJson(rawMood as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<QuestionLogModel>> getProfileQuestions() async {
    final response = await client.post(
      uri: APIRoute.getQuestionLogs,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final responseBody = jsonDecode(response.body) as List;
    return responseBody
        .map(
          (rawQuestion) =>
              QuestionLogModel.fromJson(rawQuestion as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<HubStatusModel> getProfileWheelOfLifeData() async {
    final response = await client.get(
      uri: APIRoute.getProfileWolData,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return HubStatusModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
