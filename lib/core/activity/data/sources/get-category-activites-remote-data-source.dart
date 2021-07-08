// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

import '../../../../core/routes/api-routes/api-routes.dart';
import '../models/recommendation-category-model.dart';
import '../models/recommendation-model.dart';

abstract class GetCategoryActivitiesRemoteDataSource {
  Future<List<RecommendationModel>> getActivities({
    required RecommendationCategoryModel? category,
  });
}

class GetCategoryActivitiesRemoteDataSourceImpl
    implements GetCategoryActivitiesRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  GetCategoryActivitiesRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<RecommendationModel>> getActivities({
    RecommendationCategoryModel? category,
  }) async {
    final response = await client!.post(
      uri: APIRoute.getAllRecommendationsByCategory,
      body: jsonEncode(
        category!.toJson(),
      ),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    //TODO Check why only one data is being shown as response
    final rawActivities = jsonDecode(response.body) as List;
    return rawActivities
        .map(
          (rawActivity) => RecommendationModel.fromJson(
            rawActivity as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
