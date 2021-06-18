// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

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
  final http.Client client;

  GetJourneyPathListRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<JourneyModel>> getJourneys() async {
    final header = await SessionManager.getHeader();

    final response = await client.get(
      Uri.parse(APIRoute.getJourneyPathList),
      headers: header,
    );
    SessionManager.setHeader(
      header: response.headers,
    );

    if (response.statusCode == 200) {
      final rawJourneys = jsonDecode(response.body) as List;
      return rawJourneys
          .map(
            (rawJourney) =>
                JourneyModel.fromJson(rawJourney as Map<String, dynamic>),
          )
          .toList();
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }
}
