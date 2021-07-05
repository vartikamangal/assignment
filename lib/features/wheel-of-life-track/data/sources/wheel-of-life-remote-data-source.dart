import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rated-satisfaction-success.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/success-prioritize.dart';

abstract class WheelOfLifeRemoteDataSource {
  Future<List<LifeAreaModel>> getAreas();
  Future<RatingScaleModel> getRatingScale();
  Future<SuccessPrioritize> prioritize({
    required LifeAreaModelForPrioritization? lifeAreas,
  });
  Future<SuccessRatedSatisfaction> rateSatisfaction({
    required SatisfactionRatingsModel? ratings,
  });
}

class WheelOfLifeRemoteDataSourceImpl implements WheelOfLifeRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  WheelOfLifeRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<LifeAreaModel>> getAreas() async {
    final response = await client!.get(
      uri: APIRoute.getWolAreas,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return (jsonDecode(response.body) as List)
        .map((rawAreaJson) =>
            LifeAreaModel.fromJson(rawAreaJson as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<RatingScaleModel> getRatingScale() async {
    final response = await client!.get(
      uri: APIRoute.getRatingScale,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return RatingScaleModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<SuccessPrioritize> prioritize({
    LifeAreaModelForPrioritization? lifeAreas,
  }) async {
    final response = await client!.post(
      uri: APIRoute.prioritizeAreas,
      body: jsonEncode(lifeAreas!.toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return SuccessPrioritize();
  }

  @override
  Future<SuccessRatedSatisfaction> rateSatisfaction({
    SatisfactionRatingsModel? ratings,
  }) async {
    final response = await client!.post(
      uri: APIRoute.setUserSatisfaction,
      body: jsonEncode(ratings!.toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return SuccessRatedSatisfaction();
  }
}
