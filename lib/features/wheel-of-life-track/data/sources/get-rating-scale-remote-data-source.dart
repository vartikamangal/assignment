// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/rating-scale-model.dart';

abstract class GetRatingScaleRemoteDataSource {
  Future<RatingScaleModel> getRatingScale();
}

class GetRatingScaleRemoteDataSourceImpl
    implements GetRatingScaleRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetRatingScaleRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<RatingScaleModel> getRatingScale() async {
    final response = await client.get(
      uri: APIRoute.getRatingScale,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return RatingScaleModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
