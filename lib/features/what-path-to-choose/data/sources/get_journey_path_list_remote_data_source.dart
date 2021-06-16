// Dart imports:
import 'dart:convert';
import 'dart:developer';

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
import '../models/journey-model.dart';

abstract class GetJourneyPathListRemoteDataSource {
  Future<List<JourneyModel>> getJourneys();
}

class GetJourneyPathListRemoteDataSourceImpl
    implements GetJourneyPathListRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetJourneyPathListRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<JourneyModel>> getJourneys() async {
    final response = await client.get(
      uri: APIRoute.getJourneyPathList,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawJourneys = jsonDecode(response.body) as List;
    return rawJourneys
        .map(
          (rawJourney) =>
              JourneyModel.fromJson(rawJourney as Map<String, dynamic>),
        )
        .toList();
  }
}
