import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
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
  final http.Client remoteClient;

  ProfileDetailsRemoteDataSourceImpl({
    @required this.remoteClient,
  });
  @override
  Future<ProfileDataModel> getBasicProfileDetails() async {
    final _headers = await SessionManager.getHeader();
    final _uri = Uri.parse(APIRoute.getBasicDetails);
    final response = await remoteClient.post(
      _uri,
      headers: _headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return ProfileDataModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoodTrackingModel>> getMoodLogs() async {
    final _headers = await SessionManager.getHeader();
    final _uri = Uri.parse(APIRoute.getMoodLogs);
    final response = await remoteClient.get(
      _uri,
      headers: _headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as List;
      return responseBody
          .map(
            (rawMood) =>
                MoodTrackingModel.fromJson(rawMood as Map<String, dynamic>),
          )
          .toList();
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<QuestionLogModel>> getProfileQuestions() async {
    final _headers = await SessionManager.getHeader();
    final _uri = Uri.parse(APIRoute.getQuestionLogs);
    final response = await remoteClient.get(
      _uri,
      headers: _headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as List;
      return responseBody
          .map(
            (rawQuestion) =>
                QuestionLogModel.fromJson(rawQuestion as Map<String, dynamic>),
          )
          .toList();
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HubStatusModel> getProfileWheelOfLifeData() async {
    final _headers = await SessionManager.getHeader();
    final _uri = Uri.parse(APIRoute.getProfileWolData);
    final response = await remoteClient.get(
      _uri,
      headers: _headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return HubStatusModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }
}
