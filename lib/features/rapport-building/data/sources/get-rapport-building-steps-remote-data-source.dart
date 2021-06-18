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
import '../models/mood-model.dart';
import '../models/rapport-building-steps-model.dart';

abstract class GetRapportBuildingStepsRemoteDataSource {
  Future<RapportBuildingStepsModel> getRapportBuildingSteps({
    @required MoodModel mood,
  });
}

class GetRapportBuildingStepsRemoteDataSourceImpl
    implements GetRapportBuildingStepsRemoteDataSource {
  final http.Client remoteClient;

  GetRapportBuildingStepsRemoteDataSourceImpl({
    @required this.remoteClient,
  });
  @override
  Future<RapportBuildingStepsModel> getRapportBuildingSteps({
    @required MoodModel mood,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await remoteClient.post(
      Uri.parse(APIRoute.getRapportBuildingSteps),
      headers: header,
      body: jsonEncode(
        mood.toJson(),
      ),
    );
    await SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body) as Map;
      return RapportBuildingStepsModel.fromJson(
        jsonMap as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
