import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../domain/entites/journey_started_success.dart';
import '../models/journey-model.dart';

abstract class StartJourneyRemoteService {
  Future<SuccessJourneyStart> startJourney({@required JourneyModel journey});
}

class StartJourneyRemoteServiceImp implements StartJourneyRemoteService {
  final http.Client client;

  StartJourneyRemoteServiceImp({
    @required this.client,
  });
  @override
  Future<SuccessJourneyStart> startJourney({JourneyModel journey}) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.startJourney),
      headers: header,
      body: jsonEncode(journey.toJson()),
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return SuccessJourneyStart();
    } else {
      throw ServerException();
    }
  }
}
