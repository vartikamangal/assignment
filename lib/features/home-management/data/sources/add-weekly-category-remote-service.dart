import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/activity-management/data/models/recommendation-category-model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';

abstract class AddWeeklyCategoryRemoteService {
  Future<Unit> addWeeklyCategory({
    @required int weekNumber,
    @required RecommendationCategoryModel category,
  });
  Future<Unit> addWeeklyActivity({
    @required String category,
    @required String recomendationId,
  });
}

class AddWeeklyCategoryRemoteServiceImpl
    implements AddWeeklyCategoryRemoteService {
  final http.Client client;

  AddWeeklyCategoryRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<Unit> addWeeklyCategory({
    int weekNumber,
    RecommendationCategoryModel category,
  }) async {
    final uri = Uri.parse('${APIRoute.addWeeklyCategory}${'$weekNumber'}');
    final headers = await SessionManager.getHeader();
    final body = jsonEncode(
      category.toJson(),
    );
    final response = await client.post(
      uri,
      headers: headers,
      body: body,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addWeeklyActivity({
    String category,
    String recomendationId,
  }) async {
    final uri = Uri.parse(
        '${APIRoute.addWeeklyActivity}${'/$category/$recomendationId'}');
    log(uri.toString());
    final headers = await SessionManager.getHeader();
    final response = await client.post(
      uri,
      headers: headers,
    );
    log(response.body);
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
