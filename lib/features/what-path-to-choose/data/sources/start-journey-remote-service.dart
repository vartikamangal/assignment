// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
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
  final Box localClient;

  StartJourneyRemoteServiceImp({
    @required this.client,
    @required this.localClient,
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
      try {
        /// For keeping a track of what path has user chosen
        /// Either SMALL_WINS or BIG_GOALS
        await localClient.put(
          PersistenceConst.USER_SELECTED_PATH,
          journey.pathName,
        );
      } catch (e) {
        log(e.toString());
        throw CacheException();
      }
      return SuccessJourneyStart();
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }
}
