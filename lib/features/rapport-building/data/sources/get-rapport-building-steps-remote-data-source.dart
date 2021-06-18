// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/mood-model.dart';
import '../models/rapport-building-steps-model.dart';

abstract class GetRapportBuildingStepsRemoteDataSource {
  Future<RapportBuildingStepsModel> getRapportBuildingSteps({
    @required MoodModel mood,
  });
}

class GetRapportBuildingStepsRemoteDataSourceImpl
    implements GetRapportBuildingStepsRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetRapportBuildingStepsRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<RapportBuildingStepsModel> getRapportBuildingSteps({
    @required MoodModel mood,
  }) async {
    final response = await client.post(
      uri: APIRoute.getRapportBuildingSteps,
      body: jsonEncode(
        mood.toJson(),
      ),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final jsonMap = jsonDecode(response.body) as Map;
    return RapportBuildingStepsModel.fromJson(
      jsonMap as Map<String, dynamic>,
    );
  }
}
