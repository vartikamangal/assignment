import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey_started_success.dart';

abstract class PathOperationsRemoteDataSource {
  Future<List<JourneyModel>> getJourneys();
  Future<SuccessJourneyStart> startJourney({
    required JourneyModel? journey,
  });
}

class PathOperationsRemoteDataSourceImpl
    implements PathOperationsRemoteDataSource {
  final ApiClient? client;
  final Box? localClient;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  PathOperationsRemoteDataSourceImpl({
    required this.client,
    required this.localClient,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<JourneyModel>> getJourneys() async {
    final response = await client!.get(uri: APIRoute.getJourneyPathList);
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final rawJourneys = jsonDecode(response.body) as List;
    return rawJourneys
        .map((rawJourney) =>
            JourneyModel.fromJson(rawJourney as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SuccessJourneyStart> startJourney({JourneyModel? journey}) async {
    final response = await client!.post(
      uri: APIRoute.startJourney,
      body: jsonEncode(journey!.toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    try {
      /// For keeping a track of what path has user chosen
      /// Either SMALL_WINS or BIG_GOALS
      await localClient!.put(
        PersistenceConst.USER_SELECTED_PATH,
        journey.pathName,
      );
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
    return SuccessJourneyStart();
  }
}
