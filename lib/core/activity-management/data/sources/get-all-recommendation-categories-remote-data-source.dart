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
import '../models/recommendation-category-model.dart';

abstract class GetAllRecommendationCategoriesRemoteDataSource {
  Future<List<RecommendationCategoryModel>> getAllCategories();
}

class GetAllRecommendationCategoriesRemoteDataSourceImpl
    implements GetAllRecommendationCategoriesRemoteDataSource {
  final http.Client client;

  GetAllRecommendationCategoriesRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<RecommendationCategoryModel>> getAllCategories() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(
        APIRoute.getAllRecommendationCategories,
      ),
      headers: header,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final rawCategories = jsonDecode(response.body) as List;
      return rawCategories
          .map(
            (rawCategory) => RecommendationCategoryModel.fromJson(
              rawCategory as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
