// Dart imports:
import 'dart:convert';

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
import '../models/recommendation-category-model.dart';

abstract class GetAllRecommendationCategoriesRemoteDataSource {
  Future<List<RecommendationCategoryModel>> getAllCategories();
}

class GetAllRecommendationCategoriesRemoteDataSourceImpl
    implements GetAllRecommendationCategoriesRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetAllRecommendationCategoriesRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<RecommendationCategoryModel>> getAllCategories() async {
    final response = await client.get(
      uri: APIRoute.getAllRecommendationCategories,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawCategories = jsonDecode(response.body) as List;
    return rawCategories
        .map(
          (rawCategory) => RecommendationCategoryModel.fromJson(
            rawCategory as Map<String, dynamic>,
          ),
        )
        .toList();

  }
}
