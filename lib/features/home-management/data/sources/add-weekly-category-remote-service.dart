import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/data-source/api-client.dart';
import '../../../../core/data-source/throw-exception-if-response-error.dart';
import '../../../../core/activity-management/data/models/recommendation-category-model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';

abstract class AddWeeklyCategoryRemoteService {
  Future<Unit> addWeeklyCategory({
    required int? weekNumber,
    required RecommendationCategoryModel? category,
  });
  Future<Unit> addWeeklyActivity({
    required String? category,
    required String? recomendationId,
  });
}

class AddWeeklyCategoryRemoteServiceImpl
    implements AddWeeklyCategoryRemoteService {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  AddWeeklyCategoryRemoteServiceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<Unit> addWeeklyCategory({
    int? weekNumber,
    RecommendationCategoryModel? category,
  }) async {
    final body = jsonEncode(category!.toJson());
    final response = await client!.post(
      uri: '${APIRoute.addWeeklyCategory}${'$weekNumber'}',
      body: body,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return unit;
  }

  @override
  Future<Unit> addWeeklyActivity({
    String? category,
    String? recomendationId,
  }) async {
    final response = await client!.post(
      uri: '${APIRoute.addWeeklyActivity}${'/$category/$recomendationId'}',
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return unit;
  }
}
