import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/recommendation-category-model.dart';
import '../models/recommendation-model.dart';
import 'package:http/http.dart' as http;

abstract class GetCategoryActivitiesRemoteDataSource {
  Future<List<RecommendationModel>> getActivities({
    @required RecommendationCategoryModel category,
  });
}

class GetCategoryActivitiesRemoteDataSourceImpl
    implements GetCategoryActivitiesRemoteDataSource {
  final http.Client client;

  GetCategoryActivitiesRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<RecommendationModel>> getActivities({
    RecommendationCategoryModel category,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.getAllRecommendationsByCategory),
      headers: header,
      body: jsonEncode(
        category.toJson(),
      ),
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    //TODO Check why only one data is being shown as response
    if (response.statusCode == 200) {
      final rawActivities = jsonDecode(response.body) as List;
      return rawActivities
          .map(
            (rawActivity) => RecommendationModel.fromJson(
              rawActivity as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
